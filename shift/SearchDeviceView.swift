//
//  SearchDeviceView.swift
//  Cubstart_Project
//
//  Created by cyh on 12/9/24.
//

import SwiftUI

struct SearchDeviceView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    @State private var showDevices = false
    @State private var selectedDevice: String?
    @State private var showAddAlert = false
    
    // Sample device data structured as (name, icon, type)
    let devices = [
        ("Living Room TV", "tv.fill", "Smart TV"),
        ("Bedroom AC", "snowflake", "AC"),
        ("Kitchen HomePod", "homepod.fill", "HomePod"),
        ("Study Lamp", "lightbulb.fill", "Light"),
        ("Dining Room Light", "lightbulb.fill", "Light"),
        ("Bedroom TV", "tv.fill", "Smart TV"),
        ("Living Room HomePod", "homepod.fill", "HomePod")
    ]
    
    // Filter devices based on search text
    var filteredDevices: [(String, String, String)] {
        if searchText.isEmpty {
            return devices
        }
        return devices.filter { device in
            device.0.lowercased().contains(searchText.lowercased()) ||
            device.2.lowercased().contains(searchText.lowercased())
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search for devices", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                    
                    if !searchText.isEmpty {
                        Button(action: {
                            searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
                
                if filteredDevices.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("No devices found")
                            .font(.headline)
                        Text("Try searching with a different keyword")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    // Devices list
                    List {
                        ForEach(filteredDevices, id: \.0) { device in
                            HStack {
                                Image(systemName: device.1)
                                    .foregroundColor(getDeviceColor(type: device.2))
                                    .frame(width: 30)
                                VStack(alignment: .leading) {
                                    Text(device.0)
                                        .font(.headline)
                                    Text(device.2)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Button(action: {
                                    selectedDevice = device.0
                                    showAddAlert = true
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.blue)
                                        .font(.title2)
                                }
                            }
                            .padding(.vertical, 4)
                            .opacity(showDevices ? 1 : 0)
                            .offset(x: showDevices ? 0 : 50)
                            .animation(
                                .easeOut(duration: 0.3)
                                .delay(Double(filteredDevices.firstIndex(where: { $0.0 == device.0 })!) * 0.1),
                                value: showDevices
                            )
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Add Device")
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                }
            )
            .onAppear {
                showDevices = true
            }
            .alert("Add Device", isPresented: $showAddAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Add") {
                    // Add device logic here
                    dismiss()
                }
            } message: {
                if let device = selectedDevice {
                    Text("Do you want to add \(device) to your Smart Home?")
                }
            }
        }
    }
    
    // Helper function to get color based on device type
    private func getDeviceColor(type: String) -> Color {
        switch type {
        case "Smart TV":
            return .gray
        case "AC":
            return .blue
        case "HomePod":
            return .purple
        case "Light":
            return .yellow
        default:
            return .blue
        }
    }
}

#Preview {
    SearchDeviceView()
}
