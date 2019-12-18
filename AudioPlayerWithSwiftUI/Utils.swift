//
//  Utils.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2019/12/13.
//  Copyright © 2019 g4zeru. All rights reserved.
//

import Foundation

extension Calendar {
    static func timeToString(time: Float) -> String {
        let second: Int
        let minute: Int
        second = Int(time) % 60
        minute = Int(time) / 60
        return "\(minute):\(NSString(format: "%02d", second))"
    }
    static func dateConvert(date: Date?) -> String? {
        guard let date = date else {
            return nil
        }
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy", options: 0, locale: Locale.current)
        return formatter.string(from: date)
    }
}
