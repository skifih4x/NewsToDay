//
//  Firebase.swift
//  NewsToDay
//
//  Created by Andrey on 10.05.2023.
//

import UIKit
import Foundation
import Firebase

@objc protocol FirebaseManagerDelegate: AnyObject {
    @objc optional func didCreateUser()
    @objc optional func didSignIn()
//    func didSignOut()
    @objc optional func didResetPassword()
    func didFailError(error: Error)
}

final class FirebaseManager {
    static let shared = FirebaseManager()
    var delegate: FirebaseManagerDelegate?
    
    func createAccount(email: String,
                       password: String,
                       username: String
    ) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error == nil {
                if let result = result {
                    let ref = Database.database().reference().child("users")
                    ref.child(result.user.uid).updateChildValues(["name" : username])
                    ref.child(result.user.uid).updateChildValues(["email" : email])
                    print("Create account complete. Name \(username) saved.")
                    if let createUserMethod = self.delegate?.didCreateUser {
                        createUserMethod()
                    }
                }
            } else {
                self.delegate?.didFailError(error: error!)
            }
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error == nil {
                if let signInMethod = self.delegate?.didSignIn {
                    signInMethod()
                }
            } else {
                self.delegate?.didFailError(error: error!)
            }
        }
    }
    
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) {error in
            if error == nil {
                if let resetPassword = self.delegate?.didResetPassword {
                    resetPassword()
                }
            } else {
                self.delegate?.didFailError(error: error!)
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
