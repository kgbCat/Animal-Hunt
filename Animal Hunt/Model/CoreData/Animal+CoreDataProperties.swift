//
//  Animal+CoreDataProperties.swift
//  Animal Hunt
//
//  Created by Anna Delova on 5/14/22.
//
//

import Foundation
import CoreData


extension Animal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Animal> {
        return NSFetchRequest<Animal>(entityName: "Animal")
    }

    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var user: User?

}

extension Animal : Identifiable {

}
