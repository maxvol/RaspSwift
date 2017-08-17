# README #

**RASP - Reactive Aggregate State Pipeline**

This framework is inspired by Redux and built on top op RxSwift framework.
Comparing to other similar frameworks, it is exceptionally simple by design and requires the very minimum of boilerplate code.

On many occasions, it makes more sense to group state values together by domain, such as:

* REST/HATEOAS state with recent links
* geolocation state
* UI navigation state
* lifecycle state
* motion state
* etc.

How it works (per domain state):

* events from different sources are gathered into a single stream with *.merge()* operator
* on every event from the combined stream, it gets applied (reduced) to the current state via *.scan()* operator
* consumers can subscribe to domain state as a whole or to a single field by using selector which is *.map().distinctUntilChanged()*

Example of usage:

```swift
struct MyRestState: RaspState {
    var links: [String: String] = [:]

    mutating func apply(event: RaspEvent) {
        switch event {
        case let event1 as Event1:
            self.links["\(event1.value)"] = "\(event1.value)"
        default:
        break
        }
    }
}

struct Event1: RaspEvent {
    let value: Int
}

let scheduler = SerialDispatchQueueScheduler(qos: .default)
let event1 = Observable<Int>.interval(0.3, scheduler: scheduler).take(5).map { value in
    return Event1(value: value)
}

let scheduler2 = SerialDispatchQueueScheduler(qos: .default)
let event2 = Observable<Int>.interval(0.5, scheduler: scheduler2).take(5).map { value in
    return Event1(value: value)
}

let myRestAggregator = RaspAggregator<MyRestState>(initial: MyRestState(), sources: event1.asRaspEvent(), event2.asRaspEvent())

myRestAggregator.state.subscribe( onNext: { state in
    print("\(state)")
}).disposed(by: self.disposeBag)

let sel1 = RaspSelector<MyRestState, Int> { state -> Int in
    let value: Int = state.links.count
    return value
}

let one1 = myRestAggregator.select(selector: sel1)

one1.subscribe( onNext: { field in
    print("\(field)")
}).disposed(by: self.disposeBag)
```

* Version

0.0.3

### How do I get set up? ###

* Summary of set up

github "maxvol/RaspSwift" ~> 0.0.3

* Configuration
* Dependencies

github "ReactiveX/RxSwift" ~> 3.5.0


