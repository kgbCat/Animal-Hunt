//
//  CoreDataPresenter.swift
//  Animal Hunt
//
//  Created by Anna Delova on 5/12/22.
//

import UIKit

class CoreDataPresenter{

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func isUserExist(secretWord: String) -> Bool {
        var isChecked = false
        do {
            let users = try context.fetch(User.fetchRequest())
            users.forEach { [weak self] user in
                guard self != nil else { return }
                if user.secretWord == secretWord {
                    isChecked.toggle()
                }
            }
        } catch {
            // error
        }
        return isChecked
    }

    func getUser(secretWord: String) -> User? {
        var checkedUser: User?
        do {
            let users = try context.fetch(User.fetchRequest())
            users.forEach { [weak self] user in
                guard self != nil else { return }
                if user.secretWord == secretWord {
                    checkedUser = user
                } else {
                    // ALERT
                }
            }
            return checkedUser
        } catch {
            // error
            return nil
        }
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

    func deleteItem(user: User) {
        context.delete(user)

        do {
            try context.save()

        } catch {
            // error
        }
    }

    func updateItem(user:  User,
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

extension CoreDataPresenter {
    
    func getAllitems() -> [Animal]?  {
        
        do {
            let items = try context.fetch(Animal.fetchRequest())
            return items
        } catch {
            // error
            return nil
        }
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
}
