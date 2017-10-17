//  Created by Тарас Евченко on 12.09.17.
//  Copyright © 2017 Тарас Евченко. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit


class RandomAdvice {
    var advices: [Advice] = [Advice]()
    func loadAdvices(completion:@escaping (Array<Advice>)->(Void)){
        
            let urlString = "http://fucking-great-advice.ru/api/random"
            guard let url = URL(string: urlString) else {
                completion([Advice]())
            return
            }

            URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let unwrappedData = data else {return}
            do {
                if  let jsonData =  try? JSONSerialization.jsonObject(with: unwrappedData) as? [String: Any] //серриализация данных
                {
                    var advices = [Advice]()
                    
                        let id = jsonData!["id"] as? String
                        let text = jsonData!["text"] as? String
                        let sound = jsonData!["sound"] as? String
                        
                        if let Id = id, let Text = text, let Sound = sound {
                            let Id = Id as String, Text = Text.replacingOccurrences(of: "&nbsp;", with: " ") as String, Sound = Sound as String
                            advices.append(Advice(id: Id, text: Text, sound: Sound))
                            
                            let realm = try! Realm()      //запись в realm
                            try! realm.write ({
                                let saveRealm = AdviceRealm()
                                saveRealm.id = Id
                                saveRealm.text = Text
                                saveRealm.sound = Sound
                                realm.add(saveRealm)
                            })
                            
                            
                        }
                        
                    
                    completion(advices)
                }
                
            }
            }.resume()
    }
    
    func randomAdviceInternet() -> String {
        let realm = try! Realm()
        let text = realm.objects(AdviceRealm.self)
        let textCount = realm.objects(AdviceRealm.self).count
        if textCount != 0 {
            let randomText = text[Int(arc4random_uniform(UInt32(text.count) - 1))]
            let adviceRandom = randomText.text
            return adviceRandom
        } else {
            
            randomAdviceFavourites()
            return ("from Favourites")
        }
        
    }
    func randomAdviceFavourites() -> String {
        let realm = try! Realm()
        let text = realm.objects(AdviceRealmFavourites.self)
        let textCount = realm.objects(AdviceRealmFavourites.self).count
        if textCount != 0 {
            let randomText = text[Int(arc4random_uniform(UInt32(text.count) - 1))]
            let adviceRandom = randomText.text
            return adviceRandom
        } else {
            
            return ("Error")
            
        }
        
    }
}
