//
//  ProjectPresenter.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 26/2/2565 BE.
//

import Foundation

class ProjectPresenter {
    enum ValidationError: Error {
        case invalidProjectName
        case invalidTeamSize
        case invalidProjectSummary
        case invalidRole
        case invalidTechnology
    }
    
    let interactor: ProjectInteractor
    let router: ProjectRouter
    
    init(interactor: ProjectInteractor, router: ProjectRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func getProject() -> Project {
        return interactor.project
    }
    
    func save(projectName: String?, teamSize teamSizeString: String?, projectSummary: String?, role: String?, technologyUsed: String?) throws {
        guard
            let projectName = projectName,
            !projectName.isEmpty else {
                throw ValidationError.invalidProjectName
        }
        
        guard
            let projectSummary = projectSummary,
            !projectSummary.isEmpty else {
                throw ValidationError.invalidProjectSummary
        }
        
        guard
            let role = role,
            !role.isEmpty else {
                throw ValidationError.invalidRole
        }
        
        guard
            let teamSizeString = teamSizeString,
            let teamSize = Int(teamSizeString),
            teamSize >= 0 else {
                throw ValidationError.invalidTeamSize
        }
        
        guard
            let technologyUsed = technologyUsed,
            !technologyUsed.isEmpty else {
                throw ValidationError.invalidTechnology
        }
        
        interactor.save(name: projectName, teamSize: teamSize, projectSummary: projectSummary, role: role, technologyUsed: technologyUsed)
        router.routeToDetail()
    }
}
