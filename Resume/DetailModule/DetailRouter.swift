//
//  DetailRouter.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 24/2/2565 BE.
//

import Foundation
import UIKit

class DetailRouter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func routeToCompany(company: Company?, resume: Resume, repository: IResumeRepository) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let companyViewController = storyboard.instantiateViewController(identifier: "company") as? CompanyViewController else {
            return
        }
        let interactor = CompanyInteractor(repository: repository, resume: resume, company: company)
        let router = CompanyRouter(viewController: companyViewController)
        let presenter = CompanyPresenter(interactor: interactor, router: router)
        companyViewController.presenter = presenter
        viewController?.navigationController?.pushViewController(companyViewController, animated: true)
    }
    
    func routeToSkill(skill: String?, resume: Resume, repository: IResumeRepository) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let skillViewController = storyboard.instantiateViewController(identifier: "skill") as? SkillViewController else {
            return
        }
        let interactor = SkillInteractor(repository: repository, resume: resume, skillName: skill)
        let router = SkillRouter(viewController: skillViewController)
        let presenter = SkillPresenter(interactor: interactor, router: router)
        skillViewController.presenter = presenter
        viewController?.navigationController?.pushViewController(skillViewController, animated: true)
    }
    
    func routeToEducation(education: Education?, resume: Resume, repository: IResumeRepository) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let educationViewController = storyboard.instantiateViewController(identifier: "education") as? EducationViewController else {
            return
        }
        let interactor = EducationInteractor(repository: repository, resume: resume, education: education)
        let router = EducationRouter(viewController: educationViewController)
        let presenter = EducationPresenter(interactor: interactor, router: router)
        educationViewController.presenter = presenter
        viewController?.navigationController?.pushViewController(educationViewController, animated: true)
    }
    
    func routeToProject(project: Project?, resume: Resume, repository: IResumeRepository) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let projectViewController = storyboard.instantiateViewController(identifier: "project") as? ProjectViewController else {
            return
        }
        let interactor = ProjectInteractor(repository: repository, resume: resume, project: project)
        let router = ProjectRouter(viewController: projectViewController)
        let presenter = ProjectPresenter(interactor: interactor, router: router)
        projectViewController.presenter = presenter
        viewController?.navigationController?.pushViewController(projectViewController, animated: true)
    }
}
