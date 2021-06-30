//
//  RaspBasics.swift
//  
//
//  Created by Maxim Volgin on 11/04/2021.
//

import Combine

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

@available(macOS 11, iOS 13, *)
public protocol RaspEventPublisher: Publisher where Output == RaspEvent {}

@available(macOS 11, iOS 13, *)
public protocol RaspStatePublisher: Publisher where Output == RaspState {}

@available(macOS 11, iOS 13, *)
public class RaspSource<P: RaspEventPublisher> {
    
    private let subject = PassthroughSubject<P, Never>()
    
    public init() {}
    
    public var value: P {
        return self.subject.switchToLatest().eraseToAnyPublisher() as! P
    }
    
    public func jump(to stream: P) {
        self.subject.send(stream)
    }
    
}
