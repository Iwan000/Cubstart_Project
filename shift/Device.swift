//
//  Device.swift
//  Cubstart_Project
//
//  Created by 郭城 on 2024/12/9.
//

import SwiftUI
import SwiftData

@Model
class Device {
    var id: UUID = UUID()
    var name: String
    var isOn: Bool

    init(name: String, isOn: Bool = false) {
        self.name = name
        self.isOn = isOn
    }
}

