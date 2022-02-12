//
//  KVOObserver.swift
//  AudioPlayerWithSwiftUI
//
//  Created by teranyan on 2020/03/21.
//  Copyright © 2020 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer
import WebKit

class KVOObserver<Object: NSObject, Value>: ObservableObject {
    var disposeBag = [NSKeyValueObservation]()
    @Published var observedObject: Value!
    var monitoredObject: Object
    init(monitoredObject: Object, keypath: KeyPath<Object, Value>) {
        observedObject = monitoredObject[keyPath: keypath]
        self.monitoredObject = monitoredObject
        disposeBag.append(monitoredObject.observe(keypath, options: .new) { [weak self] _, _ in
            self?.observedObject = monitoredObject[keyPath: keypath]
        })
    }
}
