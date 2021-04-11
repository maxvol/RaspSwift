//
//  Observable+Rasp.swift
//  
//
//  Created by Maxim Volgin on 11/04/2021.
//

import Foundation
import Combine

public extension Observable where Element: RaspEvent {
    
    public func asRaspEvent() -> Observable<RaspEvent> {
        return map { value in return value as RaspEvent }
    }
    
}
