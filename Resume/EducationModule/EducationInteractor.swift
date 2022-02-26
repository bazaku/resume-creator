//
//  EducationInteractor.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 25/2/2565 BE.
//

import Foundation

class EducationInteractor {
    let repository: IResumeRepository
    var resume: Resume
    var education: Education
    
    init(repository: IResumeRepository, resume: Resume, education: Education?) {
        self.repository = repository
        self.resume = resume
        self.education = education ?? Education(id: UUID().uuidString,
                                                className: "",
                                                passingYear: 0,
                                                cgpa: 0)
    }
    
    func save(className: String, passingYear: Int, cgpa: Double) {
        education.className = className
        education.passingYear = passingYear
        education.cgpa = cgpa
        if let index = resume.educations.firstIndex(of: education) {
            resume.educations[index] = education
        } else {
            resume.educations.append(education)
        }
        repository.save(resume: resume)
    }
}
