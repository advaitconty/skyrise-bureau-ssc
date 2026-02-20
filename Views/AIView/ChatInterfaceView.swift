//
//  Untitled.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 20/2/26.
//

import SwiftUI

extension AiView {
    func chatInterfaceView() -> some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    aiChatItem(messageType: .ai, messageContent: "Hello, and welcome to your Fleet Advisor! What would you like help with today")
                    // ADd here after backend
                    Color.clear
                        .id("BOTTOM")
                }
            }
            // Autoscrollers (for later)
            //        .onChange(of: conversationHistory.last) {
            //            proxy.scrollTo("BOTTOM", anchor: .bottom)
            //        }
            //        .onChange(of: session.transcript) {
            //            rebuildConversationFromTranscript()
            //            proxy.scrollTo("BOTTOM", anchor: .bottom)
            //        }
            HStack {
                TextField("What would you like advise on?", text: $itemEnteredInTextBox)
                    .padding()
                    .glassEffect()
                    .fontWidth(.condensed)
                    .onChange(of: itemEnteredInTextBox) {
                        if itemEnteredInTextBox.isEmpty {
                            withAnimation {
                                showSendButton = false
                            }
                        } else {
                            withAnimation {
                                showSendButton = true
                            }
                        }
                    }
                if showSendButton {
                    Button {
                        
                    } label: {
                        Image(systemName: "paperplane")
                            .padding(8)
                    }
                    .adaptiveButtonStyle()
                    .transition(.blurReplace)
                }
            }
        }
    }
}


#Preview(traits: .landscapeLeft) {
    AiView(userData: .constant(testUserDataEndgame))
}
