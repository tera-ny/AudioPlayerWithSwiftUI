//
//  AlbumListView.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2019/12/13.
//  Copyright © 2019 g4zeru. All rights reserved.
//

import SwiftUI
import MediaPlayer

struct AlbumListView: View {
    var body: some View {
        List(MPMediaQuery.albums().collections?
            .compactMap { $0 }
            .map{Album.init(collection: $0)} ?? [],
             id: \.id) { album in
            NavigationLink(destination: AlbumDetailView(album: album)) {
                AlbumListViewRow(album: album)
            }
        }.navigationBarTitle(Text("Albums"))
    }
}

struct AlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView()
    }
}
