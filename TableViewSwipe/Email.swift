//
//  Email.swift
//  TableViewSwipe
//
//  Created by Steven Smith on 8/3/17.
//  Copyright © 2017 Steven Smith. All rights reserved.
//

import Foundation

struct Email {
    let subject: String
    let body: String
    var isNew: Bool
    var isFlagged: Bool

    static func mockData(numberOfItems count: Int) -> [Email] {
        var emails = [Email]()
        for idx in 1...count {
            let email = Email(subject: "Email \(idx)", body: "This is my body for email \(idx)", isNew: true, isFlagged: false)
            emails.append(email)
        }
        return emails
    }

    mutating func toggleReadFlag() -> Bool {
        self.isNew = !self.isNew
        //normally make some call to toggle and return success/fail
        return true
    }

    mutating func toggleFlaggedFlag() -> Bool {
        self.isFlagged = !self.isFlagged
        //normally make some call to toggle and return success/fail
        return true
    }
}
