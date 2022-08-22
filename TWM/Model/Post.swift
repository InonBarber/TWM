import Foundation
import Firebase

class Post: Hashable, Equatable{

    public var id: String? = ""
    public var title: String? = ""
    public var email: String? = ""
    public var description: String? = ""
    public var photo: String? = ""
    public var isPostDeleted: String? = ""


    var hashValue: Int { get { return id.hashValue } }

    
    init(){}

    init(post:PostDao){
        id = post.id
        title = post.title
        email = post.email
        description = post.description
        photo = post.photo
        isPostDeleted = post.isPostDeleted
    }
    
    static func ==(left:Post, right:Post) -> Bool {
        return left.id == right.id
    }
}

extension Post {
    static func FromJson(json:[String:Any])->Post{
        
        let p = Post()
        p.id = json["id"] as? String
        p.title = json["title"] as? String
        p.email = json["userName"] as? String
        p.description = json["description"] as? String
        p.photo = json["photo"] as? String
        p.isPostDeleted = json["isPostDeleted"] as? String

        return p

    }
    
    func toJson()->[String:Any]{
        
        var json = [String:Any]()
        
        json["id"] = self.id!
        json["title"] = self.title!
        json["email"] = self.email!
        json["description"] = self.description!
        json["photo"] = self.photo!
        json["isPostDeleted"] = self.isPostDeleted!
        return json
    }
    
}

