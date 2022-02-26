//
//  EducationRouter.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 25/2/2565 BE.
//

import Foundation
import UIKit

class EducationRouter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func routeToDetail() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
