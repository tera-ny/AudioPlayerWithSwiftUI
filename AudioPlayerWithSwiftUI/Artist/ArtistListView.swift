//
//  ArtistListView.swift
//  AudioPlayerWithSwiftUI
//
//  Created by teranyan on 2019/12/14.
//  Copyright © 2019 teranyan. All rights reserved.
//

import MediaPlayer
import SwiftUI

struct ArtistListView: View {
    var body: some View {
        List(MPMediaQuery
            .artists()
            .collections?
            .compactMap { Artist(collection: $0) } ?? [],
             id: \.id) { item in
            NavigationLink(destination: ArtistDetailView(artistID: item.id, artist: item.name)) {
                HStack {
                    Text(item.name).lineLimit(1)
                }
            }
        }
        .navigationBarTitle(Text("Artist"))
    }
}

struct ArtistListView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistListView()
    }
}
