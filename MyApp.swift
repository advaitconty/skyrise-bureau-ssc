//
//  Skyrise_BureauApp.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 5/11/25.
//

import SwiftUI
import SwiftData
import Foundation

@MainActor
final class WindowRegistry: ObservableObject {
    @Published var openFleetWindows = 0
}

/// Enum to decide what data type to use
enum DataTypeToUse: Codable {
    case regular, flyingPlanes, endGame, none
}

@main
struct Skyrise_BureauApp: App {
    /// This is for reseting the SwiftData variable
    let resetUserData: Bool = false
    
    /// For the usage of any test data
    let useTestData: DataTypeToUse = .none
    
    /// ENSURE ALL VARIABLES ABOVE ARE SET TO false BEFORE FINAL
    /// BUILD OF APP
    
    @Environment(\.openWindow) var openWindow
    
    var body: some Scene {
        let sharedModelContainer: ModelContainer = {
            let schema = Schema([
                UserData.self,
            ])
            let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            return try! ModelContainer(for: schema, configurations: [config])
        }()
        
        WindowGroup("Welcome to Skyrise Bureau!", id: "welcome") {
            WelcomeView(debug: resetUserData)
        }
        .windowResizability(.contentSize)
        .modelContainer(sharedModelContainer)
        
        WindowGroup("Skyrise Bureau", id: "main") {
            ContentView(resetUserData: resetUserData, useTestData: useTestData)
        }
        .modelContainer(sharedModelContainer)
        .commands {
            CommandGroup(replacing: .appInfo) {
                Button {
                    openWindow(id: "about")
                } label: {
                    Text("About Skyrise Bureau")
                }
            }
        }
        
        WindowGroup("Jet Set Emporium", id: "shop") {
            AirplaneStoreView()
        }
        .windowResizability(.contentSize)
        .modelContainer(sharedModelContainer)
        .commands {
            CommandGroup(replacing: .appInfo) {
                Button {
                    openWindow(id: "about")
                } label: {
                    Text("About Skyrise Bureau")
                }
            }
        }
        
        WindowGroup("About Your Airline", id: "attributes") {
            UserUpgradeView()
            //            Text("stupid shit just work")
        }
        .modelContainer(sharedModelContainer)
        .windowResizability(.contentSize)
        .commands {
            CommandGroup(replacing: .appInfo) {
                Button {
                    openWindow(id: "about")
                } label: {
                    Text("About Skyrise Bureau")
                }
            }
        }
        
        WindowGroup("KEROX", id: "fuel") {
            FuelPriceView()
        }
        .windowResizability(.contentSize)
        .modelContainer(sharedModelContainer)
        .commands {
            CommandGroup(replacing: .appInfo) {
                Button {
                    openWindow(id: "about")
                } label: {
                    Text("About Skyrise Bureau")
                }
            }
        }
        
        WindowGroup("About Skyrise Bureau", id: "about") {
            AboutView()
        }
        .windowResizability(.contentSize)
        
        // MARK: Todo: reimplement settings
//        WindowGroup {
//            SettingsView()
//        }
//        .modelContainer(sharedModelContainer)
    }
}
