//
//  AlbumDetailView.swift
//  AudioPlayerWithSwiftUI
//
//  Created by teranyan on 2019/12/13.
//  Copyright © 2019 teranyan. All rights reserved.
//

import MediaPlayer
import SwiftUI

struct AlbumDetailView: View {
    private let album: Album
    init(album: Album) {
        self.album = album
    }

    var body: some View {
        VStack(alignment: .leading) {
            AlbumListHeader(album: album, canPushArtistList: true).frame(height: 120).padding(.leading)
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
        QueueDispatcher.shared.on(action: (collection, item))
    }
}

struct AlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailView(album: .init(title: "タイトル", artist: "アーティスト", artwork: #imageLiteral(resourceName: "ICON.png")))
    }
}
