//
//  ProfileViewController.swift
//  Animal Hunt
//
//  Created by Anna Delova on 4/27/22.
//

import UIKit

class ProfileViewController: UIViewController {

    var presenter: ProfilePresenter?

    //MARK: -IBOutlets
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var numOfAnimalsCoughtLbl: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var goalLbl: UILabel!
    @IBOutlet weak var newSecretWordTxtFld: UITextField! {
        didSet {
            newSecretWordTxtFld?.delegate = self
            newSecretWordTxtFld?.returnKeyType = .done
            newSecretWordTxtFld?.autocapitalizationType = .words
            newSecretWordTxtFld?.autocorrectionType = .no
        }
    }
    @IBOutlet weak var saveButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ProfilePresenter()

    }

    override func viewWillAppear(_ animated: Bool) {
        presenter?.setUserInfo(profilePhoto, nameLabel, goalLbl, numOfAnimalsCoughtLbl)
    }

    // MARK: -IBActions
    @IBAction func didTapImageView(_ sender: UITapGestureRecognizer) {
        launchCamera()
    }

    @IBAction func saveBtnTapped(_ sender: UIButton) {

        // TODO: save to  data base, reload, show alert

        guard let name = nameLabel.text,
              let word = newSecretWordTxtFld.text,
              let goal =  goalLbl.text,
              let photo = profilePhoto.image
        else {
            DispatchQueue.main.async {
                self.presenter?.showAlert(message: "You haven't changed anything yet.")
            }
            return
        }
        DispatchQueue.main.async {
            self.presenter?.showAlert(message: "Saved Bro")
        }
        DispatchQueue.global(qos: .userInitiated).async {
            self.presenter?.saveToCoreData(photo, word, goal, name)
        }
    }

    @IBAction func signOutTapped(_ sender: UIBarButtonItem) {
        Secret.shared.deleteSecret()
        // unwind for login

        
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
    }

    private func updateImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.profilePhoto.image = image
        }
    }

}

extension ProfileViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let new = newSecretWordTxtFld.text {
            Secret.shared.updateSecret(new)
//            presenter?.buttonIsEnabled(button: saveButton)
        }
    }

}
