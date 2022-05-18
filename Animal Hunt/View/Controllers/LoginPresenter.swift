//
//  MainPresenter.swift
//  Animal Hunt
//
//  Created by Anna Delova on 5/12/22.
//

import UIKit

class LoginPresenter {

    private let coreData = CoreDataHelper()

    public func checkUser(word: String) -> User?{
        coreData.getUser(secretWord: word)

    }

    public func buttonIsdesabled( button: UIButton) {
        button.isEnabled = false
        button.backgroundColor = .systemBlue
    }

    public func buttonIsEnabled( button: UIButton) {
        button.isEnabled = true
        button.backgroundColor = .systemPink
    }


}
