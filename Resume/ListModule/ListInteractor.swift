//
//  ListInteractor.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 24/2/2565 BE.
//

import Foundation

class ListInteractor {
    let repository: IResumeRepository
    
    init(repository: IResumeRepository) {
        self.repository = repository
    }
    
    func getAllResumes() -> [Resume] {
        return repository.getAllResumes()
    }
}
