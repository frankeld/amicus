//
//  ViewController.swift
//  thesupremehacks
//
//  Created by Victor Kalil on 10/2/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        spicePage()
        // Do any additional setup after loading the view.
    }
    func spicePage(){
        signUpButton.layer.cornerRadius = 20
        logoImage.layer.cornerRadius = 20
        logInButton.layer.cornerRadius = 20
    }
    
}

