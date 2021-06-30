//
//  RaspAggregator.swift
//  
//
//  Created by Maxim Volgin on 11/04/2021.
//

import Foundation
import Combine

/*
@available(macOS 11, iOS 13, *)
public class RaspAggregator<S: RaspState, E: RaspEventPublisher, P: RaspStatePublisher> {

    public let events: E
    public let state: P

    public static var defaultReducer: RaspReducer<S> {
        return RaspReducer<S> { (state, event) throws -> S in
            var newState = state
            newState.apply(event: event)
            return newState
        }
    }

    private let eventSwitch: CurrentValueSubject<E, Never>
    private let eventSink: PassthroughSubject<RaspEvent, Never> = PassthroughSubject()
    
    public init(initial state: S, reducer: RaspReducer<S> = RaspAggregator<S, E, P>.defaultReducer, sources: E...) {
        self.eventSwitch = CurrentValueSubject(value: E.merge(sources))
        self.events = E.merge(self.eventSwitch.switchLatest(), self.eventSink)
        self.state = self.events.scan(state, accumulator: reducer.reduce).share()
    }

    public func select<R: Comparable>(selector: RaspSelector<S, R>) -> Publisher<R> {
        return self.state.map { state in
            return selector.select(state)
        }.distinctUntilChanged { (value) -> R in
            return value
        }
    }

    public func replace(sources: E...) {
        self.eventSwitch.send(E.merge(sources))
    }

    public func manual(event: RaspEvent) {
        self.eventSink.send(event)
    }
    
}
*/
