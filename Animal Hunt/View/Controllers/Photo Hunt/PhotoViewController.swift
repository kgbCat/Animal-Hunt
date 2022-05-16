//
//  ViewController.swift
//  Animal Hunt
//
//  Created by Anna Delova on 4/27/22.
//

import UIKit
import CoreML
import Vision

class PhotoViewController: UIViewController {

    var presenter: PhotoPresenter?

    /// A predictor instance that uses Vision and Core ML to generate prediction strings from a photo.
    let imagePredictor = ImagePredictor()
    /// The largest number of predictions the main view controller displays the user.
    let predictionsToShow = 2
    var firstRun = true
    var name = String()

    // MARK: Main storyboard outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var predictionLabel: UILabel!

    @IBOutlet weak var retakePictureBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PhotoPresenter()
        launchCamera()

    }

    @IBAction func retakePhotoTapped(_ sender: Any) {
        launchCamera()
    }

    @IBAction func addDataList(_ sender: UIButton) {
        presenter?.addToDatabase(name, imageView.image)
        presentAlert()
    }

    private func presentAlert() {
        let alert = UIAlertController(title: nil, message: "Added to you Hunt List", preferredStyle: .alert)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 ) {
            alert.dismiss(animated: true)
        }
    }
    

    private func launchCamera() {
        // Show options for the source picker only if the camera is available.
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            present(photoPicker, animated: false)
            return
        }

        present(cameraPicker, animated: false)
    }

}

extension PhotoViewController {
    // MARK: Main storyboard updates
    /// Updates the storyboard's image view.
    func updateImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }

    /// Updates the storyboard's prediction label.
    func updatePredictionLabel(_ message: String) {
        DispatchQueue.main.async {
            self.predictionLabel.text = message
        }

        if firstRun {
            DispatchQueue.main.async {
                self.firstRun = false
                self.predictionLabel.superview?.isHidden = false
                self.retakePictureBtn.superview?.isHidden = false
            }
        }
    }
    /// Notifies the view controller when a user selects a photo in the camera picker or photo library picker.
    /// - Parameter photo: A photo from the camera or photo library.
    func userSelectedPhoto(_ photo: UIImage) {
        updateImage(photo)
        updatePredictionLabel("Making predictions for the photo...")

        DispatchQueue.global(qos: .userInitiated).async {
            self.classifyImage(photo)
        }
    }
}

extension PhotoViewController {
    // MARK: Image prediction methods
    /// Sends a photo to the Image Predictor to get a prediction of its content.
    /// - Parameter image: A photo.
    private func classifyImage(_ image: UIImage) {
        do {
            try self.imagePredictor.makePredictions(for: image,
                                                    completionHandler: imagePredictionHandler)
        } catch {
            print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
        }
    }

    /// The method the Image Predictor calls when its image classifier model generates a prediction.
    /// - Parameter predictions: An array of predictions.
    private func imagePredictionHandler(_ predictions: [Prediction]?) {
        guard let predictions = predictions else {
            updatePredictionLabel("No predictions. (Check console log.)")
            return
        }

        let formattedPredictions = formatPredictions(predictions)

        let predictionString = formattedPredictions.joined(separator: "\n")
        updatePredictionLabel(predictionString)
    }

    /// Converts a prediction's observations into human-readable strings.
    /// - Parameter observations: The classification observations from a Vision request.
    private func formatPredictions(_ predictions: [Prediction]) -> [String] {
        // Vision sorts the classifications in descending confidence order.
        let topPredictions: [String] = predictions.prefix(predictionsToShow).map { prediction in
            var name = prediction.classification

            // For classifications with more than one name, keep the one before the first comma.
            if let firstComma = name.firstIndex(of: ",") {
                name = String(name.prefix(upTo: firstComma))
            }
            self.name = name

            return "\(name) - \(prediction.confidencePercentage)%"
            
        }

        return topPredictions
    }
}

