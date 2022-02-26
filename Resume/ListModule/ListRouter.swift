//
//  ListRouter.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 24/2/2565 BE.
//

import Foundation
import UIKit

class ListRouter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func routeToDetail(resume: Resume?, repository: IResumeRepository) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailViewController = storyboard.instantiateViewController(identifier: "detail") as? DetailViewController else {
            return
        }
        let interactor = DetailInteractor(resume: resume, repository: repository)
        let router = DetailRouter(viewController: detailViewController)
        let presenter = DetailPresenter(interactor: interactor, router: router)
        detailViewController.presenter = presenter
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
