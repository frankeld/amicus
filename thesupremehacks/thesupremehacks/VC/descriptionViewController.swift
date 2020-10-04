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
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func opinionChanged(_ sender: Any) {
        plantiff = !plantiff
    }
    @IBAction func submitOpinion(_ sender: Any) {
        let userID = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        let mainRef =  db.collection("cases").document(viewingCase)
        mainRef.updateData([
            "totalCount": FieldValue.increment(Double(1))
        ])
        let userOpinion = self.opinionBox.text
        mainRef.updateData([
            "opinions":FieldValue.arrayUnion([userID!])
        ])
        if(plantiff){
            mainRef.updateData(["plantiffCount": FieldValue.increment(Double(1))])
        }
        db.collection("users").document(userID!).updateData([
            "voteCount":FieldValue.increment(Double(1))
        ])
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
            } else {
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
