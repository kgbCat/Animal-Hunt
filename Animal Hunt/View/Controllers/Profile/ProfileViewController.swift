//
//  ProfileViewController.swift
//  Animal Hunt
//
//  Created by Anna Delova on 4/27/22.
//

import UIKit

class ProfileViewController: UIViewController {

    var presenter: ProfilePresenter?

    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var numOfAnimalsCoughtLbl: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var goalLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ProfilePresenter()
//        presenter?.setUserInfo(profilePhoto, nameLabel, goalLbl, numOfAnimalsCoughtLbl)

    }
    override func viewWillAppear(_ animated: Bool) {
        presenter?.setUserInfo(profilePhoto, nameLabel, goalLbl, numOfAnimalsCoughtLbl)
    }

    @IBAction func didTapImageView(_ sender: UITapGestureRecognizer) {
        launchCamera()
    }

    @IBAction func saveBtnTapped(_ sender: UIButton) {

    }

    private func launchCamera() {

        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            present(photoPicker, animated: false)
            return
        }

        present(cameraPicker, animated: false)
    }

    func userSelectedPhoto(photo: UIImage) {
        updateImage(photo)
//        DispatchQueue.global(qos: .userInitiated).async {
//            self.saveImage(photo)
//        }
    }

    private func updateImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.profilePhoto.image = image
        }
    }

    private func saveImage(_ image: UIImage) {
        // save to core data
        print("saved")
        presenter?.saveImageToCoreData(image)

    }

}
