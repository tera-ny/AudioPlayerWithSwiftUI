//
//  ArtistDetailView.swift
//  AudioPlayerWithSwiftUI
//
//  Created by teranyan on 2019/12/14.
//  Copyright © 2019 teranyan. All rights reserved.
//

import MediaPlayer
import SwiftUI

struct ArtistDetailView: View {
    private let query: MPMediaQuery
    private let artist: String
    init(artistID: UInt64, artist: String) {
        query = MPMediaQuery.albums()
        self.artist = artist
        let artistFilter = MPMediaPropertyPredicate(value: artistID, forProperty: MPMediaItemPropertyArtistPersistentID)
        query.addFilterPredicate(artistFilter)
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(), GridItem()], content: {
                ForEach(query.collections?.compactMap { Album(collection: $0) } ?? []) { album  in
                    NavigationLink(destination: AlbumDetailView(album: album)) {
                        AlbumCell(album: album)
                    }
                }
            })
        }
        .navigationBarTitle(Text(artist))
    }
}

struct ArtistDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistDetailView(artistID: 0, artist: "artist")
    }
}
