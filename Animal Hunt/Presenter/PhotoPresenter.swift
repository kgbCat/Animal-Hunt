//
//  PhotoPresenter.swift
//  Animal Hunt
//
//  Created by Anna Delova on 5/12/22.
//

import Foundation
import UIKit

class PhotoPresenter {
    private let coreData = CoreDataPresenter()

    func addToDatabase(_ name: String?, _ image: UIImage?) {
        guard let name = name,
              let pngImage = image?.pngData(),
              let user = coreData.getUser(secretWord: Secret.shared.secretWord)
        else { return }
        coreData
            .createAnimal(name: name, image: pngImage, user: user)
    }
}
