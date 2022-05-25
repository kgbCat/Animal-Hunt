//
//  RegisterViewController.swift
//  Animal Hunt
//
//  Created by Anna Delova on 4/28/22.
//

import UIKit


final class RegisterViewController: UIViewController {


    //MARK: Private Properties
    var presenter: RegisterPrsenter?


    //MARK: IBOutlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var secretWordTextField: UITextField!
    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!


    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = RegisterPrsenter()
        configureTextFields()
        presenter?.setProfileImageView(image: profileImageView)
        presenter?.buttonIsdesabled(button: createButton)
    }

    //MARK: IBActions
    @IBAction func didTapImageView(_ sender: UITapGestureRecognizer) {
        self.launchCamera()
    }

    @IBAction func didTapCreate(_ sender: UIButton) {
        self.registerNewHunter()
    }


    //MARK: - Private Methods
    private func registerNewHunter() {
        guard let name = nameTextField.text,
              let word = secretWordTextField.text,
              let goal =  goalTextField.text,
              let photo = profileImageView.image
        else {
            return
        }
        presenter?.registerNewHunter(name: name, word: word, goal: goal, photo: photo)
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
            self.profileImageView.image = image
        }
    }
}


extension RegisterViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            secretWordTextField.becomeFirstResponder()
            nameTextField.resignFirstResponder()
        case secretWordTextField:
            goalTextField.becomeFirstResponder()
            secretWordTextField.resignFirstResponder()
        case goalTextField:
            goalTextField.resignFirstResponder()
        default:
            textField.becomeFirstResponder()
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard
            nameTextField.text != "", secretWordTextField.text != "",
            goalTextField.text != ""
        else {
            return
        }
        DispatchQueue.main.async {
            self.presenter?.buttonIsEnabled(button: self.createButton)

        }
    }

    private func configureTextFields() {
        [nameTextField, secretWordTextField, goalTextField].forEach { [weak self] textField in
            guard let self = self else { return }
            textField?.delegate = self
            textField?.returnKeyType = .done
            textField?.autocapitalizationType = .words
            textField?.autocorrectionType = .no
        }
    }
}
