//
//  Company.swift
//  iosAssignment
//
//  Created by Luka Baljak on 9/19/19.
//  Copyright © 2019 Luka Baljak. All rights reserved.
//

import Foundation

public class Company:Decodable{
    
    var name:String
    var catchPhrase:String
    var bs:String
    
    init(name: String, catchPhrase: String, bs: String) {
        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
    }
    
    
    
}
