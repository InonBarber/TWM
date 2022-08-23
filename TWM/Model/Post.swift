import Foundation
import Firebase

class Post: Hashable, Equatable {

    public var id: String = ""
    public var title: String? = ""
    public var description: String? = ""
    public var photo: String? = ""
    public var userId: String = ""

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(userId)
    }
    
    init(){}
    
    init(post:PostDao){
        id = post.id
        title = post.title
        description = post.description
        photo = post.photo
        userId = post.userId
        
    }
    
    static func ==(left:Post, right:Post) -> Bool {
        return left.id == right.id
    }
}

extension Post {
    static func FromJson(json:[String:Any], id: String)->Post{
        
        let p = Post()
        p.id = id
        if let userId = json["userId"] as? String {
            p.userId = userId
        }
        
        p.title = json["title"] as? String
        p.description = json["description"] as? String
        p.photo = json["photo"] as? String
        return p

    }
    
    func toJson()->[String:Any]{
        
        var json = [String:Any]()
                
        json["userId"] = self.userId
        
        if let title = self.title {
            json["title"] = title
        }
        
        if let description = self.description {
            json["description"] = description
        }
        
        if let photo = self.photo {
            json["photo"] = photo
        }
        
        json["lastUpdate"] = Date().timeIntervalSince1970
                                 
        return json
    }
    
}

