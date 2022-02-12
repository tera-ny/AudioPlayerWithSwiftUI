//
//  AlbumListView.swift
//  AudioPlayerWithSwiftUI
//
//  Created by teranyan on 2019/12/13.
//  Copyright © 2019 teranyan. All rights reserved.
//

import MediaPlayer
import SwiftUI

struct AlbumListView: View {
    var body: some View {
        ScrollView(content: {
            LazyVGrid(columns: [GridItem(), GridItem()], spacing: 20, content: {
                ForEach(MPMediaQuery.albums().collections?.compactMap { Album(collection: $0) } ?? []) { album in
                    NavigationLink(
                        destination: AlbumDetailView(album: album),
                        label: {
                            AlbumCell(album: album)
                        })
                }
            }).padding(.horizontal, 20)
        })
    }
}

struct AlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView()
    }
}
