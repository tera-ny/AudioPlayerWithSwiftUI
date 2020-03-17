//
//  AlbumListViewRow.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2019/12/13.
//  Copyright © 2019 g4zeru. All rights reserved.
//

import SwiftUI

struct AlbumListViewRow: View {
    private let album: Album
    private let image: Image
    private let canPushArtistList: Bool
    init(album: Album, canPushArtistList: Bool = false) {
        let artwork = album.artwork ?? UIImage()
        image = Image(uiImage: artwork)
        self.album = album
        self.canPushArtistList = canPushArtistList
    }
    var body: some View {
        HStack {
            image.resizable().frame(width: 120, height: 120).cornerRadius(8)
            VStack(alignment: .leading) {
                Text(album.title)
                    .font(.system(size: 19))
                    .bold()
                    .lineLimit(2)
                if canPushArtistList {
                    NavigationLink(destination: ArtistDetailView(artistID: album.artistID!, artist: album.artist)) {
                            Text(self.album.artist)
                                .font(.system(size: 16))
                                .foregroundColor(.pink)
                                .lineLimit(2)
                    }.buttonStyle(PlainButtonStyle())
                } else {
                    Text(self.album.artist)
                        .font(.system(size: 16))
                        .foregroundColor(.pink)
                        .lineLimit(2)
                }
                Spacer()
                Text(Calendar.dateConvert(date: album.releaseDate) ?? "").font(.system(size: 14))
            }
        }
    }
}

struct AlbumListViewRow_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListViewRow(album: .init(title: "テスト", artist: "テスト"))
    }
}
