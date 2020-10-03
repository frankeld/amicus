//
//  mainViewController.swift
//  thesupremehacks
//
//  Created by Victor Kalil on 10/3/20.
//

import UIKit
import FirebaseFirestore
class mainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var caseTableView: UITableView!
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
        var cases = [Case]()
    override func viewDidLoad() {
        super.viewDidLoad()
      
        caseTableView.delegate = self
        caseTableView.dataSource = self
        getCases()
        caseTableView.reloadData()
       // self.caseTableView.reloadData()
        // Do any additional setup after loading the view.
        
    }
    func getCases(){
        let db = Firestore.firestore()
      
        db.collection("cases").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                  //  print("\(document.documentID) => \(document.data())")
                    let documentID = String(document.documentID)
                    let factsIn = document.data()["facts"] as! String
                    let descriptionIn = document.data()["description"] as! String
                    let idIn = document.data()["id"] as! String
                    let titleIn = document.data()["title"] as! String
                    print("Reading "+titleIn)
                    let newCase = Case(descript: descriptionIn, thefacts: factsIn, theID: idIn, theTitle: titleIn)
                    self.cases.append(newCase)
                   
                    self.caseTableView.reloadData()
                    //print("Case ID "+c)
                    
                }
            }
        }
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("I'm right here! \(cases.count)")
        return cases.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let cell = tableView.dequeueReusableCell(withIdentifier: "CaseCell", for: indexPath)
     //   cell.textLabel!.text = cases[indexPath.row].title
     //   print("I'm right here! \(cases[indexPath.row].title)")//
        let thecase = cases[indexPath.row]
        
        let cell = caseTableView.dequeueReusableCell(withIdentifier: "CaseCell", for: indexPath)
        cell.textLabel?.text = thecase.title
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       var myIndex = indexPath.row
        print(myIndex)
        //performSegue(withIdentifier: "CaseDescription", sender: self)
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
