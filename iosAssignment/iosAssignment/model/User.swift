//
//  User.swift
//  iosAssignment
//
//  Created by Luka Baljak on 9/19/19.
//  Copyright © 2019 Luka Baljak. All rights reserved.
//

import Foundation

public class User:Decodable {
    
    var id:Int = 0
    var name:String = ""
    var username:String = ""
    var email:String = ""
    var address:Address = Address(street: "", suite: "", city: "", zipcode: "", geo: Geo(lat: "", lng: ""))
    var avatar:String = ""
    var phone:String = ""
    var website:String = ""
    var company:Company = Company(name: "", catchPhrase: "", bs: "")
    
    init(id: Int, name: String, username: String, email: String, address: Address, avatar: String, phone: String, website: String, company: Company) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.address = address
        self.avatar = avatar
        self.phone = phone
        self.website = website
        self.company = company
    }
    
    init() {
        
    }
    
}
