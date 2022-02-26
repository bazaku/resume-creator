//
//  CompanyPresenter.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 25/2/2565 BE.
//

import Foundation

class CompanyPresenter {
    enum ValidationError: Error {
        case invalidCompanyName
        case invalidYear
        case invalidMonth
        case invalidDuration
    }
    
    let interactor: ICompanyInteractor
    let router: ICompanyRouter
    
    init(interactor: ICompanyInteractor, router: ICompanyRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func getCompany() -> Company {
        return interactor.company
    }
    
    func save(companyName: String?, durationYear: String?, durationMonth: String?) throws {
        guard
            let companyName = companyName,
            !companyName.isEmpty else {
                throw ValidationError.invalidCompanyName
        }
        var year: Int = 0
        var month: Int = 0
        if let text = durationYear, text.isEmpty == false {
            guard let number = Int(text), number >= 0 else {
                throw ValidationError.invalidYear
            }
            year = number
        }
        if let text = durationMonth, text.isEmpty == false {
            guard let number = Int(text), number < 12, number >= 0 else {
                throw ValidationError.invalidMonth
            }
            month = number
        }
        guard year > 0 || month > 0 else {
            throw ValidationError.invalidDuration
        }
        interactor.save(companyName: companyName, durationYear: year, durationMonth: month)
        router.routeToDetail()
    }
}
