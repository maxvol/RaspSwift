//
//  RaspState.swift
//  RaspSwift
//
//  Created by Maxim Volgin on 13/03/2017.
//  Copyright © 2017 Maxim Volgin. All rights reserved.
//

import Foundation

public protocol RaspState {
    mutating func apply(event: RaspEvent)
}
