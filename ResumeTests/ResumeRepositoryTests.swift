//
//  ResumeRepositoryTests.swift
//  ResumeTests
//
//  Created by Siwasit Anmahapong on 26/2/2565 BE.
//

import XCTest
@testable import Resume

class ResumeRepositoryTests: XCTestCase {
    
    var repository: ResumeRepository!
    var dataSource: MockResumeDataSource!

    override func setUpWithError() throws {
        dataSource = MockResumeDataSource()
        repository = ResumeRepository(dataSource: dataSource)
    }

    override func tearDownWithError() throws {
        
    }
    
    func testGetAllResumes() throws {
        dataSource.allResumes = [
            Resume(id: "id_1"),
            Resume(id: "id_2"),
            Resume(id: "id_3"),
            Resume(id: "id_4"),
        ]
        XCTAssertEqual(repository.getAllResumes().count, 4)
    }
    
    func testGetSpecificResume() throws {
        dataSource.allResumes = [
            Resume(id: "id_1"),
            Resume(id: "id_2"),
            Resume(id: "id_3"),
            Resume(id: "id_4"),
        ]
        dataSource.specificResume = Resume(id: "id_specific")
        XCTAssertEqual(repository.getResume(id: "some_id"), dataSource.specificResume)
    }
    
    func testCreateResume() throws {
        let resume = repository.createNewResume()
        XCTAssertNotNil(dataSource.createdResume)
        XCTAssertEqual(resume, dataSource.createdResume)
        XCTAssertEqual(resume.updatedDate.timeIntervalSince1970, Date().timeIntervalSince1970, accuracy: 1.0)
    }
    
    func testSaveResume() throws {
        var resume = Resume(id: "some_id")
        resume.updatedDate = Date(timeIntervalSince1970: 946684800)
        repository.save(resume: resume)
        XCTAssertNotNil(dataSource.updatedResume)
        XCTAssertEqual(resume, dataSource.updatedResume)
        XCTAssertNotEqual(resume.updatedDate, dataSource.updatedResume!.updatedDate)
        XCTAssertEqual(dataSource.updatedResume!.updatedDate.timeIntervalSince1970, Date().timeIntervalSince1970, accuracy: 1.0)
    }
    
    func testDeleteResume() throws {
        var resume = Resume(id: "some_id")
        resume.updatedDate = Date(timeIntervalSince1970: 946684800)
        repository.delete(resume: resume)
        XCTAssertNotNil(dataSource.deletedResume)
    }
}

class MockResumeDataSource: IResumeDataSource {
    var allResumes: [Resume] = []
    var specificResume: Resume!
    var createdResume: Resume?
    var updatedResume: Resume?
    var deletedResume: Resume?
    
    func getAll() -> [Resume] {
        return allResumes
    }
    
    func get(id: String) -> Resume? {
        return specificResume
    }
    
    func create(resume: Resume) {
        createdResume = resume
    }
    
    func update(resume: Resume) {
        updatedResume = resume
    }
    
    func delete(resume: Resume) {
        deletedResume = resume
    }
}
