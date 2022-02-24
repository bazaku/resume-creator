//
//  ResumeRepository.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 24/2/2565 BE.
//

import Foundation

protocol IResumeDataSource {
    func getAll() -> [Resume]
    func create(resume: Resume)
    func update(resume: Resume)
    func delete(resume: Resume)
}

protocol IResumeRepository {
    func getAllResume() -> [Resume]
    func save(resume: Resume)
    func delete(resume: Resume)
}

class ResumeRepository: IResumeRepository {
    let dataSource: IResumeDataSource
    
    init(dataSource: IResumeDataSource) {
        self.dataSource = dataSource
    }
    
    func getAllResume() -> [Resume] {
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
