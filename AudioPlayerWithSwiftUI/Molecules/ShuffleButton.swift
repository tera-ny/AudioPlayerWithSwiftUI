//
//  ShuffleButton.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2020/03/16.
//  Copyright © 2020 g4zeru. All rights reserved.
//

import MediaPlayer
import SwiftUI

struct ShuffleButton: View {
    @Binding var shuffleMode: MPMusicShuffleMode
    let imageHeight: CGFloat = 17
    var body: some View {
        Button(action: {
            switch self.shuffleMode {
            case .off:
                self.shuffleMode = .songs
            default:
                self.shuffleMode = .off
            }
        }) {
            Image(systemName: "shuffle")
                .resizable()
                .scaledToFit()
                .frame(height: imageHeight)
                .foregroundColor({
                    switch self.shuffleMode {
                    case .off:
                        return .gray
                    default:
                        return .pink
                    }
                }())
        }
    }
}

struct ShuffleButton_Previews: PreviewProvider {
    @State static var player: MPMusicPlayerController = MPMusicPlayerController.applicationMusicPlayer
    static var previews: some View {
        ShuffleButton(shuffleMode: ShuffleButton_Previews.$player.shuffleMode)
    }
}
