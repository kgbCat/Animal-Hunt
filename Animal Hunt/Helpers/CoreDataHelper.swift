//
//  CoreDataPresenter.swift
//  Animal Hunt
//
//  Created by Anna Delova on 5/12/22.
//

import UIKit

class CoreDataHelper{

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func getUser(secretWord: String) -> User? {
        var returnedUser: User?
        do {
            let users = try context.fetch(User.fetchRequest())
            users.forEach { [weak self] user in
                guard self != nil else { return }
                if user.secretWord == secretWord {
                    returnedUser = user
                } else {
                    // ALERT
                    returnedUser = nil
                }
            }
        } catch {
            // error
        }
        return returnedUser
    }

    func createUser(name: String,
                    secretWord: String,
                    goal: String,
                    avatar: Data) {
        let newUser = User(context: context)
        newUser.name = name
        newUser.avatar = avatar
        newUser.goal = goal
        newUser.secretWord = secretWord

        do {
            try context.save()
        } catch {
            // error
        }
    }

    func deleteUser(user: User) {
        context.delete(user)

        do {
            try context.save()

        } catch {
            // error
        }
    }

    func updateUser(user:  User,
                    newName: String,
                    newSecretWord: String,
                    newGoal: String,
                    newAvatar: Data) {
        user.name = newName
        user.secretWord = newSecretWord
        user.goal = newGoal
        user.avatar = newAvatar

        do {
            try context.save()
        } catch {
            // error
        }
    }

}

extension CoreDataHelper {

    func getAnimals(user: User) -> [Animal]? {
        var animals = [Animal]()
        do {
            let users = try context.fetch(User.fetchRequest())
            users.forEach { person in
                if person == user {
                    if let values =  person.animals?.allObjects as? [Animal] {
                        animals = values
                    }
                }
            }
        } catch {
            // error
        }
        return animals
    }


    func createAnimal(name: String, image: Data, user:  User) {
        let animal = Animal(context: context)
        animal.name = name
        animal.image = image
        user.addToAnimals(animal)

        do {
            try context.save()
        } catch {
            // error
        }
    }

    func deleteItem(item: Animal) {
        context.delete(item)

        do {
            try context.save()

        } catch {
            // error
        }
    }

    func updateItem(item:  Animal, newName: String) {
        item.name = newName

        do {
            try context.save()
        } catch {
            // error
        }
    }

    func addDrawing(_ animal: Animal, _ image: UIImage) {
        animal.drawing = image.pngData()

        do {
            try context.save()
        } catch {
            // error
        }
    }
}
