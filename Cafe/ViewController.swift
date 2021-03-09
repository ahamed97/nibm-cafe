//
//  ViewController.swift
//  Cafe
//
//  Created by dev on 3/8/21.
//  Copyright © 2021 dev. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var passowrd: UITextField!
    
    @IBAction func btnRegister(_ sender: UIButton) {
        let userEmail = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let userPwd = passowrd.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let userPhone = phone.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().createUser(withEmail: userEmail, password: userPwd) { authResult, error in
          if error != nil {
              
          }
          else
          {
              let db = Firestore.firestore()
              db.collection("Userinfo").addDocument(data: ["phone" :userPhone,"Userkey" : authResult!.user.uid ]) { (erro) in
                  if erro != nil
                  {
                     
                  }
                  else
                  {
                      let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

                          let  map = storyBoard.instantiateViewController(withIdentifier: "map") as! UITabBarController

                          self.navigationController?.pushViewController(map, animated: true)
                  }
              }
        }
    }
}
}

