//
//  AdviceStorage+CoreDataProperties.swift
//  adviceWithCoreData
//
//  Created by Тарас Евченко on 19.09.17.
//  Copyright © 2017 Тарас Евченко. All rights reserved.
//

import Foundation
import CoreData


extension AdviceStorage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AdviceStorage> {
        return NSFetchRequest<AdviceStorage>(entityName: "AdviceStorage")
    }

    @NSManaged public var advicesText: String?

}
