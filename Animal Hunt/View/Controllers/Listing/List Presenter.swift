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
              let pngImage = image?.pngData()
        else { return }
        coreData
            .createAnimal(name: name, image: pngImage, user: Secret.shared.user)
    }
    func getAnimals(_ user: User) -> [Animal] {
        return coreData.getAnimals(user: user) ?? [Animal]()
    }
    func deleteAnimal(_ item:  Animal) {
        coreData.deleteItem(item: item)
    }
    func updateAnimal(item: Animal, newName: String ) {
        coreData.updateItem(item: item, newName: newName )
    }

    func presentEditAlert() -> UIAlertController {
        return UIAlertController(title: "New Name",
                                 message: "Enter new name",
                                 preferredStyle: .alert)
    }

    func presentDeleteAlert() -> UIAlertController {
        return UIAlertController(title: nil,
                                 message: "Are you sure you want to delete it? You can not restore it back",
                                 preferredStyle: .alert)
    }
}

