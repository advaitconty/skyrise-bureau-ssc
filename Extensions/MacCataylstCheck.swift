//
//  MacCataylstCheck.swift
//  Skyrise Bureau
//
//  Created by Advait Contractor on 13/1/26.
//

import Foundation

func checkForMacCatalyst() -> Bool {
    return ProcessInfo.processInfo.isMacCatalystApp
}
