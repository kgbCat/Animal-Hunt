//
//  MainViewController.swift
//  Animal Hunt
//
//  Created by Anna Delova on 4/28/22.
//

import UIKit

class MainViewController: UIViewController {

    var presenter: MainPresenter?
    var isChecked = false

    @IBOutlet weak var secretWordTxtFld: UITextField!
    @IBOutlet weak var huntButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainPresenter()
        presenter?.buttonIsdesabled(button: huntButton)
        configureTextFields()
    }


    @IBAction func didTapHunt(_ sender: UIButton) {

        if isChecked {
            print("checked")
            // navigate further
        } else {
            // alert
        }
    }

    @IBAction func goToRegister(_ sender: UIButton) {
        // navigate to register
    }

}

extension MainViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text {
            presenter?.buttonIsEnabled(button: huntButton)
            isChecked = ((presenter?.checkUser(word: text)) != nil)
        }
        return true
    }

    private func configureTextFields() {
        secretWordTxtFld?.delegate = self
        secretWordTxtFld?.returnKeyType = .done
        secretWordTxtFld?.autocapitalizationType = .words
        secretWordTxtFld?.autocorrectionType = .no
    }
}
