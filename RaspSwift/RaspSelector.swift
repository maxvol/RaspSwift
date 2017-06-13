//
//  RaspSelector.swift
//  RaspSwift
//
//  Created by Maxim Volgin on 13/03/2017.
//  Copyright © 2017 Maxim Volgin. All rights reserved.
//

import Foundation

public struct RaspSelector<S: RaspState, R: Comparable> {
    public let select: (S) -> R
    
    public init(select: @escaping (S) -> R) {
        self.select = select
    }
}
