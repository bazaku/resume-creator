//
//  ProjectInteractor.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 26/2/2565 BE.
//

import Foundation

class ProjectInteractor {
    let repository: IResumeRepository
    var resume: Resume
    var project: Project
    
    init(repository: IResumeRepository, resume: Resume, project: Project?) {
        self.repository = repository
        self.resume = resume
        self.project = project ?? Project(id: UUID().uuidString,
                                          name: "",
                                          teamSize: -1,
                                          projectSummary: "",
                                          technologyUsed: "",
                                          role: "")
    }
    
    func save(name: String, teamSize: Int, projectSummary: String, role: String, technologyUsed: String) {
        project.name = name
        project.teamSize = teamSize
        project.projectSummary = projectSummary
        project.role = role
        project.technologyUsed = technologyUsed
        if let index = resume.projects.firstIndex(of: project) {
            resume.projects[index] = project
        } else {
            resume.projects.append(project)
        }
        repository.save(resume: resume)
    }
}
