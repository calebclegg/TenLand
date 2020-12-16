//
//  LoginViewController.swift
//  TENLANDPM
//
//  Created by Caleb Clegg on 15/12/2020.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func naaTapped(_ sender: Any) {
        
        let registerViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.registerViewController) as? RegisterViewController
         
         view.window?.rootViewController = registerViewController
         view.window?.makeKeyAndVisible()
        
        
    }
    
    

}
