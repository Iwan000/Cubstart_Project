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
import SwiftData

struct SmartHomeView: View {
    // SwiftData query to fetch devices
    @Query(sort: \SmartDevice.name) private var devices: [SmartDevice]
    
    // Environment variable to access the model context
    @Environment(\.modelContext) private var modelContext
    
    // State for overall control
    @State private var isAllDevicesOn = false
    @State private var isSchedulerOn = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Text("All Devices")
                        .font(.headline)
                    Spacer()
                    Toggle("", isOn: Binding(
                        get: { isAllDevicesOn },
                        set: { newValue in
                            isAllDevicesOn = newValue
                            // Toggle all devices on/off
                            devices.forEach { device in
                                device.isOn = newValue
                            }
                            saveDevices()
                        }
                    ))
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                    
                    Button(action: addNewDevice) {
                        Image(systemName: "plus")
                    }
                }
                .padding()

                // Room Selection
                HStack {
                    NavigationLink(destination: ACView()) {
                        Text("AC")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: SmartTVView()) {
                        Text("Smart TV")
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
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(devices, id: \.id) { device in
                            DeviceCard(device: device, onToggle: saveDevices)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Smart Home")
        }
        .onAppear(perform: addDefaultDevicesIfNeeded)
    }
    
    private func addDefaultDevicesIfNeeded() {
        // Check if any devices exist, if not, add defaults
        if devices.isEmpty {
            let defaultDevices = SmartDevice.createDefaultDevices()
            defaultDevices.forEach { device in
                modelContext.insert(device)
            }
            saveDevices()
        }
    }
    
    private func addNewDevice() {
        let newDevice = SmartDevice(
            name: "New Device",
            type: .smartPlug,
            isOn: false,
            roomLocation: "Unassigned"
        )
        modelContext.insert(newDevice)
        saveDevices()
    }
    
    private func saveDevices() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save devices: \(error)")
        }
    }
}

struct DeviceCard: View {
    @Bindable var device: SmartDevice
    var onToggle: () -> Void

    var body: some View {
        HStack {
            Image(systemName: "circle.fill")
                .font(.largeTitle)
                .foregroundColor(device.isOn ? .blue : .gray)
            
            Text(device.name)
                .font(.headline)
            
            Spacer()
            
            Toggle("", isOn: Binding(
                get: { device.isOn },
                set: { newValue in
                    device.isOn = newValue
                    onToggle()
                }
            ))
            .toggleStyle(SwitchToggleStyle(tint: .blue))
            
            Button(action: {
                // Future: Add device settings action
            }) {
                Image(systemName: "gear")
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

// Preview with sample data
#Preview {
    SmartHomeView()
        .modelContainer(for: SmartDevice.self, inMemory: true)
}
