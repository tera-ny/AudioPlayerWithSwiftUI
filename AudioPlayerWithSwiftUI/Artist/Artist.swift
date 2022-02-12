//
//  Artist.swift
//  AudioPlayerWithSwiftUI
//
//  Created by teranyan on 2019/12/14.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer

struct Artist {
    let id: UInt64
    let name: String
    init? (collection: MPMediaItemCollection) {
        guard let item = collection.representativeItem else { return nil }
        id = item.artistPersistentID
        name = item.artist ?? ""
    }
}
