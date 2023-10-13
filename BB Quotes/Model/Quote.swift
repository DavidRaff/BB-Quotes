//
//  Quote.swift
//  BB Quotes
//
//  Created by David Laczkovits on 09.10.23.
//

import Foundation

struct Quote : Decodable {
    let quote : String
    let character : String
    let production : String
}
