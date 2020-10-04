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
    @IBOutlet weak var caseDescription: UITextView!
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var caseFacts: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFacts()
        // Do any additional setup after loading the view.
    }
    
    func setUpFacts(){
        caseDescription.text = displayDescription
        caseFacts.text = displayFacts
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
