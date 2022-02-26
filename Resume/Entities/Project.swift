//
//  Project.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 24/2/2565 BE.
//

import Foundation

struct Project: Codable {
    var id: String
    var name: String
    var teamSize: Int
    var projectSummary: String
    var technologyUsed: String
    var role: String
}

extension Project: Equatable {
    static func == (lhs: Project, rhs: Project) -> Bool {
        return lhs.id == rhs.id
    }
}
