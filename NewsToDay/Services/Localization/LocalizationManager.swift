//
//  LocalizationManager.swift
//  NewsToDay
//
//  Created by Ilyas Tyumenev on 19.05.2023.
//

import Foundation
import UIKit
import SwiftUI

final class LocalizationManager {
    
    final class LocalizedViewObject {
        let key: String
        var updatingBlock: ((String, UIView) -> Void)? = nil
        
        init(key: String, updatingBlock: ((String, UIView) -> Void)?) {
            self.key = key
            self.updatingBlock = updatingBlock
        }
    }
    
    private var localizedBundle: Bundle = Bundle.main
    static let localizationManager: LocalizationManager = LocalizationManager()
    private let viewsMap: NSMapTable<UIView, LocalizedViewObject> = NSMapTable.weakToStrongObjects()
    
    init() {
        // get language code from UserDefaults or get default language
        // initialize NSBundle and other parameters
        if let currentLanguageCode = UserDefaults.standard.string(forKey: "CurrentLanguage") {
            if let languagePath = Bundle.main.path(forResource: currentLanguageCode, ofType: "lproj") {
                localizedBundle = Bundle(path: languagePath) ?? Bundle.main
            }
        }
    }
    
    // Support localizing
    func localizeView(_ key: String, view: UIView, updatingBlock: ((String, UIView) -> Void)? = nil) {
        let obj = LocalizedViewObject(key: key, updatingBlock: updatingBlock)
        updateView(view: view, obj: obj)        
        viewsMap.setObject(obj, forKey: view)
    }
    
    func localizeString(_ key: String, value: String = "", comment: String = "") -> String {
        // use NSLocalizeString to get a string by using NSBundle and whatever
        return NSLocalizedString(key, bundle: localizedBundle, value: value, comment: comment)
    }
    
    // Support update language on-the-fly
    func setLanguage(languageCode: String) {
        UserDefaults.standard.set(languageCode, forKey: "CurrentLanguage")
        if let languagePath = Bundle.main.path(forResource: languageCode, ofType: "lproj") {
            localizedBundle = Bundle(path: languagePath) ?? Bundle.main
        }
        
        let enumerator = viewsMap.keyEnumerator()
        
        // Update bundle, UserDefaults entry and other parameters
        while let view = enumerator.nextObject() as? UIView,
                let obj = viewsMap.object(forKey: view) as LocalizedViewObject? {
            updateView(view: view, obj: obj)
        }
    }
    
    private func updateView(view: UIView, obj: LocalizedViewObject) {
        let string = localizeString(obj.key)
        if obj.updatingBlock != nil {
            obj.updatingBlock?(string, view)
        } else if let button = view as? UIButton {
            button.setTitle(string, for: .normal)
        } else if let label = view as? UILabel {
            label.text = string
        } else if let textView = view as? UITextView {
            textView.text = string
        }
    }
}
