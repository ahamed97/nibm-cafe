//
//  ViewController.swift
//  Cafe
//
//  Created by dev on 3/8/21.
//  Copyright © 2021 dev. All rights reserved.
//

import UIKit
import Firebase

class RegisterController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func BtnRegister(_ sender: UIButton) {
        if let email = email.text, let password = password.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                    let alert = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let db = Firestore.firestore()
                    db.collection("Userinfos").addDocument(data: ["phone" : self.phone.text ,"user_id" : authResult!.user.uid ,"user_email" : authResult!.user.email ]) { (error) in
                        if error != nil
                        {
                            
                        } else{
                            //Navigate to the ChatViewController
                            self.performSegue(withIdentifier: "RegisterToLocation", sender: self)
                        }
                    }
                }
            }
        }
    }
    

}
