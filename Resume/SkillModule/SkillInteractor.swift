//
//  SkillInteractor.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 25/2/2565 BE.
//

import Foundation

class SkillInteractor {
    let repository: IResumeRepository
    var resume: Resume
    var skillName: String?
    
    init(repository: IResumeRepository, resume: Resume, skillName: String?) {
        self.repository = repository
        self.resume = resume
        self.skillName = skillName
    }
    
    func save(skillName newSkillName: String) {
        if let name = self.skillName, let index = resume.skills.firstIndex(of: name) {
            resume.skills[index] = newSkillName
        } else {
            resume.skills.append(newSkillName)
        }
        repository.save(resume: resume)
    }
}
