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
    var userDefaults = UserDefaults.standard
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    private var userUid: String {
        get {
            if let uid = userDefaults.string(forKey: "UserUID") {
                return uid
            } else {
                return ""
            }
        }
        set {
            userDefaults.set(newValue, forKey: "UserUID")
        }
    }
    
    func createAccount(email: String,
                       password: String,
                       username: String,
                       completion: @escaping (Error?) -> ()
    ) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if error == nil {
                if let result = result {
                    self?.userUid = result.user.uid
                    let ref = Database.database().reference().child("users")
                    ref.child(result.user.uid).updateChildValues(["name" : username])
                    ref.child(result.user.uid).updateChildValues(["email" : email])
                    
                    self?.saveInUserDefaults(userInfo: UserInfo(name: username, email: email))
                    completion(nil)
                }
            } else {
                completion(error)
            }
        }
    }
    
    func signIn(email: String,
                password: String,
                completion: @escaping (Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if error == nil {
                if let result = result {
                    self?.userUid = result.user.uid
                    self?.fetchUserInfo(for: result.user.uid, complition: { info, cat, error in
                        if error == nil {
                            self?.saveInUserDefaults(userInfo: info)
                            self?.saveInUserDefaults(categories: cat)
                            completion(nil)
                        } else {
                            completion(error)
                        }
                    })
                }
            } else {
                completion(error)
            }
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
    
    func saveCategoriesInDatabase(categories: [String]) {
        if userUid != "" {
            let ref = Database.database().reference().child("users")
            ref.child(userUid).updateChildValues(["categories" : categories])
        }
    }
    
    func getFromUserDefaultsUserInfo() -> UserInfo? {
        guard let info = userDefaults.object(forKey: "userInfo") as? Data else {
            return nil
        }
        guard let decodedInfo = try? decoder.decode(UserInfo.self, from: info) else {
            return nil
        }
        
        return decodedInfo
    }
    
    private func fetchUserInfo(for userId: String, complition: @escaping (UserInfo, [String], Error?) -> ()) {
        var userInfo = UserInfo()
        var categories: [String] = []
        
        let data = Database.database().reference(withPath: "users")
        data.child(userId).child("name").getData { error, data in
            if error == nil {
                if let data = data {
                    let name = data.value as? String
                    userInfo.name = name
                }
            } else {
                complition(userInfo, categories, error)
            }
        }
        data.child(userId).child("email").getData { error, data in
            if error == nil {
                if let data = data {
                    let email = data.value as? String
                    userInfo.email = email
                }
            } else {
                complition(userInfo, categories, error)
            }
        }
        data.child(userId).child("categories").getData { error, data in
            if error == nil {
                if let data = data {
                    let cat = data.value as? [String]
                    categories = cat ?? []
                    complition(userInfo, categories, nil)
                }
            } else {
                complition(userInfo, categories, error)
            }
        }
    }
    private func saveInUserDefaults(userInfo: UserInfo) {
        guard let encoded = try? encoder.encode(userInfo) else { return }
        userDefaults.set(encoded, forKey: "userInfo")
    }
    private func saveInUserDefaults(categories: [String]) {
        userDefaults.set(categories, forKey: "SavedCategories")
    }
}
