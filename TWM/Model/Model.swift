//
//  Model.swift
//  TWM
//
//  Created by Inon Barber on 21/08/2022.
//

import Foundation
import UIKit
import CoreData

class ModelNotificatiponBase{
    let name:String
    init(_ name:String){
        self.name=name
    }
    func observe(callback:@escaping ()->Void){
        NotificationCenter.default.addObserver(forName: Notification.Name(name), object: nil, queue: nil){ data in
            NSLog("got notify")
            callback()
        }
    }
    
    func post(){
        NSLog("post notify")
        NotificationCenter.default.post(name: Notification.Name(name), object: self)
    }

}

class Model{


    let firebaseModel = ModelFirebase()
    let dispatchQueue = DispatchQueue(label: "com.Barber.TWM")

    // Notification center
    static let postDataNotification = ModelNotificatiponBase("com.Barber.TWM")
    
    static let instance = Model()
    
    func getAllPosts(completion:@escaping ([Post])->Void){
        //get the Local Last Update data
        var lup = PostDao.localLastUpdated()
        //fetch all updated records from firebase
        firebaseModel.getAllPosts(since: lup){ posts in
            //insert all records to local DB
            NSLog("TAG firebaseModel.getAllPosts in \(posts.count)")
            self.dispatchQueue.async{
                for post in posts {
                    NSLog("TAG post.title " + post.title!)
                    NSLog("TAG post.title " + post.isPostDeleted!)
                    PostDao.add(post: post)
                }
                //update the local last update date
                PostDao.setLocalLastUpdated(date: lup)
      
                DispatchQueue.main.async {
                    //return all records to caller
                    completion(PostDao.getAllPosts())

                }
            }
        }
        
    }
    
    func addPost(post:Post, completion: @escaping ()->Void){
        firebaseModel.addPost(post: post){
            completion()
            Model.postDataNotification.post()
        }
    }
    
    func getUser(byId:String,completion: @escaping ([User])->Void){
        firebaseModel.getUser(byId: byId){users in
            completion(users)
        }
    }
    
    
    func editPost(post:Post, completion:@escaping ()->Void){
        firebaseModel.editPost(post: post){
            completion()
            Model.postDataNotification.post()
        }
    }
    
    func delete(post:Post, completion:@escaping ()->Void){
        firebaseModel.deletePost(post: post){
            completion()
            Model.postDataNotification.post()
        }
    }
    
    func uploadImage(name:String, image:UIImage, callback:@escaping(_ url:String)->Void){
        firebaseModel.uploadImage(name: name, image: image, callback: callback)
    }
    
    
    func addUser(user:User, completion: @escaping ()->Void){
        firebaseModel.addUser(user: user){
            completion()
            Model.postDataNotification.post()
        }
    }
    
    func createUser(email: String, password: String, completion: @escaping (_ success: Bool)->Void){
        firebaseModel.createUser(email: email, password: password, completionBlock: completion)
    }
    
    func login(email: String, password: String, completion: @escaping (_ success: Bool)->Void){
        firebaseModel.signIn(email: email, password: password, completionBlock: completion)
    }
    
    func signOut(completion: @escaping (_ success: Bool)->Void){
        firebaseModel.signOut(completion: completion)
    }
    
    func getUserDetails(completion:@escaping (User)->Void){
        firebaseModel.getConnectedUser(completion: completion)
    }
    
    func checkIfUserLoggedIn(completion:@escaping (_ success: Bool)->Void){
        firebaseModel.checkIfUserLoggedIn(completion: completion)
    }

   func updateUserPosts(user:User, posts: [String] , completion: @escaping ()->Void){
        firebaseModel.updateUserPosts(user: user, posts: posts, completion: completion)
    }
    
    func checkIfUserExist(email:String,completion: @escaping (_ success: Bool)->Void){
           firebaseModel.checkIfUserExist(email: email, completion: completion)
    }
}

