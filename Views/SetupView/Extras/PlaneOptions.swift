//
//  PlaneOptions.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 22/11/25.
//

import SwiftUI

extension SetupView {
    func option(icon: String, name: String, jet1: String, jet2: String, jet1Full: String, jet2Full: String, startingCapital: String, focus: String, option: Int) -> some View {
            VStack {
                HStack {
                    Image(systemName: icon)
                        .font(.title)
                    Text(name)
                        .font(.title)
                        .fontWidth(.expanded)
                }
                carousell(jet1: jet1, jet2: jet2)
                Text(focus)
                    .fontWidth(.condensed)
                
                VStack {
                    HStack {
                        Image(systemName: "airplane")
                        Text("Starting fleet")
                            .font(.title2)
                            .fontWidth(.expanded)
                    }
                    .padding(.bottom, 3)
                    
                    Text(jet1Full)
                        .fontWidth(.expanded)
                    Text(jet2Full)
                        .fontWidth(.expanded)
                }
                .padding()
                .background(Color.gray.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                
                HStack {
                    Text("Starting capital: \(startingCapital)")
                        .font(.title2)
                        .fontWidth(.condensed)
                }
            }
            .padding()
            .frame(width: 450, height: 450)
            .background(fleetChoice == option ? Color.accentColor : (colorScheme == .dark ? Color(red: 18/255, green: 18/255, blue: 18/255) : Color(red: 237/255, green: 237/255, blue: 237/255)))
            .clipShape(RoundedRectangle(cornerRadius: 22.5, style: .continuous))
            .shadow(color: colorScheme == .dark ? .white.opacity(0.01) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
            .onTapGesture {
                withAnimation {
                    fleetChoice = option
                }
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("\(name) starter pack. \(focus). Fleet: \(jet1Full) and \(jet2Full). Starting capital: \(startingCapital)")
            .accessibilityValue(fleetChoice == option ? "Selected" : "Not selected")
            .accessibilityHint("Double tap to select this starter pack")
            .accessibilityAddTraits(fleetChoice == option ? .isSelected : [])
    }

}
