//
//  Sweet.swift
//  FireSwiffer
//
//  Created by Rob on 23.06.18.
//  Copyright © 2018 zero. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Sweet {
    let key: String
    let content: String
    let addedByUser:String
    let itemRef: DatabaseReference?
    
    init(content: String, addedByUser:String, key: String = "") {
        self.key = key
        self.content = content
        self.addedByUser = addedByUser
        self.itemRef = nil
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        itemRef = snapshot.ref
        
        if let value = snapshot.value as? [String: Any], let sweetContent = value["content"] as? String {
            content = sweetContent
        } else {
            content = ""
        }
        
        if let value = snapshot.value as? [String: Any], let sweetUser = value["addedByUser"] as? String {
            addedByUser = sweetUser
        } else {
            addedByUser = ""
        }
    }
    
    func toAny() -> Any {
        return ["content": content, "addedByUser": addedByUser]
    }
}
