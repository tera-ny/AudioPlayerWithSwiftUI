//
//  HomeView.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2019/12/13.
//  Copyright © 2019 g4zeru. All rights reserved.
//

import SwiftUI
import MediaPlayer
import StoreKit

struct HomeView: View {
    enum HomeListElement: String, CaseIterable {
        case Albums
        case Artist
        case Songs
        case PlayList
        case Genre
    }
    init() {
        MPMediaLibrary.requestAuthorization { status in
            print(status)
        }
    }
    var body: some View {
        NavigationView {
            List(HomeListElement.allCases, id: \.id) { element in
                NavigationLink(destination: element.view) {
                    VStack {
                        Text(element.rawValue)
                            .font(.system(size: 25))
                    }
                }
            }
            .navigationBarTitle(Text("Home"))
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
        return self.rawValue
    }
    var view: AnyView {
        switch self {
        case .Albums:
            return AnyView(AlbumListView())
        case .Artist:
            return AnyView(ArtistListView())
        default:
            return AnyView(ContentView())
        }
    }
}

struct SKCloudServiceSetupView : UIViewControllerRepresentable {

    typealias UIViewControllerType = SKCloudServiceSetupViewController

    func makeUIViewController(context: UIViewControllerRepresentableContext<SKCloudServiceSetupView>) -> SKCloudServiceSetupView.UIViewControllerType {
        return UIViewControllerType()
    }

    func updateUIViewController(_ uiViewController: SKCloudServiceSetupView.UIViewControllerType, context: UIViewControllerRepresentableContext<SKCloudServiceSetupView>) {
    }
}

class CloudServiceSetupStatus: NSObject, SKCloudServiceSetupViewControllerDelegate, ObservableObject {
    @Published var shouldClose: Bool = false
    func cloudServiceSetupViewControllerDidDismiss(_ cloudServiceSetupViewController: SKCloudServiceSetupViewController) {
        shouldClose = true
    }
}
