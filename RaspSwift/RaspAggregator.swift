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

    private let eventSwitch: BehaviorSubject<Observable<RaspEvent>>
    private let eventSink: PublishSubject<RaspEvent> = PublishSubject()
//    private let stateSink: BehaviorSubject<S>
//    private let disposeBag = DisposeBag()
    
    public init(initial state: S, reducer: RaspReducer<S> = RaspAggregator<S>.defaultReducer, sources: Observable<RaspEvent>...) {
        self.eventSwitch = BehaviorSubject(value: Observable.merge(sources))
        self.events = Observable.merge(self.eventSwitch.switchLatest(), self.eventSink)
//        self.stateSink = BehaviorSubject(value: state)
//        self.state = self.stateSink.asObservable()
//        self.events.scan(state, accumulator: reducer.reduce).subscribe(self.stateSink).disposed(by: self.disposeBag)
        self.state = self.events.scan(state, accumulator: reducer.reduce).replay(1).share()
    }

    public func select<R: Comparable>(selector: RaspSelector<S, R>) -> Observable<R> {
        return self.state.map { state in
            return selector.select(state)
        }.distinctUntilChanged { (value) -> R in
            return value
        }
    }

    public func replace(sources: Observable<RaspEvent>...) {
        self.eventSwitch.onNext(Observable.merge(sources))
    }

    public func manual(event: RaspEvent) {
        self.eventSink.onNext(event)
    }
    
}
