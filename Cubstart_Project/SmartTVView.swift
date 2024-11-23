//
//  SmartTVView.swift
//  Cubstart_Project
//
//  Created by Knox on 2024/11/22.
//

import SwiftUI

struct SmartTVView: View {
    @State private var isHDRModeOn = false
    @State private var isHighResolutionOn = true
    @State private var isLEDLightingOn = true
    @State private var isAutoPlayOn = false

    var body: some View {
        NavigationView {
            VStack {
                // Header
                HStack {
                    Button(action: {
                        // Navigate back
                    }) {
                        Image(systemName: "chevron.left")
                    }
                    Spacer()
                    Text("Smart TV")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Button(action: {
                        // Close view
                    }) {
                        Image(systemName: "xmark")
                    }
                }
                .padding()

                // Subheader
                Text("for Living Room")
                    .foregroundColor(.blue)
                    .padding(.bottom, 20)

                // Smart TV Icon
                Image(systemName: "tv")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .foregroundColor(.blue)
                    .padding()

                // HDR Mode Toggle
                HStack {
                    Text("HDR mode")
                        .bold()
                    Spacer()
                    Toggle("", isOn: $isHDRModeOn)
                        .toggleStyle(SwitchToggleStyle(tint: .red))
                }
                .padding(.horizontal)
                .padding(.vertical, 10)

                Text("Improves the quality of a picture by showing more detail in both the brightest and darkest areas.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal)

                // Additional Settings
                VStack {
                    SettingToggleRow(settingName: "High Resolution", isOn: $isHighResolutionOn)
                    SettingToggleRow(settingName: "LED Ambient Lighting", isOn: $isLEDLightingOn)
                    SettingToggleRow(settingName: "Auto-Play", isOn: $isAutoPlayOn)
                }
                .padding()

                // Remove Device Button
                Button(action: {
                    // Remove device logic
                }) {
                    Text("Remove Device")
                        .foregroundColor(.red)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }
}

// Reusable row for toggle settings
struct SettingToggleRow: View {
    let settingName: String
    @Binding var isOn: Bool

    var body: some View {
        HStack {
            Text(settingName)
            Spacer()
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: .green))
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}
