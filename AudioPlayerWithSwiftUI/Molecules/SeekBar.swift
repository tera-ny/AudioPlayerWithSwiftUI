//
//  SeekBar.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2020/03/16.
//  Copyright © 2020 g4zeru. All rights reserved.
//

import MediaPlayer
import SwiftUI

struct SeekBar: View {
    @Binding var player: MPMusicPlayerController
    @State var isEditing: Bool = false
    @State var time: TimeInterval = 0

    var body: some View {
        let playbackDuration = self.player.nowPlayingItem?.playbackDuration ?? 0
        let remainingTime: Float = Float(playbackDuration - time)
        return Slider(value: self.$time,
                      in: 0 ... playbackDuration,
                      onEditingChanged: {
                          self.isEditing = $0
                          if !$0 {
                              self.player.currentPlaybackTime = self.time
                          }
                      },
                      minimumValueLabel: Text(Calendar.timeToString(time: Float(time)))
                          .font(.system(size: 14))
                          .frame(width: 40, alignment: .leading),
                      maximumValueLabel: Text(Calendar.timeToString(time: remainingTime))
                          .font(.system(size: 14))
                          .frame(width: 40, alignment: Alignment.center)) {
            EmptyView()
        }
        .accentColor(.pink)
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            if !self.isEditing {
                self.time = self.player.currentPlaybackTime
            }
            print(self.player.currentPlaybackTime)
        }
    }
}

struct SeekBar_Previews: PreviewProvider {
    @State static var player = MPMusicPlayerController.applicationMusicPlayer
    static var previews: some View {
        SeekBar(player: SeekBar_Previews.$player)
    }
}
