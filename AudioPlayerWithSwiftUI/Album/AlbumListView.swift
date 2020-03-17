//
//  AlbumListView.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2019/12/13.
//  Copyright © 2019 g4zeru. All rights reserved.
//

import MediaPlayer
import QGrid
import SwiftUI

struct AlbumListView: View {
    var body: some View {
        QGrid(MPMediaQuery.albums()
            .collections?
            .compactMap { Album(collection: $0) } ?? [],
              columns: UIDevice.current.orientation.isLandscape ? 3 : 2, vPadding: 0) { album in
            NavigationLink(destination: AlbumDetailView(album: album)) {
                AlbumCell(album: album)
            }
        }
    }
}

struct AlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView()
    }
}
