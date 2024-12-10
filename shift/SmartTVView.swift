//
//  SmartTVView.swift
//  Cubstart_Project
//
//  Created by 郭城 on 2024/11/22.
//



//
//  SmartTVView.swift
//  Cubstart_Project
//
//  Created by Knox on 2024/11/22.
//
import SwiftUI
<<<<<<< HEAD:shift/SmartTVView.swift
import SwiftData

struct SmartTVView: View {
    @Query(sort: \SmartTV.name) private var tvs: [SmartTV]
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    // State for settings
    @State private var showingRemoveAlert = false
    @State private var iconScale: CGFloat = 1.0
    @State private var showSettingsMessage = false
    
    var body: some View {
        VStack {
            // Check if there are any TVs, if not, create a default one
            if tvs.isEmpty {
                Text("No TV found. Adding default TV...")
                    .onAppear(perform: addDefaultTV)
            } else {
                // Use the first TV (assuming single TV for now)
                let tv = tvs[0]
                VStack {
                    // Subheader
                    Text("for \(tv.location)")
                        .foregroundColor(.blue)
                        .padding(.bottom, 20)
                    
                    // Smart TV Icon with animation
                    Image(systemName: "tv")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .foregroundColor(.blue)
                        .scaleEffect(iconScale)
                        .padding()
                        .onAppear {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.5)
                                .repeatForever(autoreverses: true)) {
                                    iconScale = 1.1
                            }
                        }
                    
                    // HDR Mode Toggle with animation
                    HStack {
                        Text("HDR mode")
                            .bold()
                        Spacer()
                        Toggle("", isOn: Binding(
                            get: { tv.isHDRModeOn },
                            set: { newValue in
                                tv.isHDRModeOn = newValue
                                saveTV()
                                if newValue {
                                    showSettingsMessage = true
                                    // Hide the message after 2 seconds
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        withAnimation {
                                            showSettingsMessage = false
                                        }
                                    }
                                }
                            }
                        ))
                        .toggleStyle(SwitchToggleStyle(tint: .red))
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    
                    if showSettingsMessage {
                        Text("HDR Mode Activated!")
                            .foregroundColor(.green)
                            .transition(.move(edge: .top).combined(with: .opacity))
                            .animation(.easeInOut, value: showSettingsMessage)
                    }
                    
                    Text("Improves the quality of a picture by showing more detail in both the brightest and darkest areas.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    // Additional slide animation
                    VStack {
                        SettingToggleRow(
                            settingName: "High Resolution",
                            isOn: Binding(
                                get: { tv.isHighResolutionOn },
                                set: { newValue in
                                    tv.isHighResolutionOn = newValue
                                    saveTV()
                                }
                            )
                        )
                        .transition(.slide)
                        
                        SettingToggleRow(
                            settingName: "LED Ambient Lighting",
                            isOn: Binding(
                                get: { tv.isLEDLightingOn },
                                set: { newValue in
                                    tv.isLEDLightingOn = newValue
                                    saveTV()
                                }
                            )
                        )
                        .transition(.slide)
                        
                        SettingToggleRow(
                            settingName: "Auto-Play",
                            isOn: Binding(
                                get: { tv.isAutoPlayOn },
                                set: { newValue in
                                    tv.isAutoPlayOn = newValue
                                    saveTV()
                                }
                            )
                        )
                        .transition(.slide)
                    }
                    .padding()
                    
                    // Remove Device Button with alert
                    Button(action: {
                        showingRemoveAlert = true
                    }) {
                        Text("Remove Device")
                            .foregroundColor(.red)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                            .cornerRadius(10)
                    }
                    .padding()
                    .alert("Remove Device", isPresented: $showingRemoveAlert) {
                        Button("Cancel", role: .cancel) { }
                        Button("Remove", role: .destructive) {
                            removeTV(tv)
                        }
                    } message: {
                        Text("Are you sure you want to remove this Smart TV? This action cannot be undone.")
                    }
                }
            }
        }
        .navigationTitle("Smart TV")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: addDefaultTVIfNeeded)
    }
    
    private func addDefaultTVIfNeeded() {
        // Check if any TVs exist, if not, add a default TV
        if tvs.isEmpty {
            addDefaultTV()
        }
    }
    
    private func addDefaultTV() {
        let defaultTV = SmartTV.createDefaultTV()
        modelContext.insert(defaultTV)
        saveTV()
    }
    
    private func saveTV() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save TV: \(error)")
        }
    }
    
    private func removeTV(_ tv: SmartTV) {
        modelContext.delete(tv)
        saveTV()
        dismiss()
    }
}

struct SettingToggleRow: View {
    let settingName: String
    @Binding var isOn: Bool
    @State private var rowScale: CGFloat = 1.0
    
=======
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
>>>>>>> 80c82af36f944af4226e6dad4ee65e966fea7a9b:icontroller/icontroller/SmartTVView.swift
    var body: some View {
        HStack {
            Text(settingName)
            Spacer()
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: .green))
<<<<<<< HEAD:shift/SmartTVView.swift
                .onChange(of: isOn) { _, _ in
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        rowScale = 1.1
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation {
                                rowScale = 1.0
                            }
                        }
                    }
                }
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
        .scaleEffect(rowScale)
    }
}

#Preview {
    SmartTVView()
        .modelContainer(for: SmartTV.self)
}
=======
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}
>>>>>>> 80c82af36f944af4226e6dad4ee65e966fea7a9b:icontroller/icontroller/SmartTVView.swift
