//
//  Student.swift
//  StudentApp
//
//  Created by Kely Sotsky on 06/04/2022.
//

import Foundation


class Student{
    var name = ""
    var id = ""
    var avatarUrl = ""
    
    init(name:String, id:String, avatarUrl:String){
        self.name = name
        self.id = id
        self.avatarUrl = avatarUrl
    }
}
