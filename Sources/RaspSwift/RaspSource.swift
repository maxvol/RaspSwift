//
//  RaspSource.swift
//  
//
//  Created by Maxim Volgin on 11/04/2021.
//

import Foundation
import Combine

public class RaspSource {
    
    private let subject = PublishSubject<Observable<RaspEvent>>()
    
    public init() {}
    
    public var value: Observable<RaspEvent> {
        return self.subject.switchLatest()
    }
    
    public func jump(to stream: Observable<RaspEvent>) {
        self.subject.onNext(stream)
    }
    
}
