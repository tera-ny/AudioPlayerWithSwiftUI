//
//  Dispatcher.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2019/12/14.
//  Copyright © 2019 g4zeru. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class Dispatcher {
    static let shared = Dispatcher()
    var showPlayer = PublishRelay<Void>()
    var currentPlayBackTime = PublishRelay<TimeInterval?>()
}
