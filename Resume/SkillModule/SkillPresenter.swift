//
//  SkillPresenter.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 25/2/2565 BE.
//

import Foundation

class SkillPresenter {
    enum ValidationError: Error {
        case invalidName
    }
    
    let interactor: SkillInteractor
    let router: SkillRouter
    
    init(interactor: SkillInteractor, router: SkillRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func getSkill() -> String? {
        return interactor.skillName
    }
    
    func save(skillName: String?) throws {
        guard let skillName = skillName, !skillName.isEmpty else {
            throw ValidationError.invalidName
        }
        interactor.save(skillName: skillName)
        router.routeToDetail()
    }
}
