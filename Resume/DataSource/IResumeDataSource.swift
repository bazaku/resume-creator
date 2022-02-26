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
