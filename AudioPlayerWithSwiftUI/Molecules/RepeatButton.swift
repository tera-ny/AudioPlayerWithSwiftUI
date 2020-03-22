//
//  RepeatButton.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2020/03/17.
//  Copyright © 2020 g4zeru. All rights reserved.
//

import MediaPlayer
import SwiftUI

struct RepeatButton: View {
    private let player: MPMusicPlayerController
    @ObservedObject private var observer: KVOObserver<MPMusicPlayerController, MPMusicRepeatMode>
    init(player: MPMusicPlayerController) {
        self.player = player
        observer = .init(monitoredObject: player, keypath: \.repeatMode)
    }
    let imageHeight: CGFloat = 17
    var body: some View {
        let repeatMode: MPMusicRepeatMode = observer.observedObject
        return Button(action: {
            switch repeatMode {
            case .none:
                self.player.repeatMode = .all
            case .one:
                self.player.repeatMode = .none
            case .all:
                self.player.repeatMode = .one
            default:
                applicationAssertError()
            }
        }) {
            Image(systemName: {
                switch repeatMode {
                case .none:
                    return "repeat"
                case .one:
                    return "repeat.1"
                case .all:
                    return "repeat"
                case .default:
                    return "repeat"
                }
            }())
                .resizable()
                .scaledToFit()
                .frame(height: imageHeight)
                .foregroundColor({
                    switch repeatMode {
                    case .none:
                        return .gray
                    case .one:
                        return .pink
                    case .all:
                        return .pink
                    case .default:
                        return .pink
                    }
                }())
        }
    }
}

struct RepeatButton_Previews: PreviewProvider {
    static let player: MPMusicPlayerController = .applicationMusicPlayer
    static var previews: some View {
        RepeatButton(player: RepeatButton_Previews.player)
    }
}
