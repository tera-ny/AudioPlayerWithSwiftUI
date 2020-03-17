//
//  Playback.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2020/03/17.
//  Copyright © 2020 g4zeru. All rights reserved.
//

import MediaPlayer
import SwiftUI

struct Playback: View {
    private class PlaybackObserver: ObservableObject {
        @Published var state: MPMusicPlaybackState
        private var player: MPMusicPlayerController
        private var observer: Any?
        init(player: MPMusicPlayerController) {
            self.player = player
            state = player.playbackState
            observer = NotificationCenter.default.addObserver(forName: NSNotification.Name.MPMusicPlayerControllerPlaybackStateDidChange, object: nil, queue: nil, using: updatePlayback(_:))
        }

        deinit {
            NotificationCenter.default.removeObserver(observer!)
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
