//
//  Observable+Rasp.swift
//  RaspSwift
//
//  Created by Maxim Volgin on 13/03/2017.
//  Copyright © 2017 Maxim Volgin. All rights reserved.
//

import Foundation
import RxSwift

public extension Observable where Element: RaspEvent {
    
    public func asRaspEvent() -> Observable<RaspEvent> {
        return map { value in return value as RaspEvent }
    }
    
}
