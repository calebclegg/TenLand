//
//  RegisterViewController.swift
//  TENLANDPM
//
//  Created by Caleb Clegg on 15/12/2020.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var FirstNameTextField: UITextField!
    
    @IBOutlet weak var LastNameTextField: UITextField!
    
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var AgeTextField: UITextField!
    
    @IBOutlet weak var NumebrTextField: UITextField!

    @IBOutlet weak var SignUpBtn: UIButton!
    
    @IBOutlet weak var ErrorLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
        
        
        //setting up delegate text fields to only allow numbers
        NumebrTextField.delegate = self
        AgeTextField.delegate = self
        
    }
//Styles
    func setUpElements(){
        
        //hide error label
        ErrorLabel.alpha = 0
        
        //style elements
        //Utilities.styleTextField(FirstNameTextField)
        //Utilities.styleTextField(LastNameTextField)
        //Utilities.styleTextField(EmailTextField)
        //Utilities.styleTextField(PasswordTextField)
        //Utilities.styleTextField(AgeTextField)
        //Utilities.styleTextField(NumberTextField)
        
        Utilities.styleFilledButton(SignUpBtn)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     
     
    */
    
    //delegate text fields can only be numbers
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        if textField == NumebrTextField || textField == AgeTextField {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
        

    
    //check all fields & validate data is correctly formatted
    //if the format is not correct, ErrorLabel is displayed
    func validateFields() -> String? {
        
        //check all fields are not empty
        if FirstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            LastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            AgeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            NumebrTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
           
            //if any areas are empty, show an error
            return "Please fill in all fields"
            }
       
        //check password is secure
        let securePassword =  PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                
                    //check if the password matches the criteria in the "Utilities.swift" file
                if Utilities.isPasswordValid(securePassword) == false {
                    //password isn't secure enough
                    return "Please make sure your password is at least 6 characters, contains a special character and a number."
        }
    
        
        return nil
        
        }
    
    @IBAction func SignUpTapped(_ sender: Any) {
        
        //validate all fields
        let error = validateFields()
        
        if error != nil{
            
            //problem with fields, show error message
            showError(error!)
        }
        else {
            
            //create validated versions of data
            let firstName = FirstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = LastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let number = NumebrTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let age = AgeTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                // Check for errors
                if err != nil {
                    
                    // There was an error creating the user
                    self.showError("Email is not valid, must contain @**.com")
                }
                else {
                
                    // User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data:
                                                        ["FirstNameTextFields": firstName, "LastNameTextField": lastName, "EmailTextField": email, "AgeTextField": age, "NumeberTextField": number, "uid": result!.user.uid]) { (error) in
                        //if an error occurs, return an error message
                        if error != nil {
                            // Show error message
                            self.showError("Error saving user data")
                        }
                    }
                    
                    // Transition to the home screen
                    self.transitionToProfile()
                }
                
            }
        
        }
    }
    
    func showError(_ message:String) {
        ErrorLabel.text = message
        ErrorLabel.alpha = 1
    }
    
    func transitionToProfile() {
        
        let profileViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.profileViewController) as? ProfileViewController
         
         view.window?.rootViewController = profileViewController
         view.window?.makeKeyAndVisible()

    }
    
    @IBAction func haaTapped(_ sender: Any) {
        
        let loginViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginViewController) as? LoginViewController
         
         view.window?.rootViewController = loginViewController
         view.window?.makeKeyAndVisible()
        }
    
    

    }
  

