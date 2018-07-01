//
//  User.swift
//  FireSwiffer
//
//  Created by Rob on 23.06.18.
//  Copyright © 2018 zero. All rights reserved.
//

import Foundation
import FirebaseAuth

struct FireUser {
    let uid: String
    let email: String
    
    init(userData: User) {
        uid = userData.uid
        if let email = userData.email {
            self.email = email
        } else {
            email = ""
        }
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}
