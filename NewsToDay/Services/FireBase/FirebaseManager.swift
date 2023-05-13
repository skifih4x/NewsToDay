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
    
    func createAccount(email: String,
                       password: String,
                       username: String,
                       completion: @escaping (Error?) -> ()
    ) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error == nil {
                if let result = result {
                    let ref = Database.database().reference().child("users")
                    ref.child(result.user.uid).updateChildValues(["name" : username])
                    ref.child(result.user.uid).updateChildValues(["email" : email])
                    print("Create account complete. Name \(username) saved.")
                }
            }
            
            completion(error)
        }
    }
    
    func signIn(email: String,
                password: String,
                completion: @escaping (Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            completion(error)
        }
    }
    
    func resetPassword(email: String,
                       completion: @escaping (Error?) -> ()) {
        Auth.auth().sendPasswordReset(withEmail: email) {error in
            completion(error)
        }
    }
    
    func signOut(completion: @escaping () -> ()) {
        do {
            try Auth.auth().signOut()
            completion()
        } catch {

        }
    }
    
    func getUserInfo(userUid: String,
                     completion: @escaping (UserInfo, Error?) -> ()) {
        var userInfo = UserInfo()
        
        let data = Database.database().reference(withPath: "users")
        data.child(userUid).child("name").getData { error, data in
            if error == nil {
                if let data = data {
                    let name = data.value as? String
                    userInfo.name = name
                }
            } else {
                completion(userInfo, error)
            }
        }
        data.child(userUid).child("email").getData { error, data in
            if error == nil {
                if let data = data {
                    let email = data.value as? String
                    userInfo.email = email
                    completion(userInfo, error)
                }
            } else {
                completion(userInfo, error)
            }
        }
    }
}
