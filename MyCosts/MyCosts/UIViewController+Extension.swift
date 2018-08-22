//
//  UIViewController+Extension.swift
//  sqlSimple
//
//  Created by Swift on 30/06/2018.
//  Copyright © 2018 Swift. All rights reserved.
//

import UIKit



extension UIViewController {
    
    
    func show(messege: String) {
        let alert = UIAlertController(title: nil, message: messege, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
        
    }
    
    
    
}
