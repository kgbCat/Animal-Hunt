//
//  ArtViewPresenter.swift
//  Animal Hunt
//
//  Created by Anna Delova on 5/23/22.
//

import Foundation
import UIKit

final class ArtViewPresenter {
    private var coreData = CoreDataHelper()

    func getArts() -> [UIImage]? {
        var art = [UIImage]()
        if let user = coreData.getUser(secretWord: Secret.shared.secretWord) {
            let animals =  coreData.getAnimals(user: user)
            animals?.forEach({ animal in
                if let imgData = animal.drawing {
                    if let image = UIImage(data: imgData) {
                        art.append(image)
                    }
                }
            })
        }
        return art
    }
}
