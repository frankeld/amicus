//
//  signUpViewController.swift
//  thesupremehacks
//
//  Created by Victor Kalil on 10/3/20.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class signUpViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    let years = ["","Under 15","15-20","20-25","25-30","30-35","35-40","40-45","45-50","50-55","55-60","60-65","65+"]
    let states = [ "","Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Iowa","Idaho","Illinois","Indiana","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Caronlina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Caronlina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming", "Puerto Rico", "American Samoa", "DC", "Micronesia", "Guam", "Marshall Islands", "Mariana Islands", "Palau", "Virgin Islands" ]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return states.count
        }
        else{
            return years.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1{
            return states[row]
        }
        else{
            return years[row]
        }
    }
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var statePicker: UIPickerView!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var agePicker: UIPickerView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        spicePage()
        statePicker.delegate = self
        statePicker.dataSource = self
        
        agePicker.delegate = self
        agePicker.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func spicePage() {
        errorLabel.alpha = 0
        signUpButton.layer.cornerRadius = 20
    }
    func safePassword(_ password : String) -> Bool{
        let isItGood = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{7,}")
        return isItGood.evaluate(with: password)
    }
    func fieldValidation() -> String? {
        if emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill all fields"
        }
        let thePassword = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if !safePassword(thePassword){
            return "Please check that your password has 7+ characters, a number, and a special character"
        }
        else{
            return nil
        }
    }
    
    func transitionToMain(){
        var tabBar = self.storyboard?.instantiateViewController(withIdentifier: Globals.Storyboard.tabVC) as! UITabBarController
        
        var appDelegate = UIApplication.shared.delegate as! AppDelegate
        view.window?.rootViewController = tabBar
    }
    
    // MARK: - Navigation
    
    @IBAction func signUpTapped(_ sender: Any) {
        let theError = fieldValidation()
        if theError != nil{
            self.problem(theError!)
        }else{
            let stateIn = statePicker.selectedRow(inComponent: 0)
            let ageIn = agePicker.selectedRow(inComponent: 0)
            //Create cleaned versions of first last etc
            let passworda = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let emaila = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            print(emaila)
            print(passworda)
            Auth.auth().createUser(withEmail: emaila, password: passworda){(result, err) in
                
                if err != nil{
                    self.problem("we have a problem")
                    
                    print(err)
                }
                else{
                    let db = Firestore.firestore()
                    
                    db.collection("users").document(result!.user.uid).setData(
                                                        ["email":emaila,
                                                         "uid": result!.user.uid,
                                                         "age": self.years[ageIn],
                                                         "state": self.states[stateIn],
                                                         "voteCount": 0])
                    {(error) in
                        if error != nil{
                            self.problem("couldn't make user")
                        }
                        
                    }
                    self.transitionToMain()
                }
                
                
            }
            
        }
        
    }
    
    func problem(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
}
