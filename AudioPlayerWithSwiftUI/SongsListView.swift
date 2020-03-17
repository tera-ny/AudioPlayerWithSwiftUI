//
//  SongsListView.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2019/12/19.
//  Copyright © 2019 g4zeru. All rights reserved.
//

import MediaPlayer
import SwiftUI

struct SongsListView: View {
    private let songs = MPMediaQuery.songs()
    var body: some View {
        let sections = songs.itemSections ?? []
        let items = self.songs.items
        return List {
            ForEach(sections, id: \.self) { section in
                Section(header: Text(section.title)) {
                    if items != nil {
                        ForEach(items![section.range.location ..< section.range.location + section.range.length].map { $0 }, id: \.self) { item in
                            Button(action: {
                                self.play(item: item)
                            }) {
                                HStack {
                                    Text(item.title ?? "")
                                    Spacer()
                                    Text(Calendar.timeToString(interval: item.playbackDuration))
                                        .font(.system(size: 14, weight: .light, design: .default))
                                        .foregroundColor(.pink)
                                }
                            }
                        }
                    } else {
                        EmptyView()
                    }
                }
            }
        }
        .navigationBarTitle(Text("Songs"))
    }

    private func play(item: MPMediaItem) {
        guard let items = songs.items else {
            return
        }
        QueueDispatcher.shared.on(action: (MPMediaItemCollection(items: items), item))
    }
}

struct SongsListView_Previews: PreviewProvider {
    static var previews: some View {
        SongsListView()
    }
}
