//
//  AIManager.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 19/2/26.
//

import Foundation
import FoundationModels

struct AIAvailabilityInformation {
    var availability: Bool
    var reasonForNotWorking: String?
    var deviceDoesntSupportFeature: Bool = false
}

func checkAIAvailabilty() -> AIAvailabilityInformation {
    switch SystemLanguageModel.default.availability {
    case .available:
        return AIAvailabilityInformation(availability: true)
    case .unavailable(let reason):
        switch reason {
        case .appleIntelligenceNotEnabled:
            return AIAvailabilityInformation(availability: false,
                reasonForNotWorking: "Your Fleet Advisor is powered by Apple Intelligence, which hasn't been enabled on this device. Enable it in Settings to get started.")

        case .deviceNotEligible:
            return AIAvailabilityInformation(availability: false,
                reasonForNotWorking: "Your Fleet Advisor requires Apple Intelligence, which isn't supported on this device.",
                deviceDoesntSupportFeature: true)

        case .modelNotReady:
            return AIAvailabilityInformation(availability: false,
                reasonForNotWorking: "Apple Intelligence is still setting up. Your Fleet Advisor will be available once it's ready.")

        @unknown default:
            return AIAvailabilityInformation(availability: false,
                reasonForNotWorking: "Your Fleet Advisor is temporarily unavailable. Please try again later.")
        }
    }
}
