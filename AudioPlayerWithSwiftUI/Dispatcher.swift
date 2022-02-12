//
//  Dispatcher.swift
//  AudioPlayerWithSwiftUI
//
//  Created by teranyan on 2020/03/17.
//  Copyright © 2020 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer
import Napoli

class QueueDispatcher: DispatcherStoreProtocol {
    var store: [String: (QueueDispatcher.Action) -> Void] = [:]

    typealias Action = (MPMediaItemCollection, MPMediaItem?)

    static let shared = QueueDispatcher()
}
