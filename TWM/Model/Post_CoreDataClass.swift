//
//  Post_CoreDataClass.swift
//  TWM
//
//  Created by Inon Barber on 21/08/2022.
//

import Foundation
import CoreData
import UIKit

@objc(PostDao)
public class PostDao: NSManagedObject {
    
    static var context:NSManagedObjectContext? = { () -> NSManagedObjectContext? in
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }()
    
    static func getAllPosts()->[Post]{
        guard let context = context else {
            return []
        }

        do{
            
            let postDao = try context.fetch(PostDao.fetchRequest())
            var postArray:[Post] = []
            for pDao in postDao{
                postArray.append(Post(post:pDao))
            }
            return postArray
        }catch let error as NSError{
            print("post fetch error \(error) \(error.userInfo)")
            return []
        }
    }
    
    static func add(post:Post){
        guard let context = context else {
            return
        }
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        let post = PostDao(context: context)
        post.id = post.id
        post.title = post.title
        post.email = post.email
        post.description = post.description
        post.photo = post.photo
        post.isPostDeleted = post.isPostDeleted
        do{
            try context.save()
        }catch let error as NSError{
            print("post add error \(error) \(error.userInfo)")
        }
    }
    
    static func editPost(post:Post){
        guard let context = context else {
            return
        }
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        let post = PostDao(context: context)
        post.id = post.id
        post.title = post.title
        post.email = post.email
        post.description = post.description
        post.photo = post.photo
        post.isPostDeleted = post.isPostDeleted

        do{
            try context.save()
        }catch let error as NSError{
            print("post add error \(error) \(error.userInfo)")
        }
    }
    
    static func getPost(byId:String)->Post?{
        return nil
    }
    
    static func deletePost(post:Post){
        guard let context = context else {
            return
        }

        do{
            let postDao = try context.fetch(PostDao.fetchRequest())
            for pDao in postDao{
                if(pDao.id == post.id){
                    context.delete(pDao)
                }
            }
        }catch let error as NSError{
            print("post fetch error \(error) \(error.userInfo)")
        }
        
        do{
            try context.save()
        } catch {
            print("Didn't save post after deleting him.")
        }
    }
    
    static func localLastUpdated() -> Int64{
        return Int64(UserDefaults.standard.integer(forKey: "POSTS_LAST_UPDATE"))
    }
    
    static func setLocalLastUpdated(date:Int64){
        UserDefaults.standard.set(date, forKey: "POSTS_LAST_UPDATE")
    }
    
}
