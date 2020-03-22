//
//  NowPlayingItemObserver.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2020/03/17.
//  Copyright © 2020 g4zeru. All rights reserved.
//

import MediaPlayer
import SwiftUI

class NowPlayingItemObserver: ObservableObject {
    @Published var playingItem: MPMediaItem?
    private let player: MPMusicPlayerController
    private var observer: Any?
    deinit {
        NotificationCenter.default.removeObserver(observer!)
    }

    init(player: MPMusicPlayerController) {
        self.player = player
        playingItem = player.nowPlayingItem
        player.beginGeneratingPlaybackNotifications()
        observer = NotificationCenter.default.addObserver(forName: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil, queue: nil, using: didChangePlayingItem(notification:))
        player.endGeneratingPlaybackNotifications()
    }

    private func didChangePlayingItem(notification _: Notification) {
        playingItem = player.nowPlayingItem
    }
}
