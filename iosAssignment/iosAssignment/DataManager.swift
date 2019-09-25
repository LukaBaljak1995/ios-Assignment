//
//  DataManager.swift
//  iosAssignment
//
//  Created by Luka Baljak on 9/19/19.
//  Copyright © 2019 Luka Baljak. All rights reserved.
//

import Foundation

let dataManager = DataManager(fileName:"name")

class DataManager{
    
    var fileName:String
    
    init(fileName:String) {
        self.fileName = fileName
    }
    
    public func getData()->[User]{
        
        if let path = Bundle.main.path(forResource: "iOS", ofType: "txt") {
            do {
                let string = try String(contentsOfFile: path, encoding: .utf8)
                let data = string.data(using: .utf8)!
                //print(data)
                
                do {
                    //dekodiranje JSONa
                    let decoder = JSONDecoder()
                    let model = try decoder.decode([User].self, from:
                        data) 
                    //print(model)
                   return model
                } catch let parsingError {
                    print("Error", parsingError)
                } 
            } catch {
                print(error)
            }
        }
        return []
    }
    
}
