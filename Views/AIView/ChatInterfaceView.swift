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
                    
                    ForEach(conversationHistory) { message in
                        aiChatItem(messageType: message.messageType, messageContent: message.displayedMessage)
                    }
                    
                    Color.clear
                        .id("BOTTOM")
                }
                .onChange(of: conversationHistory.count) {
                    withAnimation {
                        proxy.scrollTo("BOTTOM", anchor: .bottom)
                    }
                }
                
                .onChange(of: sessionManager.isResponding) {
                    withAnimation {
                        proxy.scrollTo("BOTTOM", anchor: .bottom)
                    }
                }
            }
            VStack {
                if sessionManager.isResponding {
                    HStack {
                        ProgressView()
                        Image(systemName: "apple.intelligence")
                            .font(.caption)
                        
                        Text(randomThinkingQuote)
                            .fontWidth(.expanded)
                            .font(.caption)
                            .transition(.blurReplace)
                        Spacer()
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .glassEffect()
//                    .background(Color.accentColor.opacity(0.2))
//                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                }
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
                        .onSubmit {
                            Task {
                                await sendMessage()
                            }
                        }
                    if showSendButton {
                        Button {
                            Task {
                                await sendMessage()
                            }
                        } label: {
                            Image(systemName: "paperplane")
                                .padding(8)
                        }
                        .adaptiveButtonStyle()
                        .transition(.blurReplace)
                    }
                }
            }
            .padding()
        }
    }
}


#Preview(traits: .landscapeLeft) {
    AiView(userData: .constant(testUserDataEndgame))
}
