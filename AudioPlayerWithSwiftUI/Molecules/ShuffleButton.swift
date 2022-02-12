//
//  ShuffleButton.swift
//  AudioPlayerWithSwiftUI
//
//  Created by teranyan on 2020/03/16.
//  Copyright © 2020 teranyan. All rights reserved.
//

import MediaPlayer
import SwiftUI

struct ShuffleButton: View {
    @ObservedObject var observer: KVOObserver<MPMusicPlayerController, MPMusicShuffleMode>
    private let player: MPMusicPlayerController
    let imageHeight: CGFloat = 17
    init(player: MPMusicPlayerController) {
        observer = .init(monitoredObject: player, keypath: \.shuffleMode)
        self.player = player
    }

    var body: some View {
        let shuffleMode: MPMusicShuffleMode = observer.observedObject
        return Button(action: {
            switch shuffleMode {
            case .off:
                self.player.shuffleMode = .songs
            default:
                self.player.shuffleMode = .off
            }
        }) {
            Image(systemName: "shuffle")
                .resizable()
                .scaledToFit()
                .frame(height: imageHeight)
                .foregroundColor({
                    switch shuffleMode {
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
    static var player: MPMusicPlayerController = MPMusicPlayerController.applicationMusicPlayer
    static var previews: some View {
        ShuffleButton(player: ShuffleButton_Previews.player)
    }
}
