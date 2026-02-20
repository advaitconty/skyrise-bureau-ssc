//
//  ValidationView.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 20/2/26.
//

import SwiftUI

extension AiView {
    func validationPlusChatInterfaceView() -> some View {
        VStack {
            if AIState == nil {
                VStack {
                    Spacer()
                    ProgressView()
                    Text("Loading...")
                        .fontWidth(.condensed)
                    Spacer()
                        .onAppear {
                            AIState = checkAIAvailabilty()
                        }
                }
            } else if !AIState!.availability {
                VStack {
                    Spacer()
                    Image(systemName: "apple.intelligence.badge.xmark")
                        .symbolRenderingMode(.multicolor)
                        .font(.largeTitle)
                    Text("Fleet Advisor is unavailable, as Apple Intelligence is reporting an error.")
                        .font(.title)
                        .fontWidth(.expanded)
                        .multilineTextAlignment(.center)
                    Text(AIState?.reasonForNotWorking ?? "")
                        .font(.title3)
                        .fontWidth(.condensed)
                    Spacer()
                }
            } else {
                chatInterfaceView()
            }
        }
    }
}
    
    
    #Preview {
        AiView(userData: .constant(testUserDataEndgame))
    }
