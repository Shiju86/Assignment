//
//  Person+CoreDataProperties.swift
//  Tricog-Wikipedia-Example
//
//  Created by Igniva-Ios-Yogesh on 08/08/18.
//  Copyright © 2018 Shiju. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var title: String?
    @NSManaged public var descriptions: String?
    @NSManaged public var thumbnail: String?

}
