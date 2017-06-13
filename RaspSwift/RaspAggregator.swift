//
//  RaspAggregator.swift
//  RaspSwift
//
//  Created by Maxim Volgin on 13/03/2017.
//  Copyright © 2017 Maxim Volgin. All rights reserved.
//

import Foundation
import RxSwift

public class RaspAggregator<S: RaspState> {
    
    public let events: Observable<RaspEvent>
    public let state: Observable<S>
    
    public static var defaultReducer: RaspReducer<S> {
        return RaspReducer<S> { (state, event) throws -> S in
            var newState = state
            newState.apply(event: event)
            return newState
        }
    }
    
    public init(initial state: S, reducer: RaspReducer<S> = RaspAggregator<S>.defaultReducer, sources: Observable<RaspEvent>...) {
        self.events = Observable.merge(sources)
        self.state = self.events.scan(state, accumulator: reducer.reduce)
    }
    
    public func select<R: Comparable>(selector: RaspSelector<S, R>) -> Observable<R> {
        return self.state.map { state in
            return selector.select(state)
            }.distinctUntilChanged { (value) -> R in
                return value
        }
    }
    
    
}
