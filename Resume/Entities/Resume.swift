//
//  Resume.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 24/2/2565 BE.
//

import Foundation

struct Resume {
    var id: String
    var picture: String
    var mobileNumber: String
    var emailAddress: String
    var residenceAddress: String
    var careerObjective: String
    var yearsOfExperience: Int
    var workSummary: [Company]
    var skills: [String]
    var educations: [String]
    var projects: [String]
}

extension Resume: Equatable {
    static func == (lhs: Resume, rhs: Resume) -> Bool {
        return lhs.id == rhs.id
    }
}
