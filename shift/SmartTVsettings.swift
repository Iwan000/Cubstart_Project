//
//  SmartTVsettings.swift
//  testtesettest
//
//  Created by 郭城 on 2024/12/9.
//

import SwiftUI
import SwiftData

@Model
class SmartTV {
    var id: UUID
    var name: String
    var location: String
    var isHDRModeOn: Bool
    var isHighResolutionOn: Bool
    var isLEDLightingOn: Bool
    var isAutoPlayOn: Bool
    
    init(
        id: UUID = UUID(),
        name: String = "Smart TV",
        location: String = "Living Room",
        isHDRModeOn: Bool = false,
        isHighResolutionOn: Bool = true,
        isLEDLightingOn: Bool = true,
        isAutoPlayOn: Bool = false
    ) {
        self.id = id
        self.name = name
        self.location = location
        self.isHDRModeOn = isHDRModeOn
        self.isHighResolutionOn = isHighResolutionOn
        self.isLEDLightingOn = isLEDLightingOn
        self.isAutoPlayOn = isAutoPlayOn
    }
    
    // Class method to create default TV
    static func createDefaultTV() -> SmartTV {
        return SmartTV()
    }
}
