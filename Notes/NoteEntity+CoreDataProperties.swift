//
//  NoteEntity+CoreDataProperties.swift
//  Notes
//
//  Created by Mikhail Chuparnov on 23.12.2022.
//
//

import Foundation
import CoreData


extension NoteEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteEntity> {
        return NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
    }

    @NSManaged public var text: String?
    @NSManaged public var title: String?
    @NSManaged public var date: Date?

}

extension NoteEntity : Identifiable {

}
