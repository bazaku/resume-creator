//
//  CompanyPresenterTests.swift
//  ResumeTests
//
//  Created by Siwasit Anmahapong on 26/2/2565 BE.
//

import XCTest
@testable import Resume

class CompanyPresenterTests: XCTestCase {
    
    var presenter: CompanyPresenter!
    var interactor: MockCompanyInteractor!
    var router: MockCompanyRouter!

    override func setUpWithError() throws {
        interactor = MockCompanyInteractor()
        router = MockCompanyRouter()
        presenter = CompanyPresenter(interactor: interactor, router: router)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSaveWithNoError() throws {
        do {
            try presenter.save(companyName: "name", durationYear: "1", durationMonth: "1")
        } catch {
            XCTFail("Expect not to throw error but got \(error)")
        }
    }

    func testSaveWithNoCompanyName() throws {
        do {
            try presenter.save(companyName: nil, durationYear: nil, durationMonth: nil)
            XCTFail("Expect to throw error")
        } catch CompanyPresenter.ValidationError.invalidCompanyName {
        } catch {
            XCTFail("Expect to throw CompanyPresenter.ValidationError.invalidCompanyName but got \(error)")
        }
    }
    
    func testSaveWithNoDuration() throws {
        do {
            try presenter.save(companyName: "name", durationYear: nil, durationMonth: nil)
            XCTFail("Expect to throw error")
        } catch CompanyPresenter.ValidationError.invalidDuration {
        } catch {
            XCTFail("Expect to throw CompanyPresenter.ValidationError.invalidDuration but got \(error)")
        }
    }
    
    func testSaveWithInvalidYearNumber() throws {
        do {
            try presenter.save(companyName: "name", durationYear: "A1", durationMonth: nil)
            XCTFail("Expect to throw error")
        } catch CompanyPresenter.ValidationError.invalidYear {
        } catch {
            XCTFail("Expect to throw CompanyPresenter.ValidationError.invalidYear but got \(error)")
        }
    }
        
    func testSaveWithNegativeYearNumber() throws {
        do {
            try presenter.save(companyName: "name", durationYear: "-1000", durationMonth: nil)
            XCTFail("Expect to throw error")
        } catch CompanyPresenter.ValidationError.invalidYear {
        } catch {
            XCTFail("Expect to throw CompanyPresenter.ValidationError.invalidYear but got \(error)")
        }
    }
    
    func testSaveWithInvalidMonthNumber() throws {
        do {
            try presenter.save(companyName: "name", durationYear: nil, durationMonth: "A1")
            XCTFail("Expect to throw error")
        } catch CompanyPresenter.ValidationError.invalidMonth {
        } catch {
            XCTFail("Expect to throw CompanyPresenter.ValidationError.invalidMonth but got \(error)")
        }
    }
    
    func testSaveWithNegativeMonthNumber() throws {
        do {
            try presenter.save(companyName: "name", durationYear: nil, durationMonth: "-1000")
            XCTFail("Expect to throw error")
        } catch CompanyPresenter.ValidationError.invalidMonth {
        } catch {
            XCTFail("Expect to throw CompanyPresenter.ValidationError.invalidMonth but got \(error)")
        }
    }
     
    func testSaveWithInvalidMonthRange() throws {
        do {
            try presenter.save(companyName: "name", durationYear: nil, durationMonth: "20")
            XCTFail("Expect to throw error")
        } catch CompanyPresenter.ValidationError.invalidMonth {
        } catch {
            XCTFail("Expect to throw CompanyPresenter.ValidationError.invalidMonth but got \(error)")
        }
    }
    
    func testSaveWithZeroYearNumber() throws {
        do {
            try presenter.save(companyName: "name", durationYear: "0", durationMonth: nil)
            XCTFail("Expect to throw error")
        } catch CompanyPresenter.ValidationError.invalidDuration {
        } catch {
            XCTFail("Expect to throw CompanyPresenter.ValidationError.invalidDuration but got \(error)")
        }
    }
    
    func testSaveWithZeroMonthNumber() throws {
        do {
            try presenter.save(companyName: "name", durationYear: nil, durationMonth: "0")
            XCTFail("Expect to throw error")
        } catch CompanyPresenter.ValidationError.invalidDuration {
        } catch {
            XCTFail("Expect to throw CompanyPresenter.ValidationError.invalidDuration but got \(error)")
        }
    }
    
    func testSaveWithZeroYearMonthNumber() throws {
        do {
            try presenter.save(companyName: "name", durationYear: "0", durationMonth: "0")
            XCTFail("Expect to throw error")
        } catch CompanyPresenter.ValidationError.invalidDuration {
        } catch {
            XCTFail("Expect to throw CompanyPresenter.ValidationError.invalidDuration but got \(error)")
        }
    }
    
    func testSaveWithPositiveYearZeroMonthNumber() throws {
        do {
            try presenter.save(companyName: "name", durationYear: "1", durationMonth: "0")
        } catch {
            XCTFail("Expect not to throw error but got \(error)")
        }
    }
    
    func testSaveWithZeroYearPositiveMonthNumber() throws {
        do {
            try presenter.save(companyName: "name", durationYear: "0", durationMonth: "1")
        } catch {
            XCTFail("Expect not to throw error but got \(error)")
        }
    }

}

class MockCompanyInteractor: ICompanyInteractor {
    
    var injectCompany: Company!
    var savedCompanyName: String?
    var savedDurationYear: Int?
    var savedDurationMonth: Int?
    
    var company: Company {
        return injectCompany
    }
    
    func save(companyName: String, durationYear: Int, durationMonth: Int) {
        savedCompanyName = companyName
        savedDurationYear = durationYear
        savedDurationMonth = durationMonth
    }
}

class MockCompanyRouter: ICompanyRouter {
    var isRouteToDetail = false
    func routeToDetail() {
        isRouteToDetail = true
    }
}
