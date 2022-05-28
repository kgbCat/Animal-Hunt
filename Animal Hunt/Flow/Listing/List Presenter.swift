//
//  List Presenter.swift
//  Animal Hunt
//
//  Created by Anna Delova on 5/19/22.
//

import UIKit

class ListPresenter: UIViewController {

    let coreData = CoreDataHelper()

    func addToDatabase(_ name: String?, _ image: UIImage?) {
        guard let name = name,
              let pngImage = image?.pngData(),
              let user = coreData.getUser(secretWord: Secret.shared.secretWord)
        else { return }
        coreData
            .createAnimal(name: name, image: pngImage, user: user)
    }
    func getAnimals() -> [Animal] {
        var animals = [Animal]()
        if let user = coreData.getUser(secretWord: Secret.shared.secretWord) {
            animals = coreData.getAnimals(user: user) ?? [Animal]()
        }
        return animals
    }
    func deleteAnimal(_ item:  Animal) {
        coreData.deleteItem(item: item)
    }
    func updateAnimal(item: Animal, newName: String ) {
        coreData.updateItem(item: item, newName: newName )
    }

    func presentEditAlert() -> UIAlertController {
        return UIAlertController( title: nil, message: "Enter new name",
                                  preferredStyle: .alert)
    }

    func presentDeleteAlert() -> UIAlertController {
        return UIAlertController(title: nil,
                                 message: Constants.deleteMessage,
                                 preferredStyle: .alert)
    }
}

