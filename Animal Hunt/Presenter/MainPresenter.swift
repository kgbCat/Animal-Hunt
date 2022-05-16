//
//  MainPresenter.swift
//  Animal Hunt
//
//  Created by Anna Delova on 5/12/22.
//

import UIKit

class MainPresenter {

    private let coreData = CoreDataPresenter()


    public func checkUser(word: String) -> Bool {
        coreData.isUserExist(secretWord: word) ? true : false
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
