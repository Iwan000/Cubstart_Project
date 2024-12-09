//
//  SmartHome.swift
//  Cubstart_Project
//
//  Created by 郭城 on 2024/12/9.
//
import SwiftUI
import Foundation
import SwiftData

@Model
class SmartDevice {
    var id: UUID
    var name: String
    var type: DeviceType
    var isOn: Bool
    var roomLocation: String
    
    enum DeviceType: String, Codable {
        case light
        case thermostat
        case securityCamera
        case smartPlug
        case speaker
    }
    
    init(name: String, type: DeviceType, isOn: Bool = false, roomLocation: String = "Unassigned") {
        self.id = UUID()
        self.name = name
        self.type = type
        self.isOn = isOn
        self.roomLocation = roomLocation
    }
    
    // Static method to create default devices
    static func createDefaultDevices() -> [SmartDevice] {
        return [
            SmartDevice(name: "HomePod", type: .speaker, isOn: false, roomLocation: "Living Room"),
            SmartDevice(name: "AC", type: .thermostat, isOn: false, roomLocation: "Living Room"),
            SmartDevice(name: "Smart TV", type: .speaker, isOn: false, roomLocation: "Living Room"),
            SmartDevice(name: "Light", type: .light, isOn: false, roomLocation: "Living Room")
        ]
    }
}
