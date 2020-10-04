//
//  factsViewController.swift
//  thesupremehacks
//
//  Created by Victor Kalil on 10/4/20.
//

import UIKit
import SafariServices

class factsViewController: UIViewController {
    public var displayDescription = ""
    public var displayFacts = ""
    public var caseDocket = ""
    public var partyNoteText = ""
    @IBOutlet weak var caseDescription: UITextView!
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var caseFacts: UITextView!
    @IBOutlet weak var partyNotes: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFacts()
        // Do any additional setup after loading the view.
    }
    
    func setUpFacts(){
        caseDescription.text = displayDescription
        caseFacts.text = displayFacts
        partyNotes.text = partyNoteText
        linkButton.layer.cornerRadius = 20
        caseDescription.layer.borderColor = #colorLiteral(red: 1, green: 0.72330755, blue: 0.5985606313, alpha: 1)
        caseFacts.layer.borderColor = #colorLiteral(red: 1, green: 0.72330755, blue: 0.5985606313, alpha: 1)
        partyNotes.layer.borderColor = #colorLiteral(red: 1, green: 0.72330755, blue: 0.5985606313, alpha: 1)
        caseDescription.layer.borderWidth = 3
        partyNotes.layer.borderWidth = 3
        caseFacts.layer.borderWidth = 3
        self.caseDescription.textContainerInset.bottom = 8
        self.caseDescription.textContainerInset.left = 8
        self.caseDescription.textContainerInset.right = 8
        self.caseDescription.textContainerInset.top = 8
        
        self.caseFacts.textContainerInset.bottom = 8
        self.caseFacts.textContainerInset.left = 8
        self.caseFacts.textContainerInset.right = 8
        self.caseFacts.textContainerInset.top = 8
        
        self.partyNotes.textContainerInset.bottom = 8
        self.partyNotes.textContainerInset.left = 8
        self.partyNotes.textContainerInset.right = 8
        self.partyNotes.textContainerInset.top = 8
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func articleLinkTapped(_ sender: Any) {
        if let url = URL(string: "https://www.oyez.org/cases/2020/"+caseDocket) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
            
        }
    }
    
}
