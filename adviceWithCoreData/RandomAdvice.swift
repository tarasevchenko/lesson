//
//  adviceService.swift
//  lessonOneTestButton
//
//  Created by Тарас Евченко on 07.09.17.
//  Copyright © 2017 Тарас Евченко. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class RandomAdvice {
    //получение файла json
    var advices: [advice]! = [advice]()
    init() {
        advices = loadAdvices(fileName: "advices", ext: "json")
        
    }
    func loadAdvices(fileName : String, ext : String) -> [advice]
    {
        let path =  Bundle.main.path(forResource: fileName, ofType: ext)
        guard let resourcePath = path else  {
        return [advice]()
        }
            let url = URL(fileURLWithPath:resourcePath)
            guard let data = try? Data(contentsOf: url)
            else {
            return [advice]()
        }
        
        
 //парсинг
        if  let jsonData =  try? JSONSerialization.jsonObject(with: data) as? [[String: Any]]
        {
            var json = [advice]()
            for var jsonAdvice in jsonData!
            {
                let id = Int((jsonAdvice["identifier"] as? String)!)
                let text = jsonAdvice["text"] as? String
                let stat = Int((jsonAdvice["stat"] as? String)!)
                let sound = jsonAdvice["sound"] as? String
                
                if let Id = id, let Text = text, let Stat = stat, let Sound = sound
                {
                    let Id = Id as Int, Text = Text as String, Stat = Stat as Int, Sound = Sound as String
                    json.append(advice(id: Id, text: Text, state: Stat, sound: Sound))
                    print(json)
                    
                }
                
            }
            return json
        }
        
        return [advice]()
    }
    
    // получение рандомного совета
    func randomAdvice() -> String
    {
        let randomAdvice = Int(arc4random_uniform(UInt32(advices.count)))
        let randomAdvices = advices[randomAdvice].text
        return randomAdvices
        
    }
    
    
    }




