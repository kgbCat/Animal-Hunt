//
//  DrawingViewController.swift
//  Animal Hunt
//
//  Created by Anna Delova on 4/29/22.
//

import UIKit

final class DrawingViewController: UIViewController {

    //MARK: Private Properties
    private let colors: [UIColor] = [.red, .blue, .brown, .green, .black, .yellow, .cyan, .orange, .purple]
    private let cellId = Constants.collectionViewCell
    var animal = Animal()

    //MARK: IBOutlets
    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var collectionView: UICollectionView!


    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    //MARK: IBActions
    @IBAction func undoBtnTapped(_ sender: UIButton) {
        canvasView.unDo()
    }

    @IBAction func widthSliderChanched(_ sender: UISlider) {
        canvasView.strokeWidth = CGFloat(sender.value)

    }

    @IBAction func opacitySliderChanged(_ sender: UISlider) {
        canvasView.strokeOpacity = CGFloat(sender.value)
    }

    @IBAction func resetTapped(_ sender: UIButton) {
        canvasView.clearCanvas()
    }

    @IBAction func saveTapped(_ sender: UIButton) {
        let image = canvasView.takeScreenshot()
        canvasView.save(animal, image)
        showAlert(message: Constants.addToGallery)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

extension DrawingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        if let view = cell.viewWithTag(1) {
            view.backgroundColor = self.colors[indexPath.row]
            view.layer.cornerRadius = 12
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        canvasView.strokeColor = colors[indexPath.row]
    }
}
