# README #

**RASP - Reactive Aggregate State Pipeline**

This Unidirectonal Data Flow framework is inspired by Redux and built on top op RxSwift framework.
Comparing to other similar frameworks, it is exceptionally simple by design and requires the very minimum of boilerplate code.

https://medium.com/p/5a690383e18e

Rather than declaring plenty of Publish/BehaviorSubjects and grouping them ad hoc by *.combineLatest()*,
on many occasions it makes more sense to group state values together by domain, such as:

* REST/HATEOAS state with recent links
* geolocation state
* UI navigation state
* lifecycle state
* motion state
* data state
* etc.

That way, at every value update you have a _complete snapshot_ of what is going on in particular domain.
Besides, there is only one way to update domain state, namely by sending event to the state aggregator - this ensures _consistency_ of every state snapshot.

![alt text](https://github.com/maxvol/RaspSwift/blob/master/rasp.png "Diagram")

How it works (per domain state):

* events from different sources are gathered into a single stream with *.merge()* operator
* on every event from the combined stream, it gets applied (reduced) to the current state via *.scan()* operator
* consumers can subscribe to domain state as a whole or to a single field by using selector which is *.map().distinctUntilChanged()*

For example, combining independently updated heading and location into one consistent geolocation state snapshot would look as follows -

![alt text](https://github.com/maxvol/RaspSwift/blob/master/rasp-geo.png "Diagram")

...where events and state are defined as follows:
```swift
struct GeoEvent: RaspEvent {
    case heading(heading)
    case location(Location)
}

struct GeoState: RaspState {
var heading: Heading
    var location: Location

    mutating func apply(event: RaspEvent) {
        switch event {
        case let geoEvent as GeoEvent:
            switch event {
            case .heading(let heading):
                self.heading = heading
            case .location(let location):
                self.location = location
            }
        default:
            break
        }
    }
}
```
A more generic example of usage:

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

github "maxvol/RaspSwift" ~> 0.1.2

* Configuration
* Dependencies

github "ReactiveX/RxSwift" ~> 4.4.1


