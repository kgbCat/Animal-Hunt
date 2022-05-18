//
//  MainViewController.swift
//  Animal Hunt
//
//  Created by Anna Delova on 4/28/22.
//

import UIKit

class LoginViewController: UIViewController {

    var presenter: LoginPresenter?

    @IBOutlet weak var secretWordTxtFld: UITextField! {
        didSet {
            configureTextFields()
        }
    }
    @IBOutlet weak var huntButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LoginPresenter()
        presenter?.buttonIsdesabled(button: huntButton)
    }


    @IBAction func didTapHunt(_ sender: UIButton) {
        guard let secretWord = secretWordTxtFld.text else { return }
        

        if let user = presenter?.checkUser(word: secretWord) {
            Secret.shared.user = user
            secretWordTxtFld.text = ""
            performSegue(withIdentifier: "onTabBar", sender: sender)
        } else {
            self.showAlert(message: "Wrong credentials, please try again.")
            secretWordTxtFld.text = ""
            presenter?.buttonIsdesabled(button: huntButton)
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
        if isFormFilled() {
            presenter?.buttonIsEnabled(button: huntButton)
        }
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
    

    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
