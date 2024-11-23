//
//  SmartHomeView.swift
//  Cubstart_Project
//
//  Created by 郭城 on 2024/11/21.
//


//
//  SmartHomeView.swift
//  Cubstart_Project
//
//  Created by 郭城 on 2024/11/21.
//
import SwiftUI

struct SmartHomeView: View {
    @State private var isAllDevicesOn = true
    @State private var isSchedulerOn = false
    @State private var isHomePodOn = false
    @State private var isACOn = false
    @State private var isSmartTVOn = false
    @State private var isLightOn = false

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Text("All Devices")
                        .font(.headline)
                    Spacer()
                    Toggle("", isOn: $isAllDevicesOn)
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                    Button(action: {}) {
                        Image(systemName: "plus")
                    }
                }
                .padding()

                HStack {
                    Button(action: {
                        // Living Room action
                    }) {
                        Text("Living Room")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(.systemGray5))
                            .cornerRadius(10)
                    }
                    Button(action: {
                        // Navigate to SmartTVView
                    }) {
                        NavigationLink(destination: SmartTVView()) {
                            Text("Smart TV")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(.systemGray5))
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()

                ToggleRow(iconName: "calendar", title: "Scheduler", isOn: $isSchedulerOn)
                Divider()

                VStack {
                    DeviceToggleRow(deviceName: "HomePod", isOn: $isHomePodOn)
                    DeviceToggleRow(deviceName: "AC", isOn: $isACOn)
                    DeviceToggleRow(deviceName: "Smart TV", isOn: $isSmartTVOn)
                    DeviceToggleRow(deviceName: "Light", isOn: $isLightOn)
                }
            }
            .padding()
            .navigationBarTitle("Smart Home", displayMode: .inline)
        }
    }
}

// Reusable rows
struct ToggleRow: View {
    let iconName: String
    let title: String
    @Binding var isOn: Bool

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.blue)
            Text(title)
            Spacer()
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: .blue))
        }
        .padding()
    }
}

struct DeviceToggleRow: View {
    let deviceName: String
    @Binding var isOn: Bool

    var body: some View {
        HStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 20, height: 20)
            Text(deviceName)
                .font(.headline)
            Spacer()
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: .blue))
            Button(action: {}) {
                Image(systemName: "gear")
                    .foregroundColor(.blue)
            }
        }
        .padding(.vertical, 10)
    }
}
