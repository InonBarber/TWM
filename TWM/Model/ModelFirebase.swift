//
//  ModelFirebase.swift
//  TWM
//
//  Created by Inon Barber on 21/08/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseCore
import FirebaseStorage
import UIKit
import FirebaseAuth


class ModelFirebase{
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    
    init(){}
    
    func getAllPosts(since:Int64, completion:@escaping ([Post])->Void){
        db.collection("Posts").whereField("lastUpdated", isGreaterThanOrEqualTo: Timestamp(seconds: since, nanoseconds: 0)).getDocuments() { (querySnapshot, err) in
            var posts = [Post]()
            if let err = err {
                print("Error getting posts: \(err)")
                completion(posts)
            } else {
                for document in querySnapshot!.documents {
                    let p = Post.FromJson(json: document.data())
                    posts.append(p)
                    completion(posts)
                }
            }
        }
        
    }
    
    func addPost(post:Post, completion:@escaping ()->Void){
        db.collection("Posts").document(post.id!)
            .setData(post.toJson())
        { err in
            if let err = err {
                print("Error adding post: \(err)")
            } else {
                print("post added with")
            }
            completion()
        }
    }
    
        func getUser(byId:String, completion:@escaping ([User])->Void){
            
            db.collection("Users").whereField("email", isEqualTo: byId)
                .getDocuments() { (querySnapshot, err) in
                    var users = [User]()
                    if let err = err {
                        print("Error \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            let user = User.FromJson(json: document.data())
                            users.append(user)
                            completion(users)
                        }
                        
                    }
                    
                }
            }
        
    
    func editPost(post:Post, completion:@escaping ()->Void){
        let id = String(post.id!)
        db.collection("Posts").document(id).updateData(    [
            "description": post.description!,
            "photo": post.photo!,
            "email": post.email!,
            "title": post.title!,
            "isPostDeleted": post.isPostDeleted!
            
        ]) { (error) in
            if error == nil {
                print("Post updated")
            }else{
                print("Post not updated")
            }
            completion()
        }
    }
    
    func deletePost(post:Post, completion:@escaping ()->Void){
        db.collection("Posts").document(post.id!).delete() { err in
            if let err = err {
                print("Error deleting post: \(err)")
            } else {
                print("post deleted successfully")
            }
            completion()
        }
    }
    
    func uploadImage(name: String, image: UIImage, callback: @escaping (_ url:String)-> Void){
        let storageRef = storage.reference()
        let imageRef = storageRef.child(name)
        let data = image.jpegData(compressionQuality: 0.8)
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        imageRef.putData(data!, metadata: metaData) { (metaData, error) in
            imageRef.downloadURL { (url, error) in
                let urlString = url?.absoluteString
                callback(urlString!)
            }
        }
    }

    
    
    //USER
     
     func getConnectedUser(completion:@escaping (User)->Void){
         let docRef = Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.email ?? "")
         docRef.getDocument {
             (document, error) in
             var user = User()
             if let error = error{
                 print("TAG USER\(error)")
                 completion(user)
             }
             else{
                 guard let document = document, document.exists else {
                     print("Document does not exist")
                     return
                 }
                 let dataDescription = document.data()
                 user = User.FromJson(json: dataDescription!)
                 completion(user)
             }
         }
     }
     
     func addUser(user:User, completion:@escaping ()->Void){
         db.collection("Users").document(user.email!)
             .setData(user.toJson())
         { err in
             if let err = err {
                 print("Error adding user: \(err)")
             } else {
                 print("user added with")
             }
             completion()
         }
     }
     
     
     func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
         Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
             if let user = authResult?.user {
                 completionBlock(true)
             } else {
                 print("TAG USER \(error)")
                 completionBlock(false)
             }
         }
     }
     
     func signIn(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
         Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
             if let error = error{
                 print("TAG USER \(error)")
                 completionBlock(false)
             } else {
                 completionBlock(true)
             }
         }
     }
     
     func signOut(completion: @escaping (_ success: Bool) -> Void){
         do {
             try Auth.auth().signOut()
             completion(true)
         } catch let signOutError as NSError {
             print("Error signing out:", signOutError)
             completion(false)
         }
     }
     
     func checkIfUserLoggedIn(completion:@escaping (_ success: Bool)->Void){
         Auth.auth().addStateDidChangeListener { auth, user in
             if user != nil{
                 completion(true)
             } else {
                 completion(false)
             }
         }
     }
     
     func updateUserPosts(user:User, posts: [String],  completion: @escaping ()->Void){
         let id = String(user.email!)
         db.collection("Users").document(id).updateData(    [
             "posts": posts
         ]) { (error) in
             if error == nil {
                 print("User posts updated")
             }else{
                 print("User posts not updated")
             }
             completion()
         }
     }
     
     
     func checkIfUserExist(email: String ,completion: @escaping (_ success: Bool)->Void){
         db.collection("Users").document(email).getDocument {
             (document, error) in
             guard let document = document, document.exists else {
                 print("User does not exist")
                 completion(false)
                 return
             }
             completion(true)
         }
     }
    
}

