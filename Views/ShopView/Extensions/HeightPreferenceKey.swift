//
//  HeightPreferenceKey.swift
//  Skyrise Bureau SSC
//
//  Created by Milind Contractor on 17/2/26.
//

import SwiftUI

struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}
