//
//  Player.swift
//  AudioPlayerWithSwiftUI
//
//  Created by teranyan on 2020/03/16.
//  Copyright © 2020 teranyan. All rights reserved.
//

import MediaPlayer
import SwiftUI

struct Player: View {
    private var player: MPMusicPlayerController
    private var playingItem: MPMediaItem? {
        return player.nowPlayingItem
    }

    @ObservedObject private var observer: NowPlayingItemObserver
    init(player: MPMusicPlayerController) {
        self.player = player
        observer = .init(player: player)
    }

    var body: some View {
        return VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(observer.playingItem?.title ?? "Title").font(.system(size: 22)).bold().lineLimit(2)
                    Text(observer.playingItem?.artist ?? "Artist").font(.system(size: 17)).foregroundColor(.pink).lineLimit(2)
                }
                Spacer()
                ShuffleButton(player: player)
                RepeatButton(player: player)
            }
            SeekBar(player: player)
            PlaybackControl(player: player)
        }
    }
}

struct Player_Previews: PreviewProvider {
    static var player = MPMusicPlayerController.applicationMusicPlayer
    static var previews: some View {
        Player(player: Player_Previews.player)
    }
}
