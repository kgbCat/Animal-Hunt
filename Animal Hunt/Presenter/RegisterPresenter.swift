//
//  RegisterPresenter.swift
//  Animal Hunt
//
//  Created by Anna Delova on 5/12/22.
//

import UIKit


class RegisterPrsenter {

    private let coreData = CoreDataPresenter()


    public func registerNewHunter(name: String, word: String, goal: String, photo: UIImage ) {
        if let imgData = photo.pngData() {
            coreData.createUser(name: name, secretWord: word, goal: goal, avatar: imgData)
        }
    }

    public func buttonIsdesabled( button: UIButton) {
        button.isEnabled = false
        button.backgroundColor = .systemBlue
    }

    public func buttonIsEnabled( button: UIButton) {
        button.isEnabled = true
        button.backgroundColor = .systemPink
    }

    public func isFormFilled(textfields: [UITextField] )-> Bool {
        var isFilled = true
        textfields.forEach({ textfield in
            if textfield.text == ""{
                isFilled = false
            }
        })
        return isFilled
    }

    public func setProfileImageView(image: UIImageView) {
        image.image = UIImage(named: "icons8-профиль-кошки-100")
        image.layer.cornerRadius = image.frame.size.height / 2
        image.clipsToBounds = true
        image.layer.borderWidth =  2.0
        image.layer.borderColor = UIColor.white.cgColor
    }

}
