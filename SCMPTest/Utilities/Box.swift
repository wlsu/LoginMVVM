//
//  Box.swift
//  SCMPTest
//
//  Created by su on 26/4/2021.
//

import Foundation

final class Box<T> {
    //1
    typealias Listener = (T) -> Void
    var listener: Listener?
    //2 TODO: Support multiple binding, to slove communications between VMs
    // https://developer.apple.com/documentation/combine/receiving-and-handling-events-with-combine
    // Use combine to implement subscribe/pubisher way
    var value: T {
        didSet {
            // only 1 listener, could only 1 binging
            // to support multiple binding, need use DisposeBag
            listener?(value)
        }
    }
    //3
    init(_ value: T) {
        self.value = value
    }
    //4
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
