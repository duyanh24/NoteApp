//
//  Converter.swift
//  NoteApp
//
//  Created by AnhLD on 9/10/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import Foundation

class Converter {
    static func convertDateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        return formatter.string(from: date)
    }
}
