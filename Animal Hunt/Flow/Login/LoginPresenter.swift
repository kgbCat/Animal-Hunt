//
//  MainPresenter.swift
//  Animal Hunt
//
//  Created by Anna Delova on 5/12/22.
//

import UIKit

final class LoginPresenter: UIViewController {

    private let coreData = CoreDataHelper()

    public func checkUser(word: String) -> Bool {
        if coreData.getUser(secretWord: word) != nil {
            return true
        }
        return false
    }

    func showAlert(message: String = Constants.wrongSecret, controller: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
}
