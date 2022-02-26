//
//  Company.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 24/2/2565 BE.
//

import Foundation

struct Company {
    var id: String
    var name: String
    var durationYear: Int
    var durationMonth: Int
}

extension Company: Equatable {
    static func == (lhs: Company, rhs: Company) -> Bool {
        return lhs.id == rhs.id
    }
}
