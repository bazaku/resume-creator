//
//  UIViewController+Alert.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 25/2/2565 BE.
//

import Foundation
import UIKit

extension UIViewController {
    func displayError(text: String, responder: UIResponder? = nil) {
        let alertController = UIAlertController(title: nil, message: text, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { _ in
            responder?.becomeFirstResponder()
        }))
        present(alertController, animated: true)
    }
}
