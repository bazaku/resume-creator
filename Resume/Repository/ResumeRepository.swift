//
//  ResumeRepository.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 24/2/2565 BE.
//

import Foundation

class ResumeRepository: IResumeRepository {
    let dataSource: IResumeDataSource
    
    init(dataSource: IResumeDataSource) {
        self.dataSource = dataSource
    }
    
    func getAllResumes() -> [Resume] {
        return dataSource.getAll()
    }
    
    func save(resume: Resume) {
        if resume.id.isEmpty {
            create(resume: resume)
        } else {
            update(resume: resume)
        }
    }
    
    func delete(resume: Resume) {
        dataSource.delete(resume: resume)
    }
    
    private func create(resume: Resume) {
        dataSource.create(resume: resume)
    }
    
    private func update(resume: Resume) {
        dataSource.update(resume: resume)
    }
}
