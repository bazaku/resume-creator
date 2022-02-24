//
//  ListViewController.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 24/2/2565 BE.
//

import UIKit

class ListViewController: UIViewController {
    
    private var presenter: ListPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setUp() {
        let dataSource = SimpleDataSource()
        let repository = ResumeRepository(dataSource: dataSource)
        let interactor = ListInteractor(repository: repository)
        let router = ListRouter()
        presenter = ListPresenter(interactor: interactor, router: router)
    }

}
