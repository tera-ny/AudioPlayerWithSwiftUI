//
//  PlayerView.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2019/12/14.
//  Copyright © 2019 g4zeru. All rights reserved.
//

import MediaPlayer
import RxSwift
import SwiftUI

struct PlayerView: View {
    @State var player: MPMusicPlayerController
    @State var repeatMode: MPMusicRepeatMode = MPMusicPlayerApplicationController.applicationMusicPlayer.repeatMode
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 30) {
                Image(uiImage: player.nowPlayingItem?.artwork?.image(at: CGSize(width: 200, height: 200)) ?? .init())
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .clipped()
                    .padding(.bottom, 30)
                Player(player: $player)
            }
            .padding(.horizontal, 20)
            .padding(.top, 40)
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(player: .applicationMusicPlayer)
    }
}
