import Foundation
import RealmSwift
import UIKit


class RandomAdvice {
    // json
    var advices: [Advice] = [Advice]()
    //загрузка JSON с сервера
    func loadAdvices(completion:@escaping (Array<Advice>)->(Void))
    {
        let urlString = "http://fucking-great-advice.ru/api/latest/5"
        guard let url = URL(string: urlString) else {
            completion([Advice]())
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let unwrappedData = data else {return}
            do {
                if  let jsonData =  try? JSONSerialization.jsonObject(with: unwrappedData) as? [[String: Any]] //серриализация данных
                {
                    var advices = [Advice]()
                    for var jsonAdvice in jsonData! //поиск ключей в данных
                    {
                        let id = jsonAdvice["id"] as? String
                        let text = jsonAdvice["text"] as? String
                        let stat = jsonAdvice["stat"] as? String
                        let sound = jsonAdvice["sound"] as? String
                        
                        if let Id = id, let Text = text, let Stat = stat, let Sound = sound
                        {
                            let Id = Id as String, Text = Text as String, Stat = Stat as String, Sound = Sound as String
                            advices.append(Advice(id: Id, text: Text, stat: Stat, sound: Sound))
                            
                            let realm = try! Realm()      //запись в realm
                            try! realm.write ({
                                let saveRealm = AdviceRealm()
                                saveRealm.id = Id
                                saveRealm.text = Text
                                saveRealm.stat = Stat
                                saveRealm.sound = Sound
                                realm.add(saveRealm)
                            })
                            
                            
                        }
                        
                    }
                    completion(advices)
                }
                
            }
            }.resume()
    }
    
    
    
    
    func randomAdvice() -> String {
        let realm = try! Realm()
        let text = realm.objects(AdviceRealm.self)
        let randomText = text[Int(arc4random_uniform(UInt32(text.count) - 1))]
        let adviceRandom = randomText.text
        return adviceRandom
    }
    
}
