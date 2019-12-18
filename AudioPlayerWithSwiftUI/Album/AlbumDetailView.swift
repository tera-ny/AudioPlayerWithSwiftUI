//
//  AlbumDetailView.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2019/12/13.
//  Copyright © 2019 g4zeru. All rights reserved.
//

import SwiftUI
import MediaPlayer

struct AlbumDetailView: View {
    private let album: Album
    init(album: Album) {
        self.album = album
    }
    var body: some View {
        VStack(alignment: .leading) {
            AlbumListViewRow(album: album).frame(height: 120).padding(.leading)
            List(album.items, id: \.persistentID) { item in
                Button(action: {
                    self.play(item: item)
                }) {
                    HStack {
                        Text(item.title!)
                        Spacer()
                        Text(Calendar.timeToString(time: Float(item.playbackDuration))).foregroundColor(.pink)
                    }
                }
            }
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
        .padding(.top, 10)
    }
    private func play(item: MPMediaItem) {
        let collection = MPMediaItemCollection(items: album.items)
        let player = MPMusicPlayerApplicationController.applicationMusicPlayer
        player.setQueue(with: collection)
        player.nowPlayingItem = item
        player.prepareToPlay()
        player.play()
    }
}

struct AlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailView(album: .init(title: "タイトル", artist: "アーティスト", artwork: #imageLiteral(resourceName: "ICON.png")))
    }
}
