//
//  PromptStructs.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 20/2/26.
//

import Foundation
import SwiftUI


enum MesssageMessenger: Codable {
    case ai, user
}

struct ChatMessage: Codable, Identifiable {
    var id: UUID = UUID()
    var messageType: MesssageMessenger
    var text: String
    var displayedMessage: LocalizedStringKey {
        return LocalizedStringKey(text)
    }
}
