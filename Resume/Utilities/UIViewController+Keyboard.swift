//
//  UIViewController+Keyboard.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 26/2/2565 BE.
//

import Foundation
import UIKit

extension UIViewController {
    func avoidKeyboard(scrollView: UIScrollView) {
        let contentInset = scrollView.contentInset
        let verticalScrollIndicatorInsets = scrollView.verticalScrollIndicatorInsets
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: .main) { notification in
            let info = notification.userInfo!
            let rect: CGRect = info[UIResponder.keyboardFrameBeginUserInfoKey] as! CGRect
            let kbSize = rect.size
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
            scrollView.contentInset = insets
            scrollView.verticalScrollIndicatorInsets = insets
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: .main) { notification in
            scrollView.contentInset = contentInset
            scrollView.verticalScrollIndicatorInsets = verticalScrollIndicatorInsets
        }
    }
}
