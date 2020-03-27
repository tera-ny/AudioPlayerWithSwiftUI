//
//  PlayerView.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2019/12/14.
//  Copyright © 2019 g4zeru. All rights reserved.
//

import MediaPlayer
import SwiftUI

class QueueListener: ObservableObject {
    private var token: String?
    private var dispatcher: QueueDispatcher
    static let shared = QueueListener(dispatcher: .shared)
    @Published var queue: [MPMediaItem] = []
    deinit {
        dispatcher.unSubscribe(token: token!)
    }

    init(dispatcher: QueueDispatcher) {
        self.dispatcher = dispatcher
        print("subscribe")
        token = dispatcher.subscribe(callback: { [weak self] collection, _ in
            print("enqueue")
            self?.queue = collection.items
        })
    }
}

struct PlayerView: View {
    let player: MPMusicPlayerController
    @State var repeatMode: MPMusicRepeatMode = MPMusicPlayerApplicationController.applicationMusicPlayer.repeatMode
    @ObservedObject private var controller: QueueListener = .shared
    @ObservedObject private var observer: NowPlayingItemObserver
    
    init(player: MPMusicPlayerController) {
        self.player = player
        observer = .init(player: player)
    }

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
                Player(player: player)
                HStack {
                    Text("Queue").font(.system(size: 17, weight: .bold, design: Font.Design.default))
                    Spacer()
                }.padding(.top, 16)
                VStack(spacing: 20) {
                    ForEach(controller.queue, id: \.self) { item in
                        VStack {
                            HStack {
                                Text(item.title ?? "")
                                    .foregroundColor(
                                        Color({
                                            if item.persistentID == self.observer.playingItem?.persistentID {
                                                return .systemPink
                                            } else {
                                                return .label
                                            }
                                        }())
                                    )
                                Spacer()
                                Text(Calendar.timeToString(interval: item.playbackDuration))
                                    .font(.system(size: 14, weight: .light, design: .default))
                                    .foregroundColor(.pink)
                            }
                            EmptyView()
                                .frame(height: 1)
                                .background(Color(.separator))
                        }
                    }
                }
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
