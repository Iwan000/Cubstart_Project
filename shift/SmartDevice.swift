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
    var icon: String
    var colorName: String // Store color as a string
    
    enum DeviceType: String, Codable {
        case light
        case thermostat
        case securityCamera
        case smartPlug
        case speaker
    }
    
    init(name: String, type: DeviceType, isOn: Bool = false, roomLocation: String = "Unassigned", icon: String = "circle.fill", color: Color = Color.gray) {
        self.id = UUID()
        self.name = name
        self.type = type
        self.isOn = isOn
        self.roomLocation = roomLocation
        self.icon = icon
        self.colorName = color.toName()
    }

    // Computed property to access the Color
    var color: Color {
        get { Color.fromName(colorName) }
        set { colorName = newValue.toName() }
    }

    // Static method to create default devices
    static func createDefaultDevices() -> [SmartDevice] {
        return [
            SmartDevice(name: "HomePod", type: .speaker, isOn: false, roomLocation: "Living Room", icon: "homepod.fill", color: .purple),
            SmartDevice(name: "AC", type: .thermostat, isOn: false, roomLocation: "Living Room", icon: "snowflake", color: .blue),
            SmartDevice(name: "Smart TV", type: .speaker, isOn: false, roomLocation: "Living Room", icon: "tv.fill", color: .black),
            SmartDevice(name: "Light", type: .light, isOn: false, roomLocation: "Living Room", icon: "lightbulb.fill", color: .yellow)
        ]
    }
}


import SwiftUI

extension Color {
    static func fromName(_ name: String) -> Color {
        switch name.lowercased() {
        case "white":
            return .white
        case "black":
            return .black
        case "red":
            return .red
        case "green":
            return .green
        case "blue":
            return .blue
        case "yellow":
            return .yellow
        case "purple":
            return .purple
        case "gray":
            return .gray
        default:
            return .clear // Default or fallback color
        }
    }

    func toName() -> String {
        switch self {
        case .white:
            return "white"
        case .black:
            return "black"
        case .red:
            return "red"
        case .green:
            return "green"
        case .blue:
            return "blue"
        case .yellow:
            return "yellow"
        case .purple:
            return "purple"
        case .gray:
            return "gray"
        default:
            return "clear"
        }
    }
}

