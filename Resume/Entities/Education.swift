//
//  Education.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 24/2/2565 BE.
//

import Foundation

struct Education: Codable {
    var id: String
    var className: String
    var passingYear: Int
    var cgpa: Double
}

extension Education: Equatable {
    static func == (lhs: Education, rhs: Education) -> Bool {
        return lhs.id == rhs.id
    }
}
