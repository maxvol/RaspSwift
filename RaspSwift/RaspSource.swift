//
//  RaspSource.swift
//  RaspSwift
//
//  Created by Maxim Volgin on 13/03/2017.
//  Copyright © 2017 Maxim Volgin. All rights reserved.
//

import Foundation
import RxSwift

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
