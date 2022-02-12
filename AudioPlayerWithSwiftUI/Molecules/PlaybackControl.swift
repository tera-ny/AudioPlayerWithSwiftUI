//
//  PlaybackControl.swift
//  AudioPlayerWithSwiftUI
//
//  Created by teranyan on 2020/03/17.
//  Copyright © 2020 teranyan. All rights reserved.
//

import MediaPlayer
import SwiftUI

struct PlaybackControl: View {
    let player: MPMusicPlayerController
    var body: some View {
        return HStack(spacing: 70) {
            Button(action: {
                self.player.skipToPreviousItem()
            }, label: {
                Image(systemName: "backward.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
                    .foregroundColor(Color.pink)
            })
            Playback(player: player)
                .frame(height: 40)
            Button(action: {
                self.player.skipToNextItem()
            }, label: {
                Image(systemName: "forward.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
                    .foregroundColor(Color.pink)
            })
        }
        .padding(.top, 20)
        .disabled(self.player.nowPlayingItem == nil)
    }
}

struct PlaybackControl_Previews: PreviewProvider {
    static var previews: some View {
        PlaybackControl(player: MPMusicPlayerController.applicationMusicPlayer)
    }
}
