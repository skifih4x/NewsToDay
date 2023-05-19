//
//  ViewController.swift
//  ProjectName
//
//  Created by Andrey on dd.mm.yyyy.
//

import UIKit

class CustomViewController<V: CustomView>: UIViewController {
    override func loadView() {
        view = V()
    }
    
    var customView: V {
        return view as! V
    }
}
