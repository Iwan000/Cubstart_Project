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
    @State private var isNavigatingToACView = false

    var body: some View {
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

            // Room Selection (You can add more rooms as needed)
            HStack {
                Button(action: {
                    isNavigatingToACView = true
                }) {
                    Text("Living Room")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                }
                NavigationLink(destination: ACView(), isActive: $isNavigatingToACView) {
                    EmptyView()
                }
                Button(action: {}) {
                    Text("Kitchen")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                }
            }
            .padding()

            // Scheduler
            HStack {
                Image(systemName: "calendar")
                Text("Scheduler")
                Spacer()
                Toggle("", isOn: $isSchedulerOn)
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
            }
            .padding()

            // Device Cards
            VStack(spacing: 16) {
                DeviceCard(title: "HomePod", isOn: $isHomePodOn)
                DeviceCard(title: "AC", isOn: $isACOn)
                DeviceCard(title: "Smart TV", isOn: $isSmartTVOn)
                DeviceCard(title: "Light", isOn: $isLightOn)
            }
            .padding()
        }
        .navigationTitle("Smart Home")
    }
}

struct DeviceCard: View {
    let title: String
    @Binding var isOn: Bool

    var body: some View {
        HStack {
            Image(systemName: "circle.fill")
                .font(.largeTitle)
                .foregroundColor(.blue)
            Text(title)
                .font(.headline)
            Spacer()
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: .blue))
            Button(action: {}) {
                Image(systemName: "gear")
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}
