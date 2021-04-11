//
//  RaspBasics.swift
//  
//
//  Created by Maxim Volgin on 11/04/2021.
//

import Foundation

public protocol RaspEvent {}

public protocol RaspState {
    mutating func apply(event: RaspEvent)
}

public struct RaspReducer<S: RaspState> {
    public let reduce: (S, RaspEvent) throws -> S
}

public struct RaspSelector<S: RaspState, R: Comparable> {
    public let select: (S) -> R
    
    public init(select: @escaping (S) -> R) {
        self.select = select
    }
}

public protocol RaspPublisher: Publisher where Output == RaspEvent {}

public class RaspSource {
    
    private let subject = PassthroughSubject<RaspPublisher, Never>()
    
    public init() {}
    
    public var value: RaspPublisher {
        return self.subject.switchLatest()
    }
    
    public func jump(to stream: RaspPublisher) {
        self.subject.send(stream)
    }
    
}
