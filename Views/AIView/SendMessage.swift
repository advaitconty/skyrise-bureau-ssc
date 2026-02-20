//
//  SendMessage.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 20/2/26.
//

import SwiftUI

extension AiView {
    func sendMessage() async {
        let text = itemEnteredInTextBox.trimmingCharacters(in: .whitespaces)
        guard !text.isEmpty, !sessionManager.isResponding else { return }
        
        itemEnteredInTextBox = ""
        showSendButton = false
        
        conversationHistory.append(ChatMessage(messageType: .user, text: text))
        
        conversationHistory.append(ChatMessage(messageType: .ai, text: ""))
        let aiIndex = conversationHistory.count - 1
        
        do {
            try await sessionManager.sendStreaming(text) { partial in
                if String(partial) != "null" {
                    conversationHistory[aiIndex].text = partial
                }
            }
        } catch {
            conversationHistory[aiIndex].text = "Something went wrong. Please try again."
        }
    }
}
