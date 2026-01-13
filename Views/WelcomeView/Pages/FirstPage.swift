//
//  FirstPage.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 22/11/25.
//

import SwiftUI

extension WelcomeView {
    func pageOneView() -> some View {
        VStack {
            if showLogo {
                HStack {
                    Image(systemName: "airplane")
                        .font(.title)
                    Text("Welcome to Skyrise Bureau!")
                        .font(.title)
                        .fontWidth(.expanded)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                withAnimation(.default, completionCriteria: .logicallyComplete) {
                                    showLogo = false
                                } completion: {
                                    withAnimation {
                                        showBody = true
                                    }
                                }
                            }
                        }
                }
                .transition(.push(from: .leading))
            }
            if showBody {
                VStack {
                    Text("Select an airline name to get started!")
                        .font(.title3)
                        .fontWidth(.expanded)
                    
                    GlassTextField("Airline Name", $userDataForAddition.airlineName, "Etihad Airways", monospaced: true)
                    
                    GlassTextField("Airline CEO", $userDataForAddition.name, "Antonoaldo Neves", monospaced: true)
                    
                    GlassTextField("IATA Code", $userDataForAddition.airlineIataCode, "2-letter airline code (e.g., EY, LH, EK)", monospaced: true)
                }
                .transition(.blurReplace)
                .onChange(of: userDataForAddition.airlineIataCode) {
                    if !userDataForAddition.airlineName.isEmpty && !userDataForAddition.airlineIataCode.isEmpty && userDataForAddition.airlineIataCode.count == 2 && !userDataForAddition.name.isEmpty {
                        withAnimation {
                            showNextForAirport = true
                        }
                    } else {
                        withAnimation {
                            showNextForAirport = false
                        }
                    }
                    
                }
                .onChange(of: userDataForAddition.airlineName) {
                    if !userDataForAddition.airlineName.isEmpty && !userDataForAddition.airlineIataCode.isEmpty && userDataForAddition.airlineIataCode.count == 2 && !userDataForAddition.name.isEmpty {
                        withAnimation {
                            showNextForAirport = true
                        }
                    } else {
                        withAnimation {
                            showNextForAirport = false
                        }
                    }
                    
                }
                .onChange(of: userDataForAddition.name) {
                    if !userDataForAddition.airlineName.isEmpty && !userDataForAddition.airlineIataCode.isEmpty && userDataForAddition.airlineIataCode.count == 2 && !userDataForAddition.name.isEmpty {
                        withAnimation {
                            showNextForAirport = true
                        }
                    } else {
                        withAnimation {
                            showNextForAirport = false
                        }
                    }
                    
                }
            }
            if showNextForAirport {
                Button {
                    withAnimation(.default, completionCriteria: .removed) {
                        viewPage = 2
                    } completion: {
                        print("Done")
                    }
                } label: {
                    Image(systemName: "arrow.right")
                    Text("Next (select your airport)")
                        .fontWidth(.condensed)
                }
                .transition(.blurReplace)
                .adaptiveProminentButtonStyle()
            }
        }
        .transition(.slide)
    }
}
