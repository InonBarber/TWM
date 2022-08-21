//
//  Post_coreDataProperties.swift
//  TWM
//
//  Created by Inon Barber on 21/08/2022.
//

import Foundation
import CoreData


extension PostDao {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostDao> {
        return NSFetchRequest<PostDao>(entityName: "PostDao")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var email: String?
    @NSManaged public var description: String?
    @NSManaged public var photo: String?
    @NSManaged public var isPostDeleted: String?

}

extension PostDao : Identifiable {

}
