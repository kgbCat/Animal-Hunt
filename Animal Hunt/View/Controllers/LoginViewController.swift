//
//  MainViewController.swift
//  Animal Hunt
//
//  Created by Anna Delova on 4/28/22.
//

import UIKit

class LoginViewController: UIViewController {

    var presenter = LoginPresenter()

    @IBOutlet weak var secretWordTxtFld: UITextField! {
        didSet {
            configureTextFields()
        }
    }
    @IBOutlet weak var huntButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
//        presenter = LoginPresenter()
//        presenter.buttonIsdesabled(button: huntButton)
    }


    @IBAction func didTapHunt(_ sender: UIButton) {
        guard let secretWord = secretWordTxtFld.text else { return }
        if presenter.checkUser(word: secretWord) {
            Secret.shared.secretWord = secretWord
            secretWordTxtFld.text = ""
            performSegue(withIdentifier: "onTabBar", sender: sender)
        } else {
            DispatchQueue.main.async {
                self.presenter.showAlert(message: "Buddy, you did it wrong. Try again!")
                self.secretWordTxtFld.text = ""
//                self.presenter?.buttonIsdesabled(button: self.huntButton)
            }
        }
    }

    @IBAction func goToRegister(_ sender: UIButton) {
        performSegue(withIdentifier: "onRegister", sender: sender)
    }

}

extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
//        if isFormFilled() {
//            presenter?.buttonIsEnabled(button: huntButton)
//        }
    }

    private func configureTextFields() {
        secretWordTxtFld?.delegate = self
        secretWordTxtFld?.returnKeyType = .done
        secretWordTxtFld?.autocapitalizationType = .words
        secretWordTxtFld?.autocorrectionType = .no
    }
    private func isFormFilled() -> Bool {
        guard
            secretWordTxtFld.text != ""
        else { return false }
        return true
    }
}
