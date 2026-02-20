//
//  AISessionManager.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 20/2/26.
//

import FoundationModels
import Foundation


enum AISessionError: Error {
    case noSession
}

@Observable
class AISessionManager: ObservableObject {
    private var session: LanguageModelSession?
    var isResponding: Bool = false
    
    func setup(userData: UserData) {
        let toolingList: [any Tool] = [
            GetAirlineOverview(userData: userData),
            GetFleetStatus(userData: userData),
            GetStaffStatus(userData: userData),
            GetFuelStatus(userData: userData),
            GetFinancialSummaries(userData: userData),
            LookupAirport(),
            LookupAircraft(),
            CalculateRouteDistance()
        ]
        
        session = LanguageModelSession(model: .default, tools: toolingList, instructions: buildBasePrompt(userData: userData))
    }
    
    func send(_ message: String) async throws -> String {
        guard let session else { throw AISessionError.noSession }
        isResponding = true
        defer { isResponding = false }
        let response = try await session.respond(to: message)
        return response.content
    }
    
    func sendStreaming(_ message: String, onToken: @escaping (String) -> Void) async throws {
        guard let session else { throw AISessionError.noSession }
        isResponding = true
        defer { isResponding = false }
        
        let stream = session.streamResponse(to: message)
        for try await partial in stream {
            onToken(partial.content)
        }
    }
}
