//
//  ArtistDetailRow.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2019/12/14.
//  Copyright © 2019 g4zeru. All rights reserved.
//

import SwiftUI

struct AlbumCell: View {
    private let album: Album
    init(album: Album) {
        self.album = album
    }
    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink(destination: AlbumDetailView(album: album)) {
                Image(uiImage: album.artwork ?? UIImage())
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .cornerRadius(8)
            }
            Text(album.title).bold().lineLimit(1)
            Text(Calendar.dateConvert(date: album.releaseDate) ?? "")
                .font(.system(size: 13))
        }
    }
}

struct ArtistDetailRow_Previews: PreviewProvider {
    static var previews: some View {
        AlbumCell(album: Album(title: "testsjklkslakjsdldaf", artist: "artist", date: Date(), artwork: #imageLiteral(resourceName: "ICON.png")))
    }
}
