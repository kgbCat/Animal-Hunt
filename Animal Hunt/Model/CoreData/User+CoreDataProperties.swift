//
//  User+CoreDataProperties.swift
//  Animal Hunt
//
//  Created by Anna Delova on 5/25/22.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var avatar: Data?
    @NSManaged public var goal: String
    @NSManaged public var name: String
    @NSManaged public var secretWord: String
    @NSManaged public var animals: NSSet?

}

// MARK: Generated accessors for animals
extension User {

    @objc(addAnimalsObject:)
    @NSManaged public func addToAnimals(_ value: Animal)

    @objc(removeAnimalsObject:)
    @NSManaged public func removeFromAnimals(_ value: Animal)

    @objc(addAnimals:)
    @NSManaged public func addToAnimals(_ values: NSSet)

    @objc(removeAnimals:)
    @NSManaged public func removeFromAnimals(_ values: NSSet)

}

extension User : Identifiable {

}
