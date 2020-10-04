//
//  descriptionViewController.swift
//  thesupremehacks
//
//  Created by Victor Kalil on 10/3/20.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class descriptionViewController: UIViewController {
    public var viewingCase = ""
    var plantiff = false
    @IBOutlet weak var caseName: UILabel!
    @IBOutlet weak var caseQuestion: UILabel!
    @IBOutlet weak var caseDocket: UILabel!
    @IBOutlet weak var choiceChooser: UISegmentedControl!
    @IBOutlet weak var submitFormButton: UIButton!
    @IBOutlet weak var viewMoreButton: UIButton!
    @IBOutlet weak var opinionBox: UITextField!
    
    var caseDescription = ""
    var caseFacts = ""
    var caseNotes = ""
    struct Case{
        // var cameIn = ""
        var description = ""
        var facts = ""
        var id = ""
        var title = ""
        init( descript: String, thefacts: String, theID: String, theTitle: String){
            //      self.cameIn = approvedDate ,,,,, approvedDate: String,
            self.description = descript
            self.facts = thefacts
            self.id = theID
            self.title = theTitle
        }
    }
    override func viewDidLoad() {
        getCase()
        super.viewDidLoad()
        print(viewingCase)
        let userID = (Auth.auth().currentUser?.uid)!
        print("current user :"+userID)
        getNotes()
        spicePage()
        // Do any additional setup after loading the view.
    }
    func spicePage(){
        viewMoreButton.layer.cornerRadius = 20
        submitFormButton.layer.cornerRadius = 20
//        self.caseName.layer.borderColor = #colorLiteral(red: 1, green: 0.72330755, blue: 0.5985606313, alpha: 1)
//        self.caseName.layer.borderWidth = 10
//        self.caseName.layer.margin
//        self.caseName.layer.cornerRadius = 20
    }
    @IBAction func opinionChanged(_ sender: Any) {
        plantiff = !plantiff
    }
    @IBAction func submitOpinion(_ sender: Any) {
        let userID = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        let mainRef =  db.collection("cases").document(viewingCase)
        
        //check to see if they've already submitted
        mainRef.collection("opinions").document(userID!).getDocument{ (document, err) in
            if let document = document, document.exists {
                //USER HAS SUBMITTED OPINION
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                
                let userOpinion = self.opinionBox.text
                let original = document.data()!["plaintiff"] as! Bool
                if(original && !self.plantiff){
                    
                    //if it was true before and now they want false
                    mainRef.collection("opinions").document(userID!).setData(["text" : userOpinion,
                                                                              "plaintiff": self.plantiff])
                    mainRef.updateData(["plantiffCount": FieldValue.increment(Double(-1))])
                    
                }
                if(!original && self.plantiff){
                    mainRef.collection("opinions").document(userID!).setData(["text" : userOpinion,
                                                                              "plaintiff": self.plantiff])
                    mainRef.updateData(["plantiffCount": FieldValue.increment(Double(1))])
                }
                
                mainRef.collection("opinions").document(userID!).setData(["text" : userOpinion,
                                                                          "plaintiff": self.plantiff])
                
                
            } else {
                //USER HAS NOT SUBMITTED OPINION
                mainRef.updateData([
                    "totalCount": FieldValue.increment(Double(1))
                ])
                print("Document does not exist")
                let userOpinion = self.opinionBox.text
                mainRef.collection("opinions").document(userID!).setData(["text" : userOpinion,
                                                                          "plaintiff": self.plantiff])
                if(self.plantiff){
                    mainRef.updateData(["plantiffCount": FieldValue.increment(Double(1))])
                }
                db.collection("users").document(userID!).updateData([
                    "voteCount":FieldValue.increment(Double(1))
                ])
            }
        }
        
        
    }
    
    func getCase(){
        let db = Firestore.firestore()
        let docRef = db.collection("cases").document(viewingCase)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                // print("Document data: \(dataDescription)")
                self.caseName.text = document.data()!["title"] as? String
                self.caseQuestion.text = document.data()!["question"] as? String
                self.caseDocket.text = "Docket "+self.viewingCase
                self.caseDescription = document.data()!["description"] as? String ?? "No additional description. Please click the link below to learn more!"
                self.caseFacts = document.data()!["facts"] as? String ?? "No additional facts. Please click the link below to learn more!"
            } else {
                print("Document does not exist")
            }
        }
    }
    func getNotes(){
        let db = Firestore.firestore()
        let mainRef =  db.collection("cases").document(viewingCase)
        
        //check to see if they've already submitted
        mainRef.getDocument{ (document, err) in
            if let document = document, document.exists {
                //USER HAS SUBMITTED OPINION
                
                
                let notes = document.data()!["override"] as? String ?? ""
                print(document.data()!["override"] as? String)
                if notes != ""{
                    self.caseNotes = notes
                    //if it was true before and now they want false
                    
                    
                }else{
                    self.caseNotes = "None for now. Feel free to check back another day for notes from either party."
                }
                
                
                
            } else {
                //USER HAS NOT SUBMITTED OPINION
            
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        
        //print("\(segue)")
        //  print("\(sender)")
        guard let mealDetailViewController = segue.destination as? factsViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        //  guard let selectedCaseCell = sender as? mainViewController else {
        //            fatalError("Unexpected sender: \(sender)")
        //       }
        
   //     guard let indexPath = caseTableView.indexPath(for: sender as! UITableViewCell) else {
   //         fatalError("The selected cell is not being displayed by the table")
   //     }
        
    //    let selectedCase = cases[indexPath.row].id
     //   print(selectedCase)
        //print("hi david")
        mealDetailViewController.displayDescription = caseDescription
        mealDetailViewController.displayFacts = caseFacts
        mealDetailViewController.caseDocket = viewingCase
        mealDetailViewController.partyNoteText = caseNotes
    }
    
}
