//
//  DateFormatter+Extensions.swift
//  lab-insta-parse
//
//  Created by Manasa Pooni on 4/3/23.
//

import Foundation

extension DateFormatter {
    static var postFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
}
