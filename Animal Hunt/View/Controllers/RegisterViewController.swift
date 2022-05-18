//
//  RegisterViewController.swift
//  Animal Hunt
//
//  Created by Anna Delova on 4/28/22.
//

import UIKit


class RegisterViewController: UIViewController {


    //MARK: Private Properties
    var presenter: RegisterPrsenter?

    var isFilled = false

    //MARK: IBOutlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var secretWordTextField: UITextField!
    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!


    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.setHidesBackButton(true, animated: true);
        presenter = RegisterPrsenter()
        configureTextFields()
        presenter?.setProfileImageView(image: profileImageView)
        presenter?.buttonIsdesabled(button: createButton)
    }

    @IBAction func didTapImageView(_ sender: UITapGestureRecognizer) {
        self.launchCamera()
    }

    //MARK: - IBActions
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
            DispatchQueue.main.async {
                self.showAlert()
            }
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
        DispatchQueue.global(qos: .userInitiated).async {
            self.saveImage(photo)
        }
    }

    private func updateImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.profileImageView.image = image
        }
    }

    private func saveImage(_ image: UIImage) {
        // save to core data
        print("saved")
    }
    
    private func showAlert(message: String = "We really need this info  for your Hunter ID") {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
        if !(presenter?.isFormFilled(textfields: [nameTextField, secretWordTextField, goalTextField]) == nil ){
            // alert
        }
        DispatchQueue.main.async {
            self.presenter?.buttonIsEnabled(button: self.createButton)

        }
        return true
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
