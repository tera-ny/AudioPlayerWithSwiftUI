//
//  ArtistListView.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2019/12/14.
//  Copyright © 2019 g4zeru. All rights reserved.
//

import SwiftUI
import MediaPlayer

struct ArtistListView: View {
    var body: some View {
        List.init(MPMediaQuery
            .artists()
            .collections?
            .compactMap { Artist.init(collection: $0) } ?? [],
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
