//: Playground - noun: a place where people can play

import UIKit

public struct RaspEvent<Base> {
    
    /// Base object to extend.
    public let base: Base
    
    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    public init(_ base: Base) {
        self.base = base
    }

}

enum MyEvent {
    case one
    case two
}

enum MyEvent1 {
    case one1
    case two1
}

extension RaspEvent where Base == MyEvent {
    func boo() {}
}

extension RaspEvent where Base == MyEvent1 {
    func boo1() {}
}

let e: RaspEvent = RaspEvent(MyEvent.one)

e.boo()












