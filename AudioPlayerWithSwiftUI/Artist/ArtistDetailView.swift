//
//  ArtistDetailView.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2019/12/14.
//  Copyright © 2019 g4zeru. All rights reserved.
//

import SwiftUI
import MediaPlayer
import QGrid

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
        QGrid(query.collections?.compactMap{ Album.init(collection: $0) } ?? [], columns: 2) { album in
            ArtistDetailRow(album: album)
                .padding(.horizontal, 5)
        }.navigationBarTitle(Text(artist))
    }
}

struct ArtistDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistDetailView(artistID: 0, artist: "artist")
    }
}
