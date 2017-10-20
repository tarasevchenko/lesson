//  Created by Тарас Евченко on 12.09.17.
//  Copyright © 2017 Тарас Евченко. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit


class RandomAdvice {
    var advices: [Advice] = [Advice]()
    func loadAdvices(completion:@escaping ([String:Any])->(Void)){
        
            let urlString = Settings.settings.censored
            print(urlString)
            guard let url = URL(string: urlString) else {
              
            return
            }

            URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let unwrappedData = data else {return}
            do {
                if  let jsonData =  try? JSONSerialization.jsonObject(with: unwrappedData) as? [String: Any] //серриализация данных
                {
                    print(jsonData!)
                    completion(jsonData!)
                }
                
            }
            }.resume()
    }
    
    
    
    func randomAdviceFromBase() -> String {
        let realm = try! Realm()
        let text = realm.objects(AdviceRealm.self)
        let textCount = realm.objects(AdviceRealm.self).count
        if textCount != 0 {
            let randomText = text[Int(arc4random_uniform(UInt32(text.count) - 1))]
            let adviceRandom = randomText.text
            return adviceRandom
        } else {
          
            return (randomAdviceFavourites())
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
