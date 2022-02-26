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
        dateFormatter.dateFormat = "dd MMMM yyyy HH:mm:ss"
        return interactor.getAllResumes().map {
            let title = $0.title ?? "Untitled resume"
            let updatedDate = dateFormatter.string(from: $0.updatedDate)
            return ListViewModel(title: title, updatedDate: updatedDate)
        }
    }
    
    func selectResume(index: IndexPath) {
        let resume = interactor.getAllResumes()[index.row]
        router.routeToDetail(resume: resume, repository: interactor.repository)
    }
    
    func createNewResume() {
        router.routeToDetail(resume: nil, repository: interactor.repository)
    }
}
