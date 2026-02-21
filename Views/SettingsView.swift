//
//  SettingsView.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 8/12/25.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.dismissWindow) var dismissWindow
    @Environment(\.dismiss) var dismiss
    @Query var userData: [UserData]
    @Environment(\.modelContext) var modelContext
    var modifiableUserData: Binding<UserData>
    @Namespace var notifNamespace
    @Namespace var airportCodeNamespace
    @State var showReleaseNotes: Bool = false
    var body: some View {
        VStack {
            
            HStack {
                Image(systemName: "gearshape.2")
                    .font(.largeTitle)
                Text("Skyrise Bureau Settings")
                    .font(.largeTitle)
                    .fontWidth(.expanded)
                Spacer()
//                if !checkForMacCatalyst() {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .adaptiveButtonStyle()
//                }  targetEnvironment(macCatalyst)
            }
            Spacer()
            // MARK: Notification settings stuff
//            VStack {
//                HStack {
//                    Text("Preferred Airport Code Type:")
//                        .font(.title)
//                        .fontWidth(.expanded)
//                    Spacer()
//                }
//                HStack {
//                    Spacer()
//                    if #available(iOS 26.0, *) {
//                        if modifiableUserData.wrappedValue.preferedAirlineCodeType == .iata {
//                            Button {
//                                withAnimation {
//                                    modifiableUserData.wrappedValue.preferredAirlineCodeType = "iata"
//                                }
//                            } label: {
//                                Text("IATA (e.g. SIN, DXB, AUH, LHR, LAX)")
//                                    .fontWidth(.condensed)
//                            }
//                            .buttonStyle(.glassProminent)
//                            .matchedGeometryEffect(id: "airportCode:iata", in: airportCodeNamespace)
//                            
//                            Button {
//                                withAnimation {
//                                    modifiableUserData.wrappedValue.preferredAirlineCodeType = "icao"
//                                }
//                            } label: {
//                                Text("ICAO (e.g. WSSS, OMDB, OMAA, EGLL, KLAX)")
//                                    .fontWidth(.condensed)
//                            }
//                            .buttonStyle(.glass)
//                            .matchedGeometryEffect(id: "airportCode:icao", in: airportCodeNamespace)
//                        } else {
//                            Button {
//                                withAnimation {
//                                    modifiableUserData.wrappedValue.preferredAirlineCodeType = "iata"
//                                }
//                            } label: {
//                                Text("IATA (e.g. SIN, DXB, AUH, LHR, LAX)")
//                                    .fontWidth(.condensed)
//                            }
//                            .buttonStyle(.glass)
//                            .matchedGeometryEffect(id: "airportCode:iata", in: airportCodeNamespace)
//                            
//                            
//                            Button {
//                                withAnimation {
//                                    modifiableUserData.wrappedValue.preferredAirlineCodeType = "icao"
//                                }
//                            } label: {
//                                Text("ICAO (e.g. WSSS, OMDB, OMAA, EGLL, KLAX)")
//                                    .fontWidth(.condensed)
//                            }
//                            .buttonStyle(.glassProminent)
//                            .matchedGeometryEffect(id: "airportCode:icao", in: airportCodeNamespace)
//                        }
//                    } else {
//                        if modifiableUserData.wrappedValue.preferedAirlineCodeType == .iata {
//                            Button {
//                                withAnimation {
//                                    modifiableUserData.wrappedValue.preferredAirlineCodeType = "iata"
//                                }
//                            } label: {
//                                Text("IATA (e.g. SIN, DXB, AUH, LHR, LAX)")
//                                    .fontWidth(.condensed)
//                            }
//                            .buttonStyle(.borderedProminent)
//                            .matchedGeometryEffect(id: "airportCode:iata", in: airportCodeNamespace)
//                            
//                            Button {
//                                withAnimation {
//                                    modifiableUserData.wrappedValue.preferredAirlineCodeType = "icao"
//                                }
//                            } label: {
//                                Text("ICAO (e.g. WSSS, OMDB, OMAA, EGLL, KLAX)")
//                                    .fontWidth(.condensed)
//                            }
//                            .buttonStyle(.bordered)
//                            .matchedGeometryEffect(id: "airportCode:icao", in: airportCodeNamespace)
//                        } else {
//                            Button {
//                                withAnimation {
//                                    modifiableUserData.wrappedValue.preferredAirlineCodeType = "iata"
//                                }
//                            } label: {
//                                Text("IATA (e.g. SIN, DXB, AUH, LHR, LAX)")
//                                    .fontWidth(.condensed)
//                            }
//                            .buttonStyle(.bordered)
//                            .matchedGeometryEffect(id: "airportCode:iata", in: airportCodeNamespace)
//                            
//                            
//                            Button {
//                                withAnimation {
//                                    modifiableUserData.wrappedValue.preferredAirlineCodeType = "icao"
//                                }
//                            } label: {
//                                Text("ICAO (e.g. WSSS, OMDB, OMAA, EGLL, KLAX)")
//                                    .fontWidth(.condensed)
//                            }
//                            .buttonStyle(.borderedProminent)
//                            .matchedGeometryEffect(id: "airportCode:icao", in: airportCodeNamespace)
//                        }
//                        
//                    }
//                }
//            }
            
            VStack {
                HStack {
                    Text("Preferred Notification Types:")
                        .font(.title)
                        .fontWidth(.expanded)
                    Spacer()
                }
                HStack {
                    Spacer()
                    if #available(iOS 26.0, *) {
                        if modifiableUserData.wrappedValue.allowedNotificationTypes.contains(.arrival) {
                            Button {
                                withAnimation {
                                    modifiableUserData.wrappedValue.allowedNotificationTypes.removeAll(where: { $0 == .arrival })
                                }
                            } label: {
                                Text("Aircraft Arrival")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.glassProminent)
                            .matchedGeometryEffect(id: "notif:arrival", in: notifNamespace)
                            .hoverEffect()
                        } else {
                            Button {
                                withAnimation {
                                    modifiableUserData.wrappedValue.allowedNotificationTypes.append(.arrival)
                                }
                            } label: {
                                Text("Aircraft Arrival")
                            }
                            .buttonStyle(.glass)
                            .matchedGeometryEffect(id: "notif:arrival", in: notifNamespace)
                            .hoverEffect()
                        }
                        
                        if modifiableUserData.wrappedValue.allowedNotificationTypes.contains(.maintainanceEnd) {
                            Button {
                                withAnimation {
                                    modifiableUserData.wrappedValue.allowedNotificationTypes.removeAll(where: { $0 == .maintainanceEnd })
                                }
                            } label: {
                                Text("Aircraft Maintainance Completion")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.glassProminent)
                            .matchedGeometryEffect(id: "notif:maintainance", in: notifNamespace)
                            .hoverEffect()
                        } else {
                            Button {
                                withAnimation {
                                    modifiableUserData.wrappedValue.allowedNotificationTypes.append(.maintainanceEnd)
                                }
                            } label: {
                                Text("Aircraft Maintainance Completion")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.glass)
                            .matchedGeometryEffect(id: "notif:maintainance", in: notifNamespace)
                            .hoverEffect()
                        }
                        
                        if modifiableUserData.wrappedValue.allowedNotificationTypes.contains(.campaignEnd) {
                            Button {
                                withAnimation {
                                    modifiableUserData.wrappedValue.allowedNotificationTypes.removeAll(where: { $0 == .campaignEnd })
                                }
                            } label: {
                                Text("Marketing Campaign End")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.glassProminent)
                            .matchedGeometryEffect(id: "notif:campaign", in: notifNamespace)
                            .hoverEffect()
                        } else {
                            Button {
                                withAnimation {
                                    modifiableUserData.wrappedValue.allowedNotificationTypes.append(.campaignEnd)
                                }
                            } label: {
                                Text("Marketing Campaign End")
                                    .fontWidth(.condensed)
                            }
                            .buttonStyle(.glass)
                            .matchedGeometryEffect(id: "notif:campaign", in: notifNamespace)
                            .hoverEffect()
                        }
                    }
                }
            }
            
            
            Spacer()
            Divider()
            
            Spacer()
            VStack {
                HStack {
                    Image("AboutIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .padding()
                    VStack(alignment: .leading) {
                        Text("Skyrise Bureau")
                            .font(.title)
                            .fontWidth(.expanded)
                        HStack {
                            Image(systemName: "swift")
                            Text("Swift Student Challenge Edition")
                                .fontWidth(.expanded)
                        }
                        Button {
                            withAnimation {
                                showReleaseNotes.toggle()
                            }
                        } label: {
                            Text(showReleaseNotes ? "Hide release notes" : "Show release notes")
                                .fontWidth(.condensed)
                        }
                        .adaptiveProminentButtonStyle()
                        .hoverEffect()
                    }
                }
                Text("Made with 💚 by advaitconty")
                    .fontWidth(.expanded)
                
                
                if showReleaseNotes {
                    VStack(alignment: .leading) {
                        Text("What's new in the Swift Student Challenge Edition:")
                            .font(.subheadline)
                            .fontWidth(.expanded)
                        Text("- Game speed is 500x faster")
                            .fontWidth(.condensed)
                        
                        
                        Text("- Apple Maps is removed in favour of an canvas rendering the offline map")
                            .fontWidth(.condensed)
                        
                        
                        Text("- Fuel price refreshes are every 30s instead of 1 hour")
                            .fontWidth(.condensed)
                    }
                    .padding()
                    .background(.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .transition(.blurReplace)
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SettingsView(modifiableUserData: .constant(testUserDataEndgame))
}
