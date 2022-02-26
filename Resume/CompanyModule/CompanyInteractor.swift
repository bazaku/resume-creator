//
//  CompanyInteractor.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 25/2/2565 BE.
//

import Foundation

class CompanyInteractor {
    let repository: IResumeRepository
    var resume: Resume
    var company: Company
    
    init(repository: IResumeRepository, resume: Resume, company: Company?) {
        self.repository = repository
        self.resume = resume
        self.company = company ?? Company(id: UUID().uuidString,
                                          name: "",
                                          durationYear: 0,
                                          durationMonth: 0)
    }
    
    func save(companyName: String, durationYear: Int, durationMonth: Int) {
        company.name = companyName
        company.durationYear = durationYear
        company.durationMonth = durationMonth
        if let index = resume.workSummary.firstIndex(of: company) {
            resume.workSummary[index] = company
        } else {
            resume.workSummary.append(company)
        }
        repository.save(resume: resume)
    }
}
