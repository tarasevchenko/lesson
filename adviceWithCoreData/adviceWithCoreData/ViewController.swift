//  Created by Тарас Евченко on 12.09.17.
//  Copyright © 2017 Тарас Евченко. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var adviceButton: UIButton!
    
    @IBAction func randomButtonAdvice(_ sender: UIButton) {
        if Reachability().isInternetAvailable() == true {
            let adviceNew = RandomAdvice()
            let adviceRandom = adviceNew.randomAdviceInternet()
            adviceLabel.text = adviceRandom
        } else {
                let adviceNew = RandomAdvice()
                let adviceRandom = adviceNew.randomAdviceFavourites()
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
        
        if Reachability().isInternetAvailable() == true {
                RandomAdvice().loadAdvices(completion: { (advices) -> (Void) in
                    DispatchQueue.main.async {
                        self.adviceLabel.text = RandomAdvice().randomAdviceInternet()
                    }
                })
        } else {
                RandomAdvice().loadAdvices(completion: { (advices) -> (Void) in
                DispatchQueue.main.async {
                    self.adviceLabel.text = RandomAdvice().randomAdviceFavourites()
                }
            })
        }
        
        //print(Realm.Configuration.defaultConfiguration)
      
          self.navigationItem.rightBarButtonItem = self.editButtonItem
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
