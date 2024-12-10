//
//  ACSettings.swift
//  testtesettest
//
//  Created by 郭城 on 2024/12/9.
//

import SwiftUI
import SwiftData

// SwiftData model for AC settings
@Model
class ACSettings {
    var temperature: Double
    var isEcoModeOn: Bool
    var isPowerOff: Bool
    var roomLocation: String
    
    init(temperature: Double = 23,
         isEcoModeOn: Bool = false,
         isPowerOff: Bool = false,
         roomLocation: String = "Living Room") {
        self.temperature = temperature
        self.isEcoModeOn = isEcoModeOn
        self.isPowerOff = isPowerOff
        self.roomLocation = roomLocation
    }
}
