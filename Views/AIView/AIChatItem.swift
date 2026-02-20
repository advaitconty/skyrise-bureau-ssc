//
//  AIChatItem.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 20/2/26.
//

import SwiftUI

extension AiView {
    func aiChatItem(messageType: MesssageMessenger, messageContent: LocalizedStringKey) -> some View {
        VStack {
            if messageType == .ai {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Image(systemName: "apple.intelligence")
                            .font(.title3)
                        Text("Fleet Advisor")
                            .font(.title3)
                            .fontWidth(.expanded)
                        Spacer()
                    }
                    .padding()
                    VStack {
                        Text(messageContent)
                            .fontWidth(.condensed)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                }
                .foregroundStyle(.white)
                .background(Color.accentColor)
                .clipShape(RoundedRectangle(cornerRadius: 12.5))
            } else {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Image(systemName: "person")
                            .font(.title)
                        VStack(alignment: .leading) {
                            Text(userData.name)
                                .font(.title3)
                                .fontWidth(.expanded)
                            Text("CEO of \(userData.airlineName)")
                                .fontWidth(.expanded)
                                .font(.caption)
                        }
                        Spacer()
                    }
                    .padding()
                    VStack {
                        Text(messageContent)
                            .fontWidth(.condensed)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                }
                .background(Color.accentColor.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 12.5))
            }
        }
    }
}

#Preview {
    AiView(userData: .constant(testUserDataEndgame))
}
