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
    
    func getResume(id: String) -> Resume? {
        return dataSource.get(id: id)
    }
    
    func createNewResume() -> Resume {
        var resume = Resume(id: UUID().uuidString)
        resume.updatedDate = Date()
        create(resume: resume)
        return resume
    }
    
    func save(resume: Resume) {
        var resume = resume
        resume.updatedDate = Date()
        update(resume: resume)
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
