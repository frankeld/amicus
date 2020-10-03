//
//  loginViewController.swift
//  thesupremehacks
//
//  Created by Victor Kalil on 10/3/20.
//

import UIKit
import FirebaseAuth

class loginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        spicePage()
        // Do any additional setup after loading the view.
    }
    
    func spicePage() {
        errorLabel.alpha = 0
        loginButton.layer.cornerRadius = 20
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func transitionToMain(){
        var tabBar = self.storyboard?.instantiateViewController(withIdentifier: Globals.Storyboard.tabVC) as! UITabBarController
        
        var appDelegate = UIApplication.shared.delegate as! AppDelegate
        view.window?.rootViewController = tabBar
    }
    @IBAction func loginTapped(_ sender: Any) {
        let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //sign in user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else{
             //   Globals.UserInfo.userID = result?.user.uid as! String
                
                self.transitionToMain()
            }
        }
    }
    
}
