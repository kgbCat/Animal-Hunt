//
//  ProfilePresenter.swift
//  Animal Hunt
//
//  Created by Anna Delova on 5/12/22.
//

import UIKit

class ProfilePresenter {

    let coreData = CoreDataPresenter()
    var user: User?

    func setUserInfo(_ image: UIImageView, _ name: UILabel, _ goal: UILabel, _ count: UILabel) {
        guard
            let imgData = user?.avatar,
            let userName = user?.name,
            let userGoal = user?.goal,
            let userCount = user?.animals?.count
        else { return }
        image.image = UIImage(data: imgData)
        image.layer.cornerRadius = image.frame.size.height / 2
        image.clipsToBounds = true

        name.text = userName
        goal.text = userGoal
        count.text = String(userCount)
    }

    func getUserInfo(_ secretWord: String) {

        let user = coreData.getUser(secretWord: secretWord)
        self.user = user
    }

    

}
