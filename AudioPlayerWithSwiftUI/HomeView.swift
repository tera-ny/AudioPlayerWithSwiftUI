//
//  HomeView.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2019/12/13.
//  Copyright © 2019 g4zeru. All rights reserved.
//

import MediaPlayer
import StoreKit
import SwiftUI

struct HomeView: View {
    enum HomeListElement: String, CaseIterable {
        case Albums
        case Artist
        case Songs
        case PlayList
        case Genre
    }

    private class QueueObserver {
        private var token: String?
        private var dispatcher: QueueDispatcher
        deinit {
            dispatcher.unSubscribe(token: token!)
        }

        init(dispatcher: QueueDispatcher, player: MPMusicPlayerController) {
            self.dispatcher = dispatcher
            token = dispatcher.subscribe { collection, item in
                player.setQueue(with: collection)
                if let item = item {
                    player.setQueue(with: collection)
                    player.nowPlayingItem = item
                    player.prepareToPlay()
                    player.play()
                }
            }
        }
    }

    @State private var shouldPresent: Bool = false
    private let miniPlayerHeight: CGFloat = 70
    private let player: MPMusicPlayerController
    private let queueObserver: QueueObserver

    init() {
        MPMediaLibrary.requestAuthorization { _ in }
        player = .applicationMusicPlayer
        queueObserver = QueueObserver(dispatcher: .shared, player: player)
    }

    var body: some View {
        let state = MPMediaLibrary.authorizationStatus()
        print(state)
        return ZStack(alignment: .bottom) {
            NavigationView {
                VStack {
                    if state == .denied || state == .restricted {
                        HStack(alignment: .center, spacing: 20) {
                            Text("メディアアクセスを有効にしてください")
                                .foregroundColor(.pink)
                                .font(.system(size: 15, weight: Font.Weight.medium))
                            Spacer()
                            Button(action: {
                                guard let url = URL(string: UIApplication.openSettingsURLString) else {
                                    return
                                }
                                if UIApplication.shared.canOpenURL(url) {
                                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                }
                            }) {
                                Text("設定へ")
                                    .font(.system(size: 15, weight: Font.Weight.regular))
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    List(HomeListElement.allCases, id: \.id) { element in
                        if element.isComingSoon {
                            HStack(alignment: .center) {
                                Text(element.rawValue)
                                    .font(.system(size: 25))
                                Spacer()
                                Text("Coming soon")
                                    .font(.system(size: 16))
                                    .foregroundColor(.secondary)
                            }
                        } else {
                            NavigationLink(destination: element.view) {
                                Text(element.rawValue)
                                .font(.system(size: 25))
                            }
                        }
                    }
                    .navigationBarTitle(Text("Home"))
                }
            }.padding(.bottom, miniPlayerHeight)
            MiniPlayerView(height: miniPlayerHeight, player: player)
                .onTapGesture {
                    self.shouldPresent = self.player.nowPlayingItem != nil
                }
                .sheet(isPresented: $shouldPresent) {
                    PlayerView(player: self.player)
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension HomeView.HomeListElement {
    var id: String {
        return rawValue
    }

    var isComingSoon: Bool {
        switch self {
        case .Albums, .Artist, .Songs:
            return false
        default:
            return true
        }
    }

    var view: AnyView {
        switch self {
        case .Albums:
            return AnyView(AlbumListView().navigationBarTitle(Text("Albums")))
        case .Artist:
            return AnyView(ArtistListView())
        case .Songs:
            return AnyView(SongsListView())
        default:
            return AnyView(ContentView())
        }
    }
}

struct SKCloudServiceSetupView: UIViewControllerRepresentable {
    typealias UIViewControllerType = SKCloudServiceSetupViewController

    func makeUIViewController(context _: UIViewControllerRepresentableContext<SKCloudServiceSetupView>) -> SKCloudServiceSetupView.UIViewControllerType {
        return UIViewControllerType()
    }

    func updateUIViewController(_: SKCloudServiceSetupView.UIViewControllerType, context _: UIViewControllerRepresentableContext<SKCloudServiceSetupView>) {}
}

class CloudServiceSetupStatus: NSObject, SKCloudServiceSetupViewControllerDelegate, ObservableObject {
    @Published var shouldClose: Bool = false
    func cloudServiceSetupViewControllerDidDismiss(_: SKCloudServiceSetupViewController) {
        shouldClose = true
    }
}
