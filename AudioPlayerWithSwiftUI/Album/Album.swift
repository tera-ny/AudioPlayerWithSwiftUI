//
//  Album.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2019/12/13.
//  Copyright © 2019 g4zeru. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

struct Album: Identifiable {
    var title: String
    var artist: String
    var releaseDate: Date?
    var artwork: UIImage?
    var items: [MPMediaItem]
    var id: MPMediaEntityPersistentID
    init(collection: MPMediaItemCollection) {
        self.title = collection.representativeItem?.albumTitle ?? ""
        self.artist = collection.representativeItem?.albumArtist ?? ""
        self.releaseDate = collection.representativeItem?.releaseDate
        self.artwork = collection.representativeItem?.artwork?.image(at: CGSize(width: 200, height: 200))
        self.items = collection.items
        self.id = collection.representativeItem!.albumPersistentID
    }
    
    init(title: String, artist: String, date: Date? = nil, artwork: UIImage? = nil) {
        self.title = title
        self.artist = artist
        self.releaseDate = date
        self.artwork = artwork
        self.items = []
        self.id = UInt64.random(in: 0...2000)
    }
}
