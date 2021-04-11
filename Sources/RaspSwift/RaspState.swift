//
//  RaspState.swift
//  
//
//  Created by Maxim Volgin on 11/04/2021.
//

import Foundation

public protocol RaspState {
    mutating func apply(event: RaspEvent)
}
