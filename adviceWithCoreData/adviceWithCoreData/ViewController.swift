//  Created by Тарас Евченко on 12.09.17.
//  Copyright © 2017 Тарас Евченко. All rights reserved.
//

import UIKit
import RealmSwift
import Foundation
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    

    
    
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var adviceButton: UIButton!
    
    @IBAction func saveUserAdvice(_ sender: UIButton) {
        let viewControllerUserAdvice = storyboard?.instantiateViewController(withIdentifier: "ViewControllerUserAdvice") as! ViewControllerUserAdvice
        
        present(viewControllerUserAdvice, animated: true, completion: nil)

    }
    
   func localPush () {
    let action1 = UNNotificationAction(identifier: "action1", title: "дай совет!", options: UNNotificationActionOptions.foreground)
    let content = UNMutableNotificationContent()
    content.title = "Получи совет, Блять"
    content.subtitle = "Пора уже!"
    content.body = "Давненько не советовался!"
    content.categoryIdentifier = "myCategory"
    content.badge = 1
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    let request = UNNotificationRequest(identifier: "action1", content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    let category = UNNotificationCategory(identifier: "myCategory", actions: [action1], intentIdentifiers: [], options: [])
    UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "action1"{
            if Reachability().isInternetAvailable() == true {
                
                let adviceNew = RandomAdvice()
                let adviceRandom = adviceNew.randomAdviceFromBase()
                adviceLabel.text = adviceRandom
            } else {
                let adviceNew = RandomAdvice()
                let adviceRandom = adviceNew.randomAdviceFavourites()
                adviceLabel.text = adviceRandom
                
            }
            
        }
            else {
                print("error")
            }
        completionHandler()
        
        }
    

    
    @IBAction func randomButtonAdvice(_ sender: UIButton) {
        
        if Reachability().isInternetAvailable() == true {
           let saveOrNot = Settings.settings.saveOrNot
            
            
            print (saveOrNot)
            
            if saveOrNot == true {
            RandomAdvice().loadAdvices(completion: { (jsonData) -> (Void) in
                let id = jsonData["id"] as? String
                let text = jsonData["text"] as? String
                let sound = jsonData["sound"] as? String
                
                if let Id = id, let Text = text, let Sound = sound {
                    let Id = Id as String, Text = Text.replacingOccurrences(of: "&nbsp;&#151", with: " ") as String, Sound = Sound as String
                    
                    let realm = try! Realm()      //запись в realm
                    try! realm.write ({
                        let saveRealm = AdviceRealm()
                        saveRealm.id = Id
                        saveRealm.text = Text
                        saveRealm.sound = Sound
                        realm.add(saveRealm)
                    })
                    
                    
                }
                
                DispatchQueue.main.async {
                    
                    self.adviceLabel.text = text?.replacingOccurrences(of: "&nbsp;", with: " ")
                }
            })
            } else {
                RandomAdvice().loadAdvices(completion: { (jsonData) -> (Void) in
                    let text = jsonData["text"] as? String
                    
                    
                    DispatchQueue.main.async {
                        
                        self.adviceLabel.text = text?.replacingOccurrences(of: "&nbsp;", with: " ")
                    }
                })
            }
        
        
        
        
        } else {
                let adviceNew = RandomAdvice()
                let adviceRandom = adviceNew.randomAdviceFromBase()
                adviceLabel.text = adviceRandom

          }
        
    }

  
    
    
    @IBAction func toFavourites(_ sender: UIButton) {
       
        let viewControllerTwo = storyboard?.instantiateViewController(withIdentifier: "ViewControllerTwo") as! ViewControllerTwo
            viewControllerTwo.favouritesAdvice = adviceLabel.text!
            present(viewControllerTwo, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in })
        UNUserNotificationCenter.current().delegate = self
        
        if Reachability().isInternetAvailable() == true {
                RandomAdvice().loadAdvices(completion: { (jsonData) -> (Void) in
                    let text = jsonData["text"] as? String
                    
                    
                    DispatchQueue.main.async {
                        
                        self.adviceLabel.text = text?.replacingOccurrences(of: "&nbsp;", with: " ")
                    }
                })
        }
        else {
                RandomAdvice().loadAdvices(completion: { (jsonData) -> (Void) in
                DispatchQueue.main.async {
                    self.adviceLabel.text = RandomAdvice().randomAdviceFavourites()
                }
            })
        }
        
        print(Realm.Configuration.defaultConfiguration)
      
          self.navigationItem.rightBarButtonItem = self.editButtonItem
        // Do any additional setup after loading the view, typically from a nib.
    }
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

