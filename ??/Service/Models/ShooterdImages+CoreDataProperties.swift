//
//  ShooterdImages+CoreDataProperties.swift
//  
//
//  Created by Роман on 16.04.2022.
//
//

import Foundation
import CoreData


extension ShooterdImages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShooterdImages> {
        return NSFetchRequest<ShooterdImages>(entityName: "ShooterdImages")
    }

    @NSManaged public var img: Data?

}
