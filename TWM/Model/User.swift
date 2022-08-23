//
//  User.swift
//  TWM
//
//  Created by Inon Barber on 21/08/2022.
//

import Foundation
class User {
    
    public var firstName: String? = ""
    public var lastName: String? = ""
    public var email: String = ""
    public var phone: String? = ""
    public var posts: [String]?
    init(){}

}


extension User {
    static func FromJson(json:[String:Any])->User{
        let user = User()
        user.firstName = json["firstName"] as? String
        user.lastName = json["lastName"] as? String
        if let email = json["email"] as? String {
            user.email = email
        }        
        user.posts = json["posts"] as? [String]
        user.phone = json["phone"] as? String
        return user
    }
    
    func toJson()->[String:Any] {
        var json = [String:Any]()
        json["firstName"] = self.firstName
        json["lastName"] = self.lastName
        json["email"] = self.email
        json["posts"] = self.posts
        json["phone"] = self.phone
        return json
    }
}
