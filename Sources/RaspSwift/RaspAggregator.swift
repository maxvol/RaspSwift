//
//  RaspAggregator.swift
//  
//
//  Created by Maxim Volgin on 11/04/2021.
//

import Foundation
import Combine

public class RaspAggregator<S: RaspState> {

    public let events: RaspPublisher
    public let state: RaspPublisher<S>

    public static var defaultReducer: RaspReducer<S> {
        return RaspReducer<S> { (state, event) throws -> S in
            var newState = state
            newState.apply(event: event)
            return newState
        }
    }

    private let eventSwitch: CurrentValueSubject<RaspPublisher, Never>
    private let eventSink: PassthroughSubject<RaspEvent, Never> = PassthroughSubject()
    
    public init(initial state: S, reducer: RaspReducer<S> = RaspAggregator<S>.defaultReducer, sources: Publisher...) {
        self.eventSwitch = CurrentValueSubject(value: RaspPublisher.merge(sources))
        self.events = RaspPublisher.merge(self.eventSwitch.switchLatest(), self.eventSink)
        self.state = self.events.scan(state, accumulator: reducer.reduce).share()
    }

    public func select<R: Comparable>(selector: RaspSelector<S, R>) -> Publisher<R> {
        return self.state.map { state in
            return selector.select(state)
        }.distinctUntilChanged { (value) -> R in
            return value
        }
    }

    public func replace(sources: RaspPublisher...) {
        self.eventSwitch.send(RaspPublisher.merge(sources))
    }

    public func manual(event: RaspEvent) {
        self.eventSink.send(event)
    }
    
}
