//
//  PlaneCarousell.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 22/11/25.
//

import SwiftUI

extension SetupView {
    func carousell(jet1: String, jet2: String) -> some View {
        VStack {
            if carousellItem == 1 {
                Image(jet1)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    .transition(.asymmetric(insertion: .slide, removal: .scale))
                    .accessibilityLabel("\(jet1) aircraft preview")
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
                            withAnimation {
                                carousellItem = 2
                            }
                        }
                    }
            } else if carousellItem == 2 {
                Image(jet2)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    .transition(.asymmetric(insertion: .slide, removal: .scale))
                    .accessibilityLabel("\(jet2) aircraft preview")
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
                            withAnimation {
                                carousellItem = 1
                            }
                        }
                    }
            }
        }
        .frame(width: 220, height: 132.5)
    }

}
