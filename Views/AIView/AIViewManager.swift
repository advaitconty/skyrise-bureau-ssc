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
    var body: some View {
        VStack {
            HStack {
                Text("Fleet Advisor")
                    .font(.largeTitle)
                    .fontWidth(.expanded)
                Spacer()
                Button {
                    
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
