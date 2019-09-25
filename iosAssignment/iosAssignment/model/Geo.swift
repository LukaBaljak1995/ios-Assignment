//
//  Geo.swift
//  iosAssignment
//
//  Created by Luka Baljak on 9/19/19.
//  Copyright © 2019 Luka Baljak. All rights reserved.
//

import Foundation

public class Geo: Decodable{
    
    var lat:String
    var lng:String
    
    init(lat:String, lng:String) {
        self.lat = lat
        self.lng = lng
    }
    
}
