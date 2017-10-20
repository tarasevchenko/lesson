//
//  ViewControllerSettings.swift
//  adviceWithCoreData
//
//  Created by Тарас Евченко on 19.10.17.
//  Copyright © 2017 Тарас Евченко. All rights reserved.
//

import UIKit
import Foundation

class ViewControllerSettings: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var pickerView: UIPickerView!
    
    let tagsAdvice = ["дизайнеру", "кодеру", "верстальщику", "фотографу", "копирайтеру", "маркетологу", "сеошнику", "водителю", "музыканту", "фокуснику", "врачу", "студенту", "за жизнь", "для него", "для неё"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tagsAdvice[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tagsAdvice.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let shareURLString = "http://fucking-great-advice.ru/api/random_by_tag/"
        let sharedTags = tagsAdvice[row]
        let urlAdvice : NSString = "\(shareURLString)\(sharedTags)" as NSString
        let url = urlAdvice.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        if url == nil {
            print ("url is nil")
        } else {
           let shareURL = url!
            if Settings.settings.useTags == true {
                Settings.settings.censored = shareURL
                print(Settings.settings.censored)
            } else {
            Settings.settings.censored = "http://fucking-great-advice.ru/api/random"
            }
           
        }
        
    }


    @IBAction func censorVersion(_ sender: UISwitch) {
        if sender.isOn {
            Settings.settings.censored = "http://fucking-great-advice.ru/api/random/censored/"
        } else {
            Settings.settings.censored = "http://fucking-great-advice.ru/api/random"
        }
        
    }
    
    
    @IBAction func useTagsOrNot(_ sender: UISwitch) {
        if sender.isOn {
            Settings.settings.useTags = true
        }
        else {
            Settings.settings.useTags = false
            Settings.settings.censored = "http://fucking-great-advice.ru/api/random"
        }
    }
    
    
    @IBAction func saveToBaseOrNot(_ sender: UISwitch) {
        
        if sender.isOn {
            Settings.settings.saveOrNot = true
        } else {
            Settings.settings.saveOrNot = false
        }
    }
}
public class Settings {
    
    static let settings = Settings()
    private init (){}
    var saveOrNot : Bool = false
    var useTags : Bool = false
    var censored  = "http://fucking-great-advice.ru/api/random"
    var tagsAdvices = ""
    
}
