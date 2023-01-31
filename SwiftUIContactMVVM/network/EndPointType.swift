//
//  EndPointType.swift
//  SwiftUIContactMVVM
//
//  Created by Abduqaxxor on 30/1/23.
//

import Foundation

public protocol EndPointType {
    var scheme: String { get }
    var baseUrl: String { get }
    var path: String { get }
    var body: Data { get }
    var method: String { get }
}
