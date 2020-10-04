//
//  profileViewController.swift
//  thesupremehacks
//
//  Created by Victor Kalil on 10/3/20.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class profileViewController: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var milestoneLabel: UILabel!
    @IBOutlet weak var updateProfile: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let userID = (Auth.auth().currentUser?.uid)!
        print("current user :"+userID)
        // Do any additional setup after loading the view.
        setUpProfile()
    }
    @IBAction func updateProfilePressed(_ sender: Any) {
        setUpProfile()
    }
    func setUpProfile(){
        updateProfile.layer.cornerRadius = 20
        let db = Firestore.firestore()
        let userID = Auth.auth().currentUser?.uid
        
        let blah = db.collection("users").document(userID!)
        blah.getDocument { (document, error) in
            if let document = document, document.exists {
               // let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                
                let userState = document.data()!["state"]! as? String ?? "None"
                let userEmail = document.data()!["email"]! as? String
                let userAgeRange = document.data()!["age"]! as? String ?? "None"
                let userVoteCount = document.data()!["voteCount"]! as? Int
                
                self.emailLabel.text = "Account Email: "+userEmail!
                self.stateLabel.text = "State: "+userState
                self.ageLabel.text = "Age Range: "+userAgeRange
                self.voteCountLabel.text = "\(String(describing: userVoteCount!)) cases!"
                
                
                print(userVoteCount)
                print(type(of: userVoteCount))
               let voteCountValue = Int(userVoteCount!) ?? 0
                if voteCountValue >= 0 {
                    self.milestoneLabel.text = "Contemplative Civilian"
                }else if voteCountValue > 3 {
                    self.milestoneLabel.text = "Admirable Amicus"
                }else if voteCountValue > 6 {
                    self.milestoneLabel.text = "Judicial Junior"
                }else if voteCountValue > 9 {
                    self.milestoneLabel.text = "Jubilant Justice"
                }else if voteCountValue > 12 {
                    self.milestoneLabel.text = "Supreme Supreme"
                }else if voteCountValue > 15 {
                    self.milestoneLabel.text = "Ginsburg's Greatest"
                }
            }else {
                print("Document does not exist")
            }
        }
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}
