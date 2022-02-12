//
//  ApplicationAssertError.swift
//  AudioPlayerWithSwiftUI
//
//  Created by teranyan on 2020/03/22.
//  Copyright © 2020 teranyan. All rights reserved.
//

import Foundation

func applicationAssertError(message: String? = nil, line: Int = #line, file: String = #file, function: String = #function) {
    #if DEBUG
        print("===== Called applicationAssertError at DEBUG mode =====")
        print("file: \(file), line: \(line), function: \(function)")
        if let message = message { print("message: \(message)") }
        print("==========")
    #endif
    fatalError()
}
