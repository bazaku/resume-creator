//
//  IResumeDataSource.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 24/2/2565 BE.
//

import Foundation

protocol IResumeDataSource {
    func getAll() -> [Resume]
    func get(id: String) -> Resume?
    func create(resume: Resume)
    func update(resume: Resume)
    func delete(resume: Resume)
}

class SimpleDataSource: IResumeDataSource {
    var dataStore: [Resume] = []
    
    func getAll() -> [Resume] {
        return dataStore
    }
    
    func get(id: String) -> Resume? {
        return dataStore.first { $0.id == id }
    }
    
    func create(resume: Resume) {
        dataStore.append(resume)
    }
    
    func update(resume: Resume) {
        let index = dataStore.firstIndex { $0 == resume }
        guard let index = index else {
            print("Save fail")
            return
        }
        dataStore[index] = resume
    }
    
    func delete(resume: Resume) {
        dataStore.removeAll { $0 == resume }
    }
    
    
}
