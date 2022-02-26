//
//  DetailPresenter.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 24/2/2565 BE.
//

import Foundation

class DetailPresenter {
    let interactor: DetailInteractor
    let router: DetailRouter
    
    init(interactor: DetailInteractor, router: DetailRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func getResume() -> Resume {
        interactor.reloadResume()
        return interactor.getResume()
    }
    
    func updatePhoto(_ url: String?) {
        interactor.updatePhoto(url)
    }
    
    func updateTitle(_ title: String?) {
        interactor.updateTitle(title)
    }
    
    func updateMobileNumber(_ mobileNumber: String?) {
        interactor.updateMobileNumber(mobileNumber)
    }
    
    func updateEmailAddress(_ emailAddress: String?) {
        interactor.updateEmailAddress(emailAddress)
    }
    
    func updateResidenceAddress(_ residenceAddress: String?) {
        interactor.updateResidenceAddress(residenceAddress)
    }
    
    func addCompany() {
        router.routeToCompany(company: nil, resume: getResume(), repository: interactor.repository)
    }
    
    func editCompany(_ company: Company) {
        router.routeToCompany(company: company, resume: getResume(), repository: interactor.repository)
    }
    
    func deleteCompany(_ company: Company) {
        interactor.deleteCompany(company)
    }
    
    func addSkill() {
        router.routeToSkill(skill: nil, resume: getResume(), repository: interactor.repository)
    }
    
    func editSkill(_ skill: String) {
        router.routeToSkill(skill: skill, resume: getResume(), repository: interactor.repository)
    }
    
    func deleteSkill(_ skill: String) {
        interactor.deleteSkill(skill)
    }
    
    func addEducation() {
        router.routeToEducation(education: nil, resume: getResume(), repository: interactor.repository)
    }
    
    func editEducation(_ education: Education) {
        router.routeToEducation(education: education, resume: getResume(), repository: interactor.repository)
    }
    
    func deleteEducation(_ education: Education) {
        interactor.deleteEducation(education)
    }
    
    func addProject() {
        router.routeToProject(project: nil, resume: getResume(), repository: interactor.repository)
    }
    
    func editProject(_ project: Project) {
        router.routeToProject(project: project, resume: getResume(), repository: interactor.repository)
    }
    
    func deleteProject(_ project: Project) {
        interactor.deleteProject(project)
    }
}
