//
//  MainViewController.swift
//  Animal Hunt
//
//  Created by Anna Delova on 4/28/22.
//

import UIKit

final class LoginViewController: UIViewController {

    //MARK: Private Properties
    private let presenter = LoginPresenter()

    //MARK: IBOutlets
    @IBOutlet weak var secretWordTxtFld: UITextField! {
        didSet {
            configureTextFields()
        }
    }
    @IBOutlet weak var huntButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    //MARK: IBActions
    @IBAction func didTapHunt(_ sender: UIButton) {
        guard let secretWord = secretWordTxtFld.text else { return }
        if presenter.checkUser(word: secretWord) {
            Secret.shared.secretWord = secretWord
            secretWordTxtFld.text = ""
            performSegue(withIdentifier: Constants.onTabBar, sender: sender)
        } else {
            self.presenter.showAlert( controller: self)
            self.secretWordTxtFld.text = ""
        }
    }

    @IBAction func goToRegister(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.onRegister, sender: sender)
    }
}

extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {

    }

    private func configureTextFields() {
        secretWordTxtFld?.delegate = self
        secretWordTxtFld?.returnKeyType = .done
        secretWordTxtFld?.autocapitalizationType = .words
        secretWordTxtFld?.autocorrectionType = .no
    }
}
