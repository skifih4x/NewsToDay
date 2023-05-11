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
    
    var userInfo = UserInfo()
    
    func createAccount(email: String,
                       password: String,
                       username: String
//                       completion: @escaping (AuthDataResult?, Error?) -> Void
    ) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            if error == nil {
                if let result = result {
                    let ref = Database.database().reference().child("users")
                    ref.child(result.user.uid).updateChildValues(["name" : username])
                    ref.child(result.user.uid).updateChildValues(["email" : email])
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
    
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) {error in
            if error == nil {
                print("Reset password completed")
            } else {
                let errString = String(error!.localizedDescription)
                print(errString)
            }
        }
    }
    
    func signOut() -> Bool {
        do {
            try Auth.auth().signOut()
            print("SignOut succeed")
            return true
        } catch {
            print("Oooops from signOut")
            return false
        }
    }
    
    func getUserInfo(userUid: String) -> UserInfo {
        let data = Database.database().reference(withPath: "users")
        var userInfo = UserInfo()
        data.child(userUid).child("name").getData { error, data in
            if error == nil {
                if let data = data {
                    let name = data.value as? String ?? "NoName"
                    userInfo.name = name
                    print("Hello, \(name)")
                }
            } else {
                print("Oooops from getUserInfo")
            }
        }
        data.child(userUid).child("email").getData { error, data in
            if error == nil {
                if let data = data {
                    let email = data.value as? String ?? "NoName"
                    userInfo.email = email
                    print("Your email, \(email)")
                }
            } else {
                print("Oooops from getUserInfo")
            }
        }
        return userInfo
    }
}
