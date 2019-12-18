//
//  PlayerView.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2019/12/14.
//  Copyright © 2019 g4zeru. All rights reserved.
//

import SwiftUI
import MediaPlayer
import RxSwift

struct PlayerView: View {
    @ObservedObject var item: PlayItem = .shared
    let player = MPMusicPlayerApplicationController.applicationMusicPlayer
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                Image(uiImage: item.playingItem?.artwork?.image(at: CGSize(width: 200, height:200)) ?? .init())
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .clipped()
                    .cornerRadius(8)
                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.playingItem?.title ?? "").font(.system(size: 22)).bold()
                        Text(item.playingItem?.artist ?? "").font(.system(size: 17)).foregroundColor(.pink)
                    }.padding(.top, 30)
                    Spacer()
                }
                Slider(value: self.$item.playbackTime, in: 0...(item.playingItem?.playbackDuration ?? 0),
                   onEditingChanged: {
                    self.item.isEditing = $0
                    if !$0 {
                        self.player.currentPlaybackTime = self.item.playbackTime
                    }
                })
                HStack {
                    Text(Calendar.timeToString(time: Float(item.playbackTime)))
                    Spacer()
                    Text(Calendar.timeToString(time: Float(((item.playingItem?.playbackDuration ?? 0) - item.playbackTime))))
                }
                HStack {
                    Button(action: {
                        self.player.skipToPreviousItem()
                    }, label: {
                        Text("Previous")
                    })
                    Button(action: {
                        if self.player.playbackState == .playing {
                            self.player.stop()
                        } else {
                            self.player.play()
                        }
                    }, label: {
                        Text("Start")
                    })
                    Button(action: {
                        self.player.skipToNextItem()
                    }, label: {
                        Text("Next")
                    })
                }
            }
            .padding(.all, 20)
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
