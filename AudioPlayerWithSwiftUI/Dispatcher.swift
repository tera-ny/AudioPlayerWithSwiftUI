//
//  Dispatcher.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2020/03/17.
//  Copyright © 2020 g4zeru. All rights reserved.
//

import Foundation
import MediaPlayer
import Napoli

class QueueDispatcher: DispatcherStoreProtocol {
    var store: [String: (QueueDispatcher.Action) -> Void] = [:]

    typealias Action = (MPMediaItemCollection, MPMediaItem?)

    static let shared = QueueDispatcher()
}
