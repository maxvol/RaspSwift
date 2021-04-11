//
//  RaspReducer.swift
//  
//
//  Created by Maxim Volgin on 11/04/2021.
//

import Foundation

public struct RaspReducer<S: RaspState> {
    public let reduce: (S, RaspEvent) throws -> S
}
