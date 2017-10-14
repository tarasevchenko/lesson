//
//  adviceModel.swift
//  lessonOneTestButton
//
//  Created by Тарас Евченко on 07.09.17.
//  Copyright © 2017 Тарас Евченко. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import Alamofire
import ObjectMapper

struct Advice {
    let id: String
    let text: String
    let stat: String
    let sound: String
}

class AdviceRealm: Object,Mappable{
    @objc dynamic var id = ""
    @objc dynamic var text = ""
    @objc dynamic var stat = ""
    @objc dynamic var sound = ""
    required convenience init?(map: Map) {
        self.init()
    }
    
    
    func mapping (map:Map) {
        id <- map["id"]
        text <- map["text"]
        stat <- map["stat"]
        sound <- map["sound"]

    }
}

class AdviceRealmFavourites: Object,Mappable{
    @objc dynamic var id = ""
    @objc dynamic var text = ""
   @objc dynamic var stat = ""
    @objc dynamic var sound = ""
    required convenience init?(map: Map) {
        self.init()
    }
    
    
    func mapping (map:Map) {
        id <- map["id"]
        text <- map["text"]
       stat <- map["stat"]
        sound <- map["sound"]
        
    }
}
