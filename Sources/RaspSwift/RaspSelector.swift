//
//  RaspSelector.swift
//  
//
//  Created by Maxim Volgin on 11/04/2021.
//

import Foundation

public struct RaspSelector<S: RaspState, R: Comparable> {
    public let select: (S) -> R
    
    public init(select: @escaping (S) -> R) {
        self.select = select
    }
}
