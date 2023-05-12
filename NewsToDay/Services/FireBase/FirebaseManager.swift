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
    @objc optional func didSignOut()
    @objc optional func didResetPassword()
    @objc optional func userInfoSaved()
    func didFailError(error: Error)
}

final class FirebaseManager {
    static let shared = FirebaseManager()
    var delegate: FirebaseManagerDelegate?
    var userInfo = UserInfo()
    
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
                if let resetPasswordMethod = self.delegate?.didResetPassword {
                    resetPasswordMethod()
                }
            } else {
                self.delegate?.didFailError(error: error!)
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            if let signOutMethod = self.delegate?.didSignOut {
                signOutMethod()
            }
        } catch {
//            self.delegate?.didFailError(error: error!)
        }
    }
    
    func getUserInfo(userUid: String) {
        let data = Database.database().reference(withPath: "users")
        data.child(userUid).child("name").getData { error, data in
            if error == nil {
                if let data = data {
                    let name = data.value as? String ?? "NoName"
                    self.userInfo.name = name
                }
            } else {
                self.delegate?.didFailError(error: error!)
            }
        }
        data.child(userUid).child("email").getData { error, data in
            if error == nil {
                if let data = data {
                    let email = data.value as? String ?? "NoName"
                    self.userInfo.email = email
                    if let userInfoSavedMethod = self.delegate?.userInfoSaved {
                        userInfoSavedMethod()
                    }
                }
            } else {
                self.delegate?.didFailError(error: error!)
            }
        }
    }
}
