//
//  ProfilePresenter.swift
//  Animal Hunt
//
//  Created by Anna Delova on 5/12/22.
//

import UIKit

class ProfilePresenter {

    private let coreData = CoreDataHelper()

    func setUserInfo(_ image: UIImageView, _ name: UILabel, _ goal: UILabel, _ count: UILabel) {
        let user = Secret.shared.user
        if let imgData = user.avatar {
            image.image = UIImage(data: imgData)
            image.layer.cornerRadius = image.frame.size.height / 2
            image.clipsToBounds = true
        }
        name.text = user.name
        goal.text = user.goal
        count.text = (user.animals?.count.description)

    }

    func saveImageToCoreData(_ image: UIImage) {

    }
}
