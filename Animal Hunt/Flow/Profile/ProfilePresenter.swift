//
//  ProfilePresenter.swift
//  Animal Hunt
//
//  Created by Anna Delova on 5/12/22.
//

import UIKit

final class ProfilePresenter: UIViewController {

    private let coreData = CoreDataHelper()

    func setUserInfo(_ image: UIImageView, _ name: UILabel, _ goal: UILabel, _ count: UILabel) {
        guard let user = coreData.getUser(secretWord: Secret.shared.secretWord) else { return }
        if let imgData = user.avatar {
            image.image = UIImage(data: imgData)
            image.layer.cornerRadius = image.frame.size.height / 2
            image.clipsToBounds = true
        }
        name.text = user.name
        goal.text = user.goal
        count.text = (user.animals?.count.description)

    }

    func updatePhoto(_ photo: UIImage, _ name: String?, _ goal: String?, _ word: String?) {
        guard
            let imgData = photo.jpegData(compressionQuality: 1),
            let user = coreData.getUser(secretWord: Secret.shared.secretWord),
            let name = name,
            let word = word,
            let goal = goal
        else { return }
        coreData.updateUser(user: user, newName: name, newSecretWord: word, newGoal: goal, newAvatar: imgData)
    }

    func updateSecret(_ photo: UIImage, _ name: String?, _ goal: String?, _ word: String) {
        guard
            let imgData = photo.jpegData(compressionQuality: 1),
            let user = coreData.getUser(secretWord: Secret.shared.secretWord),
            let name = name,
            let goal = goal
        else { return }
        coreData.updateUser(user: user, newName: name, newSecretWord: word, newGoal: goal, newAvatar: imgData)
    }

    func saveToCoreData(_ image: UIImage, _ word: String, _ goal: String, _ name: String) {
        guard
            let imgData = image.jpegData(compressionQuality: 1),
            let user = coreData.getUser(secretWord: Secret.shared.secretWord)
        else { return }
        coreData.updateUser(user: user, newName: name, newSecretWord: word, newGoal: goal, newAvatar: imgData)
        print(user)
    }

    func showAlert(message: String, controller: UIViewController ) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
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
