//
//  Firebase.swift
//  NewsToDay
//
//  Created by Andrey on 10.05.2023.
//

import UIKit
import Foundation
import Firebase

final class FirebaseManager {
    static let shared = FirebaseManager()
    
    func createAccount(email: String, password: String, username: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error == nil {
                if let result = result {
                    let ref = Database.database().reference().child("users")
                    ref.child(result.user.uid).updateChildValues(["name" : username])
                    print("Create account complete. Name \(username) saved.")
                }
            } else {
                let errString = String(error!.localizedDescription)
                print(errString)
            }
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error == nil {
                if let result = result {
                    let name = Database.database().reference(withPath: "users")
                    name.child(result.user.uid).child("name").getData { error, data in
                        if error == nil {
                            if let data = data {
                                let name = data.value as? String ?? "NoName"
//                                self.showAlert(title: "Sign In success!", message: "Hi, \(name)", closeScreen: true)
                                print("Hello, \(name)")
                            }
                        }
                    }
                }
            } else {
                let errString = String(error!.localizedDescription)
//                self.showAlert(title: "Error", message: errString)
                print(errString)
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            print("SignOut succeed")
        } catch {
            print("Oooops from signOut")
        }
    }
}
