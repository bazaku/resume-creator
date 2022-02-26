//
//  DetailInteractor.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 24/2/2565 BE.
//

import Foundation
import UIKit

class DetailInteractor {
    let repository: IResumeRepository
    var resume: Resume
    
    init(resume: Resume?, repository: IResumeRepository) {
        self.repository = repository
        self.resume = resume ?? repository.createNewResume()
    }
    
    func reloadResume() {
        guard let resume = repository.getResume(id: resume.id) else { return }
        self.resume = resume
    }
    
    func getResume() -> Resume {
        return resume
    }
    
    func updatePhoto(_ url: String?) {
        resume.picture = url
        repository.save(resume: resume)
    }
    
    func updateTitle(_ title: String?) {
        resume.title = title
        repository.save(resume: resume)
    }
    
    func updateMobileNumber(_ mobileNumber: String?) {
        resume.mobileNumber = mobileNumber
        repository.save(resume: resume)
    }
    
    func updateEmailAddress(_ emailAddress: String?) {
        resume.emailAddress = emailAddress
        repository.save(resume: resume)
    }
    
    func updateResidenceAddress(_ residenceAddress: String?) {
        resume.residenceAddress = residenceAddress
        repository.save(resume: resume)
    }
    
    func updateCareerObjective(_ careerObjective: String?) {
        resume.careerObjective = careerObjective
        repository.save(resume: resume)
    }
    
    func deleteCompany(_ company: Company) {
        guard let index = resume.workSummary.firstIndex(of: company) else {
            return
        }
        resume.workSummary.remove(at: index)
        repository.save(resume: resume)
    }
    
    func deleteSkill(_ skill: String) {
        guard let index = resume.skills.firstIndex(of: skill) else {
            return
        }
        resume.skills.remove(at: index)
        repository.save(resume: resume)
    }
    
    func deleteEducation(_ education: Education) {
        guard let index = resume.educations.firstIndex(of: education) else {
            return
        }
        resume.educations.remove(at: index)
        repository.save(resume: resume)
    }
    
    func deleteProject(_ project: Project) {
        guard let index = resume.projects.firstIndex(of: project) else {
            return
        }
        resume.projects.remove(at: index)
        repository.save(resume: resume)
    }
}
