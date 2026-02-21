//
//  CreditItem.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 21/2/26.
//

import Foundation

enum CreditSource: Codable {
    case pixabay, flickr, personal, fireentity, wikimedia
}

struct Credit: Codable, Identifiable {
    var id: UUID = UUID()
    var creatorName: String
    var attributedFor: String
    var linkToOriginal: String
    var urlLinkToOriginal: URL {
        return URL(string: linkToOriginal)!
    }
    var imageItem: String
    var creditSource: CreditSource = .flickr
}
