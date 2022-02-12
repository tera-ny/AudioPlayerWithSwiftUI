//
//  Album.swift
//  AudioPlayerWithSwiftUI
//
//  Created by teranyan on 2019/12/13.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer
import UIKit

struct Album: Identifiable {
    var title: String
    var artist: String
    var artistID: MPMediaEntityPersistentID?
    var releaseDate: Date?
    var artwork: UIImage?
    var items: [MPMediaItem]
    var id: MPMediaEntityPersistentID
    init(collection: MPMediaItemCollection) {
        title = collection.representativeItem?.albumTitle ?? ""
        artist = collection.representativeItem?.albumArtist ?? ""
        artistID = collection.representativeItem?.artistPersistentID
        releaseDate = collection.representativeItem?.releaseDate
        artwork = collection.representativeItem?.artwork?.image(at: CGSize(width: 200, height: 200))
        items = collection.items
        id = collection.representativeItem!.albumPersistentID
    }

    init(title: String, artist: String, date: Date? = nil, artwork: UIImage? = nil) {
        self.title = title
        self.artist = artist
        releaseDate = date
        self.artwork = artwork
        items = []
        id = UInt64.random(in: 0 ... 2000)
    }
}
