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
        
        withAnimation {
            itemEnteredInTextBox = ""
            showSendButton = false
            
            userData.aiChatHistory.append(ChatMessage(messageType: .user, text: text))
            
            userData.aiChatHistory.append(ChatMessage(messageType: .ai, text: ""))
        }
        let aiIndex = userData.aiChatHistory.count - 1
        
        do {
            try await sessionManager.sendStreaming(text) { partial in
                if String(partial) != "null" {
                    userData.aiChatHistory[aiIndex].text = partial
                }
            }
        } catch {
            userData.aiChatHistory[aiIndex].text = "Something went wrong. Please try again."
        }
    }
}
