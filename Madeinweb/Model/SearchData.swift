//
//  SearchData.swift
//  Madeinweb
//
//  Created by Caio  Marastoni on 01/08/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import Foundation

struct SearchData: Decodable {
    let items: [Items]
}

struct Items: Decodable {
    let kind: String
    let etag: String
    let snippet: Snippet
    
}

struct Snippet: Decodable {
    let title: String
    let description: String
    let thumbnails: Thumbnail
}

struct ChannelURL: Decodable {
    var url = ""
}

struct Thumbnail: Decodable {
    let medium: ChannelURL
    let high: ChannelURL
    
}

