import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var adviceButton: UIButton!
    @IBAction func randomButtonAdvice(_ sender: UIButton) {
   
        let adviceNew = RandomAdvice()
        let adviceRandom = adviceNew.randomAdvice()
        adviceLabel.text = adviceRandom

    }
    
    @IBAction func toFavourites(_ sender: UIButton) {
       
        let viewControllerTwo = storyboard?.instantiateViewController(withIdentifier: "ViewControllerTwo") as! ViewControllerTwo
            viewControllerTwo.favouritesAdvice = adviceLabel.text!
    //      DataAdvice.Advice.adviceToSave  = adviceLabel.text!
            present(viewControllerTwo, animated: true, completion: nil)
            }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adviceLabel.text = RandomAdvice().randomAdvice()
        //print(Realm.Configuration.defaultConfiguration)
        RandomAdvice().loadAdvices(completion: { (advices) -> (Void) in
            DispatchQueue.main.async {
                // update UI
            }
        })
          self.navigationItem.rightBarButtonItem = self.editButtonItem
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
