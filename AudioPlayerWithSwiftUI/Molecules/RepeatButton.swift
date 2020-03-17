//
//  RepeatButton.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2020/03/17.
//  Copyright © 2020 g4zeru. All rights reserved.
//

import SwiftUI
import MediaPlayer

struct RepeatButton: View {
    @Binding var repeatMode: MPMusicRepeatMode
    let imageHeight: CGFloat = 17
    var body: some View {
        Button(action: {
            switch self.repeatMode {
            case .none:
                self.repeatMode = .all
            case .one:
                self.repeatMode = .none
            case .all:
                self.repeatMode = .one
            default:
                self.repeatMode = .all
            }
        }) {
            Image(systemName: {
                switch self.repeatMode {
                case .none:
                    return "repeat"
                case .one:
                    return "repeat.1"
                case .all:
                    return "repeat"
                case .default:
                    return "repeat"
                @unknown default:
                    return "repeat"
                }
            }())
                .resizable()
                .scaledToFit()
                .frame(height: imageHeight)
                .foregroundColor({
                    switch self.repeatMode {
                    case .none:
                        return .gray
                    case .one:
                        return .pink
                    case .all:
                        return .pink
                    default:
                        return .pink
                    }
                    }())
        }
    }
}

struct RepeatButton_Previews: PreviewProvider {
    @State static var repeatMode: MPMusicRepeatMode = .all
    static var previews: some View {
        RepeatButton(repeatMode: $repeatMode)
    }
}
