//
//  Note.swift
//  NoteApp
//
//  Created by AnhLD on 9/10/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import Foundation
import RealmSwift

class Note: Object {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var content = ""
    @objc dynamic var time = Date()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(title: String, content: String, time: Date = Date()) {
        self.init()
        self.title = title
        self.content = content
        self.time = time
    }
}
