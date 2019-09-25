//
//  Address.swift
//  iosAssignment
//
//  Created by Luka Baljak on 9/19/19.
//  Copyright © 2019 Luka Baljak. All rights reserved.
//

import Foundation

public class Address:Decodable{
    
    var street:String
    var suite:String
    var city:String
    var zipcode:String
    var geo:Geo
    
    init(street:String,suite:String, city:String,zipcode:String, geo:Geo) {
        
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.geo = geo
    }
    
    
    
}

