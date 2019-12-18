//
//  MiniPlayerView.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2019/12/14.
//  Copyright © 2019 g4zeru. All rights reserved.
//

import SwiftUI
import MediaPlayer
import RxSwift

struct MiniPlayerView: View {
    @ObservedObject var playingItem: PlayItem = .shared
    private let height: CGFloat
    private let player = MPMusicPlayerApplicationController.applicationMusicPlayer
    init(height: CGFloat) {
        self.height = height
    }
    var body: some View {
        HStack {
            Image(uiImage: playingItem.playingItem?.artwork?.image(at: CGSize(width: 100, height: 100)) ?? UIImage(imageLiteralResourceName: "ICON"))
                .resizable()
                .frame(width: height - 20, height: height - 20)
                .cornerRadius(8)
            Text(playingItem.playingItem?.title ?? "再生停止中")
            Spacer()
            Button(action: {
                if self.player.playbackState == .playing {
                    self.player.stop()
                } else {
                    self.player.prepareToPlay()
                    self.player.play()
                }
            }) {
                Text(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/)
            }
            Button(action: {
                self.player.skipToNextItem()
            }) {
                Text(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/)
            }
        }
        .padding(.horizontal, 20)
        .frame(height: height)
        .onTapGesture {
            Dispatcher.shared.showPlayer.accept(())
        }.background(Color.clear)
    }
}

struct MiniPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MiniPlayerView(height: 55)
    }
}

class PlayItem: ObservableObject {
    @Published var playingItem: MPMediaItem?
    @Published var playbackTime: TimeInterval = 0
    var isEditing: Bool = false
    static let shared = PlayItem()
    private var timer: Timer = Timer()
    
    private let disposeBag = DisposeBag()
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(didChangePlayingItem), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCurrentTime), userInfo: nil, repeats: true)
        
    }
    
    @objc private func didChangePlayingItem() {
        playingItem = MPMusicPlayerApplicationController.applicationMusicPlayer.nowPlayingItem
    }
    
    @objc private func updateCurrentTime() {
        if !isEditing {
            playbackTime = MPMusicPlayerApplicationController.applicationMusicPlayer.currentPlaybackTime
        }
    }
}
