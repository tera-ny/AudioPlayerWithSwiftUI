//
//  MiniPlayerView.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2019/12/14.
//  Copyright © 2019 g4zeru. All rights reserved.
//

import MediaPlayer
import RxSwift
import SwiftUI

struct MiniPlayerView: View {
    @ObservedObject var observer: NowPlayingItemObserver
    private let height: CGFloat
    private let player: MPMusicPlayerController
    init(height: CGFloat, player: MPMusicPlayerController = MPMusicPlayerApplicationController.applicationMusicPlayer) {
        self.player = player
        self.height = height
        observer = .init(player: player)
    }

    var body: some View {
        HStack {
            if observer.playingItem?.artwork != nil {
                Image(uiImage: observer.playingItem!.artwork!.image(at: CGSize(width: 100, height: 100)) ?? .init())
                    .resizable()
                    .frame(width: height - 20, height: height - 20)
                    .cornerRadius(8)
            }
            Text(observer.playingItem?.title ?? "再生停止中")
                .lineLimit(2)
                .font(.system(size: 17 ,weight: .medium))
            Spacer()
            Playback(player: player)
                .frame(height: 23)
            Button(action: {
                self.player.skipToNextItem()
            }) {
                Image(systemName: "forward.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                    .foregroundColor(.pink)
            }.padding(.leading, 15)
        }
        .padding(.horizontal, 20)
        .frame(height: height)
        .background(Color(.systemBackground))
        .disabled(player.nowPlayingItem == nil)
    }
}

struct MiniPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MiniPlayerView(height: 55)
    }
}
