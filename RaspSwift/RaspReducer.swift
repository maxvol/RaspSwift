//
//  RaspReducer.swift
//  RaspSwift
//
//  Created by Maxim Volgin on 13/03/2017.
//  Copyright © 2017 Maxim Volgin. All rights reserved.
//

import Foundation

public struct RaspReducer<S: RaspState> {
    public let reduce: (S, RaspEvent) throws -> S
}

