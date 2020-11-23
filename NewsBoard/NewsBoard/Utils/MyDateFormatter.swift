//
//  MyDateFormatter.swift
//  NewsBoard
//
//  Created by Bill Chen on 2020/11/23.
//

import Foundation

class MyDateFormatter {
    
    static func dateToString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
}
