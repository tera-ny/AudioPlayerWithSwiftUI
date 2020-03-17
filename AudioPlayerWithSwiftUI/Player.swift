//
//  Player.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2020/03/16.
//  Copyright © 2020 g4zeru. All rights reserved.
//

import MediaPlayer
import SwiftUI

struct Player: View {
    @Binding var player: MPMusicPlayerController
    private var playingItem: MPMediaItem? {
        return player.nowPlayingItem
    }

    @ObservedObject private var observer: NowPlayingItemObserver
    init(player: Binding<MPMusicPlayerController>) {
        _player = player
        observer = .init(player: player.wrappedValue)
    }

    var body: some View {
        return VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(observer.playingItem?.title ?? "Title").font(.system(size: 22)).bold().lineLimit(2)
                    Text(observer.playingItem?.artist ?? "Artist").font(.system(size: 17)).foregroundColor(.pink).lineLimit(2)
                }
                Spacer()
                ShuffleButton(shuffleMode: $player.shuffleMode)
                RepeatButton(repeatMode: $player.repeatMode)
            }
            SeekBar(player: player)
            PlaybackControl(player: player)
        }
    }
}

struct Player_Previews: PreviewProvider {
    @State static var player = MPMusicPlayerController.applicationMusicPlayer
    static var previews: some View {
        Player(player: Player_Previews.$player)
    }
}
