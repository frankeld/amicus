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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userID = (Auth.auth().currentUser?.uid)!
        print("current user :"+userID)
        // Do any additional setup after loading the view.
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
