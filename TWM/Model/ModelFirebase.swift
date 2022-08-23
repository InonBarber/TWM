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

enum ModelErrors: Error {
    case documentNotExist
    case serverError
}

class ModelFirebase{
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    
    init(){}
    
    func getAllPosts(since:Int64, completion:@escaping ([Post])->Void){
        db.collection("Posts").getDocuments() { (querySnapshot, err) in
            var posts = [Post]()
            if let err = err {
                print("Error getting posts: \(err)")
                completion(posts)
            } else {
                for document in querySnapshot!.documents {
                    let p = Post.FromJson(json: document.data(), id: document.documentID)
                    posts.append(p)                    
                }
                
                completion(posts)
            }
        }
        
    }
    
    func getMyPosts(email:String, completion:@escaping ([Post]) -> Void){
        db.collection("Posts").whereField("userId", isEqualTo: email).getDocuments { (querySnapshot, err) in
            var posts = [Post]()
            if let err = err {
                print("Error getting posts: \(err)")
                completion(posts)
            } else {
                for document in querySnapshot!.documents {
                    let p = Post.FromJson(json: document.data(), id: document.documentID)
                    posts.append(p)
                }
                
                completion(posts)
            }
        }
    }
    func addPost(post:Post, completion:@escaping ()->Void){
        db.collection("Posts")
            .addDocument(data: post.toJson()) { error in
                if let error = error {
                    print("Error adding post: \(error.localizedDescription)")
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
        let id = String(post.id)
        let data = [
            "description": post.description!,
            "photo": post.photo!,
            "title": post.title!
        ]
        db.collection("Posts").document(id).updateData(data) { (error) in
            if error == nil {
                print("Post updated")
            }else{
                print("Post not updated")
            }
            completion()
        }
    }
    
    func deletePost(post:Post, completion:@escaping ()->Void){
        db.collection("Posts").document(post.id).delete() { err in
            if let err = err {
                print("Error deleting post: \(err)")
            } else {
                print("post deleted successfully")
            }
            completion()
        }
    }
    
    func uploadImage(image: UIImage, callback: @escaping (_ url:String)-> Void){
        let storageRef = storage.reference()
        let uuid = UUID().uuidString
        let imageRef = storageRef.child("images/\(uuid).jpg")
        let data = image.jpegData(compressionQuality: 0.8)
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        imageRef.putData(data!, metadata: metaData) { (metaData, error) in
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    return
                }
                callback(downloadURL.absoluteString)
            }
        }
    }

    
    
    //USER
     
     func getConnectedUser(completion:@escaping (Result<User, ModelErrors>)->Void) {
         let docRef = Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.email ?? "")
         docRef.getDocument {
             (document, error) in
             
             if let error = error {
                 print("TAG USER\(error)")
                 completion(.failure(.serverError))
                 return
             }
     
             guard let document = document, document.exists, let dataDescription = document.data() else {
                 print("Document does not exist")
                 completion(.failure(.documentNotExist))
                 return
             }
                                                    
             let user = User.FromJson(json: dataDescription)
             completion(.success(user))
         }
     }
     
     func addUser(user:User, completion:@escaping ()->Void){
         db.collection("Users").document(user.email)
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
     
     func checkIfUserLoggedIn(completion: @escaping (String?) -> Void){
         Auth.auth().addStateDidChangeListener { auth, user in
             completion(user?.email)
         }
     }
     
    
    func updatePost(postId: String, post: Post, completion: @escaping (Bool) -> Void) {
        db.collection("Posts")
            .document(postId)
            .setData(post.toJson()) { error in
                completion(error != nil)
            }
    }
     
     
     func checkIfUserExist(email: String ,completion: @escaping (_ success: User?)->Void){
         db.collection("Users").document(email).getDocument {
             (document, error) in
             
             guard let document = document, document.exists, let dataDescription = document.data() else {
                 print("Document does not exist")
                 completion(nil)
                 return
             }
                                                    
             let user = User.FromJson(json: dataDescription)
                                                    
             completion(user)
         }
     }
    
}

