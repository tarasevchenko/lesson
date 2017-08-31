//
//  ViewController.swift
//  1234test
//
//  Created by Тарас Евченко on 29.08.17.
//  Copyright © 2017 Тарас Евченко. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionTap:UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var reset: UIButton!
    
    var tap = 0

    @IBAction func tapButton(_ sender: UIButton) {
       tap = tap + 1
        collectionTap.text =  "Нажатий - \(tap)"
        if tap > 10 {
            
        collectionTap.text = "Нажатий - \(tap) не надоело?"
        
        }
    if tap > 20 {
            collectionTap.text = "Нажатий - \(tap) совсем дурак?"
        }
        if tap > 30 {
            collectionTap.text = "Нажатий - \(tap) точно дурак!"
        }
    }
    @IBAction func resetbutton(_ sender: UIButton) {
        
        tap = 0
        if tap == 0 { collectionTap.text = "Нажми первый раз, это не страшно!)"
        
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

