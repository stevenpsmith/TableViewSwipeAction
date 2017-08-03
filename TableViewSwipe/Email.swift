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

    static func mockData(numberOfItems count: Int) -> [Email] {
        var emails = [Email]()
        for idx in 1...count {
            let email = Email(subject: "Email \(idx)", body: "This is my body for email \(idx)", isNew: true)
            emails.append(email)
        }
        return emails
    }

    mutating func toggleReadFlag() -> Bool {
        self.isNew = !self.isNew
        return true
    }
}
