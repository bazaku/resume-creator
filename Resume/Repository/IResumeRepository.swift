//
//  IResumeRepository.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 24/2/2565 BE.
//

import Foundation

protocol IResumeRepository {
    func getAllResumes() -> [Resume]
    func save(resume: Resume)
    func delete(resume: Resume)
}
