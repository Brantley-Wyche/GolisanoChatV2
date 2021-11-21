//
//  ViewController.swift
//  GolisanoChatV2
//
//  Created by GCCISAdmin on 11/21/21.
//

import UIKit

class ChatController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let didLogIn = UserDefaults.standard.bool(forKey: "login")
        
        if !didLogIn{
            
            let logC = LoginController()
            
            let nav = UINavigationController(rootViewController: logC)
            
            nav.modalPresentationStyle = .fullScreen
            
            present(nav, animated: false)
        }
    }
    
}

