//
//  onboardSecondViewController.swift
//  thesupremehacks
//
//  Created by Victor Kalil on 10/4/20.
//

import UIKit

class onboardSecondViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
setUpButton()
        // Do any additional setup after loading the view.
    }
    func setUpButton(){
        nextButton.layer.cornerRadius = 20
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
