//
//  ListPresenter.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 24/2/2565 BE.
//

import Foundation

class ListPresenter {
    private let interactor: ListInteractor
    private let router: ListRouter
    
    init(interactor: ListInteractor, router: ListRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func getAllResume() -> [Resume] {
        return interactor.getAllResumes()
    }
    
    func selectResume(index: IndexPath) {
        let resume = interactor.getAllResumes()[index.row]
        router.routeToDetail(resume: resume, repository: interactor.repository)
    }
}
