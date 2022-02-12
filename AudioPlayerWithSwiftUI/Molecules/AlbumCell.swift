//
//  AlbumCell.swift
//  AudioPlayerWithSwiftUI
//
//  Created by teranyan on 2019/12/14.
//  Copyright © 2019 teranyan. All rights reserved.
//

import SwiftUI

struct AlbumCell: View {
    private let album: Album
    init(album: Album) {
        self.album = album
    }

    var body: some View {
        VStack(alignment: .leading) {
            Image(uiImage: album.artwork ?? UIImage())
                .renderingMode(.original)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .cornerRadius(8)
            Text(album.title)
                .bold()
                .foregroundColor(.primary)
                .lineLimit(1)
            Text(album.artist)
                .font(.system(size: 13))
                .foregroundColor(.secondary)
                .lineLimit(1)
        }
    }
}

struct AlbumCell_Previews: PreviewProvider {
    static var previews: some View {
        AlbumCell(album: Album(title: "testsjklkslakjsdldaf", artist: "artist", date: Date(), artwork: #imageLiteral(resourceName: "ICON.png")))
    }
}
