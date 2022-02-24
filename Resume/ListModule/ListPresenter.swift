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
    
    func getAllResume() -> [ListViewModel] {
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = ""
        return interactor.getAllResumes().map {
            return ListViewModel(title: $0.title, updatedDate: dateFormatter.string(from: $0.updatedDate))
        }
    }
    
    func selectResume(index: IndexPath) {
        let resume = interactor.getAllResumes()[index.row]
        router.routeToDetail(resume: resume, repository: interactor.repository)
    }
}
