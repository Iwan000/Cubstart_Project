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
    
    @State private var showDevices = false  // New state for controlling animation
    @State private var showingSearchDevice = false
    
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
                    Button(action: {
                        showingSearchDevice = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
                .padding()

                HStack {
                    NavigationLink(destination: ACView()) {
                        HStack {
                            Image(systemName: "snowflake")
                            Text("AC")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: SmartTVView()) {
                        HStack {
                            Image(systemName: "tv.fill")
                            Text("Smart TV")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                }
                .padding()

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
            .sheet(isPresented: $showingSearchDevice) {
                SearchDeviceView()
            }
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
    
    private func addNewDevice(name: String = "New Device", type: SmartDevice.DeviceType = SmartDevice.DeviceType.smartPlug, isOn: Bool = false, roomLocation: String = "Unassigned") {
        let newDevice = SmartDevice(
            name: name,
            type: type,
            isOn: isOn,
            roomLocation: roomLocation
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
//    let title: String
//    let icon: String
//    @Binding var isOn: Bool
//    let color: Color
    @State private var cardOffset: CGFloat = 0
    
    var body: some View {
        HStack {
            Image(systemName: device.icon)
                .font(.system(size: 24))
                .foregroundColor(device.isOn ? Color(device.color) : .gray)
                .frame(width: 40, height: 40)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(radius: device.isOn ? 3 : 0)
            Text(device.name)
                .font(.headline)
            Spacer()
            
            Toggle("", isOn: Binding(
                get: { device.isOn },
                set: { newValue in
                    device.isOn = newValue
                    onToggle()
                }
            )).toggleStyle(SwitchToggleStyle(tint: Color(device.color)))
                .onChange(of: device.isOn) { _, newValue in
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        cardOffset = 5
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            cardOffset = 0
                        }
                    }
                }
            
//            Toggle("", isOn: $isOn)
//                .toggleStyle(SwitchToggleStyle(tint: color))
//                .onChange(of: isOn) { _, newValue in
//                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
//                        cardOffset = 5
//                    }
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
//                            cardOffset = 0
//                        }
//                    }
//                }
            Button(action: {}) {
                Image(systemName: "gear")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .offset(x: cardOffset)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: cardOffset)
    }
}

#Preview {
    SmartHomeView()
        .modelContainer(for: [SmartDevice.self, SmartTV.self, ACSettings.self])
}
