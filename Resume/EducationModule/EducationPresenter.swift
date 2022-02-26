//
//  EducationPresenter.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 25/2/2565 BE.
//

import Foundation

class EducationPresenter {
    enum ValidationError: Error {
        case invalidClassName
        case invalidCGPA
    }
    
    let interactor: EducationInteractor
    let router: EducationRouter
    
    init(interactor: EducationInteractor, router: EducationRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func getEducation() -> Education {
        return interactor.education
    }
    
    func save(className: String?, passingYear: Int, cgpa cgpaString: String?) throws {
        guard
            let className = className,
            !className.isEmpty else {
                throw ValidationError.invalidClassName
        }
        
        guard
            let cgpaString = cgpaString,
            !cgpaString.isEmpty,
            let cgpa = Double(cgpaString) else {
                throw ValidationError.invalidCGPA
        }
        
        interactor.save(className: className, passingYear: passingYear, cgpa: cgpa)
        router.routeToDetail()
    }
}
