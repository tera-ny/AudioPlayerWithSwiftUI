//
//  Playback.swift
//  AudioPlayerWithSwiftUI
//
//  Created by teranyan on 2020/03/17.
//  Copyright © 2020 teranyan. All rights reserved.
//

import MediaPlayer
import SwiftUI

struct Playback: View {
    private class PlaybackObserver: ObservableObject {
        @Published var state: MPMusicPlaybackState
        private var player: MPMusicPlayerController
        private var observers: [Any] = []
        init(player: MPMusicPlayerController) {
            self.player = player
            state = player.playbackState
            player.beginGeneratingPlaybackNotifications()
            observers = [NotificationCenter.default.addObserver(forName: NSNotification.Name.MPMusicPlayerControllerPlaybackStateDidChange, object: nil, queue: nil, using: updatePlayback(_:)),
                         NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil, using: updatePlayback(_:))]
            player.endGeneratingPlaybackNotifications()
        }

        deinit {
            observers.forEach { observer in
                NotificationCenter.default.removeObserver(observer)
            }
        }

        func updatePlayback(_: Notification) {
            state = player.playbackState
        }
    }

    private let player: MPMediaPlayback
    @ObservedObject private var playbackObserver: PlaybackObserver
    init(player: MPMusicPlayerController) {
        playbackObserver = PlaybackObserver(player: player)
        self.player = player
    }

    var body: some View {
        Button(action: {
            if self.playbackObserver.state == .playing {
                self.player.stop()
            } else {
                self.player.play()
            }
        }, label: {
            Image(systemName: {
                if self.playbackObserver.state == .playing {
                    return "pause.fill"
                } else {
                    return "play.fill"
                }
            }())
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.pink)
        })
    }
}

struct Playback_Previews: PreviewProvider {
    static var previews: some View {
        Playback(player: MPMusicPlayerController.applicationMusicPlayer)
    }
}
