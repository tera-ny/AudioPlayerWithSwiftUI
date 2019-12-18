//
//  CustomeHostingViewController.swift
//  AudioPlayerWithSwiftUI
//
//  Created by iniad on 2019/12/14.
//  Copyright © 2019 g4zeru. All rights reserved.
//

import UIKit
import SwiftUI
import RxSwift
import RxCocoa
import MediaPlayer

class CustomCustomHostingViewController<Content: View>: UIViewController {
    private let hostingController: UIHostingController<Content>
    private let miniPlayer: UIHostingController<MiniPlayerView>
    private let miniControllerView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let playerHeight: CGFloat
    private let disposeBag = DisposeBag()
    private let playerView = PlayerView()
    private var timer: Timer = Timer()
    init(root: Content) {
        let playerHeight: CGFloat = 70
        self.playerHeight = playerHeight
        hostingController = UIHostingController(rootView: root)
        miniPlayer = UIHostingController(rootView: MiniPlayerView(height: playerHeight))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        super.loadView()
        self.view.addSubview(contentView)
        self.view.addSubview(miniControllerView)
        miniPlayer.view.backgroundColor = .clear
        NSLayoutConstraint.activate([
            miniControllerView.heightAnchor.constraint(equalToConstant: playerHeight),
            miniControllerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            miniControllerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            miniControllerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: self.view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),

        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Dispatcher.shared.showPlayer.asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.present(UIHostingController(rootView: PlayerView()), animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayContentController(content: hostingController, container: contentView)
        displayContentController(content: miniPlayer, container: miniControllerView.contentView)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideContentController(content: hostingController)
    }
    func displayContentController(content:UIViewController, container:UIView){
        addChild(content)
        content.view.frame = container.bounds
        content.view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(content.view)
        NSLayoutConstraint.activate([
            content.view.topAnchor.constraint(equalTo: container.topAnchor),
            content.view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            content.view.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            content.view.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        content.didMove(toParent: self)
    }
    
    func hideContentController(content:UIViewController){
        content.willMove(toParent: self)
        content.view.removeFromSuperview()
        content.removeFromParent()
    }
}
