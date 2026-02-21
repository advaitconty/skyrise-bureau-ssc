//
//  AIView.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 20/2/26.
//

import SwiftUI
import FoundationModels

struct AiView: View {
    @Binding var userData: UserData
    @State var AIState: AIAvailabilityInformation? = nil
    @State var itemEnteredInTextBox: String = ""
    @State var showSendButton: Bool = false
    @State var sessionManager = AISessionManager()
    @State var randomThinkingQuote: String = ""
    @State var timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    @State var showClearHistoryButton: Bool = false
    @State var showClearHistoryAlert: Bool = false
    @State var showThinkingDialogue: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Text("Fleet Advisor")
                    .font(.largeTitle)
                    .fontWidth(.expanded)
                    .onReceive(timer) { _ in
                        print("called")
                        withAnimation {
                            randomThinkingQuote = playfulThinkingQuotes.randomElement()!
                        }
                    }
                    .onAppear {
                        withAnimation {
                            randomThinkingQuote = playfulThinkingQuotes.randomElement()!
                        }
                    }
                
                Spacer()
                if showClearHistoryButton {
                    Button {
                        showClearHistoryAlert = true
                    } label: {
                        Image(systemName: "trash")
                            .font(.title)
                    }
                    .adaptiveButtonStyle()
                    .transition(.blurReplace)
                    .alert("Are you sure?", isPresented: $showClearHistoryAlert) {
                        Button("OK", role: .destructive) {
                            withAnimation {
                                userData.aiChatHistory.removeAll()
                            }
                        }
                        
                        Button("Cancel", role: .cancel) { }
                    } message: {
                        Text("All your chat history with your Fleet Advisor will be deleted.")
                    }
                }
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title)
                }
                .adaptiveButtonStyle()
            }
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .symbolRenderingMode(.multicolor)
                Text("Powered by Apple Intelligence. Advice may not always be accurate.")
                    .fontWidth(.condensed)
                Spacer()
            }
            validationPlusChatInterfaceView()
        }
        .padding()
    }
}

#Preview {
    AiView(userData: .constant(testUserDataEndgame))
}
