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

///  Oberservable Patter Design
///
///
protocol ObservableProtocol {
    var observers : [ObserverProtocol] { get set }
    
    func addObserver(_ observer: ObserverProtocol)
    func removeObserver(_ observer: ObserverProtocol)
    func notifyObservers(_ observers: [ObserverProtocol])
}

class OberserverInstance : ObserverProtocol {

    var identifier: String
    init() {
        self.identifier = UUID().uuidString
        print("init OberserverInstance \(self.identifier)")
    }
    
    deinit {
        print("deinit OberserverInstance \(self.identifier)")
    }
    
}

protocol ObserverProtocol {
    
    var identifier : String { get }

}

extension ObserverProtocol {
    var identifier: String {
        get {
            return UUID().uuidString
        }
    }
}

class Observable<T> {
    
    typealias CompletionHandler = ((T) -> Void)
    
    var value : T {
        didSet {
            self.notifyObservers(self.observers)
        }
    }
    
    var observers : [String : CompletionHandler] = [:]
    
    init(value: T) {
        self.value = value
    }
    
    func addObserver(_ observer: ObserverProtocol, completion: @escaping CompletionHandler) {
        self.observers[observer.identifier] = completion
    }
    
    func removeObserver(_ observer: ObserverProtocol) {
        self.observers.removeValue(forKey: observer.identifier)
    }
    
    func notifyObservers(_ observers: [String : CompletionHandler]) {
        observers.forEach({ $0.value(value) })
    }
    
    deinit {
        observers.removeAll()
        print("deinited Observable class")
    }
}


