//
//  ACView.swift
//  Cubstart_Project
//
//  Created by 郭城 on 2024/11/22.
//


//
//  ac view.swift
//  icontroller
//
//  Created by cyh on 11/22/24.
//
import SwiftUI
import SwiftData


struct ACView: View {
    // SwiftData query to fetch AC settings
    @Query private var acSettings: [ACSettings]
    
    // Environment variable to access the model context
    @Environment(\.modelContext) private var modelContext
    
    // State variables to manage view state and sync with persistent model
    @State private var temperature: Double
    @State private var isEcoModeOn: Bool
    @State private var isPowerOff: Bool
    @State private var temperatureScale: CGFloat = 1.0
    @State private var buttonScale: CGFloat = 1.0
    @State private var sliderOffset: CGFloat = 0
    
    // Initializer to set up state from persisted settings
    init() {
        // Create default values
        let defaultTemp = 23.0
        let defaultEcoMode = false
        let defaultPowerOff = false
        
        // Initialize state variables
        _temperature = State(initialValue: defaultTemp)
        _isEcoModeOn = State(initialValue: defaultEcoMode)
        _isPowerOff = State(initialValue: defaultPowerOff)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            // Temperature Control
            HStack(alignment: .center) {
                VStack {
                    Text("Hot")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.red)
                        .opacity(temperature > 25 ? 1.0 : 0.5)
                        .padding(.bottom, 5)
                    Spacer()
                    Slider(value: Binding(
                        get: { temperature },
                        set: { newValue in
                            temperature = newValue
                            updateACSettings { $0.temperature = newValue }
                        }
                    ), in: 16...30, step: 1)
                        .rotationEffect(.degrees(-90))
                        .frame(width: 380, height: 300)
                        .padding()
                        .offset(x: sliderOffset)
                        .onAppear {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.6).repeatCount(1)) {
                                sliderOffset = 5
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                                    sliderOffset = 0
                                }
                            }
                        }
                    Spacer()
                    Text("Cool")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.blue)
                        .opacity(temperature < 20 ? 1.0 : 0.5)
                        .padding(.top, 5)
                }
                .frame(width: 100)
                .padding()
                
                Text("\(Int(temperature))°C")
                    .font(.title)
                    .padding(.leading, 16)
                    .scaleEffect(temperatureScale)
                    .foregroundColor(
                        temperature > 25 ? .red :
                            temperature < 20 ? .blue : .primary
                    )
                    .onChange(of: temperature) { oldValue, newValue in
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                            temperatureScale = 1.2
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                                temperatureScale = 1.0
                            }
                        }
                    }
            }
            .padding()
            
            Spacer()
            
            // Eco-mode and Power-off buttons
            HStack {
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        isEcoModeOn.toggle()
                        updateACSettings { $0.isEcoModeOn = isEcoModeOn }
                    }
                }) {
                    VStack {
                        Image(systemName: "bolt")
                            .font(.largeTitle)
                            .foregroundColor(isEcoModeOn ? .green : .gray)
                            .rotationEffect(isEcoModeOn ? .degrees(360) : .degrees(0))
                            .animation(.spring(response: 0.4, dampingFraction: 0.6), value: isEcoModeOn)
                        Text("eco-mode")
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: isEcoModeOn ? 8 : 5)
                    .scaleEffect(isEcoModeOn ? 1.1 : 1.0)
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        isPowerOff.toggle()
                        updateACSettings { $0.isPowerOff = isPowerOff }
                    }
                }) {
                    VStack {
                        Image(systemName: "power")
                            .font(.largeTitle)
                            .foregroundColor(isPowerOff ? .red : .gray)
                            .rotationEffect(isPowerOff ? .degrees(180) : .degrees(0))
                            .animation(.spring(response: 0.4, dampingFraction: 0.6), value: isPowerOff)
                        Text("power-off")
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: isPowerOff ? 8 : 5)
                    .scaleEffect(isPowerOff ? 1.1 : 1.0)
                }
            }
            .padding()
            
            Text("Outside Temperature is 40°C")
                .padding(.leading)
                .foregroundColor(.red)
                .opacity(0.8)
            
            Spacer()
        }
        .navigationTitle("AC in Living Room")
        .navigationBarTitleDisplayMode(.inline)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: temperature)
        .onAppear {
            loadOrCreateACSettings()
        }
    }
    
    // Load existing settings or create new ones
    private func loadOrCreateACSettings() {
        // Try to fetch existing settings
        if let existingSetting = acSettings.first {
            // Update local state with persisted values
            temperature = existingSetting.temperature
            isEcoModeOn = existingSetting.isEcoModeOn
            isPowerOff = existingSetting.isPowerOff
        } else {
            // Create and save new settings if none exist
            let newSettings = ACSettings()
            modelContext.insert(newSettings)
            saveACSettings()
        }
    }
    
    // Update AC settings with a closure
    private func updateACSettings(_ update: (ACSettings) -> Void) {
        if let existingSetting = acSettings.first {
            update(existingSetting)
            saveACSettings()
        } else {
            let newSettings = ACSettings()
            update(newSettings)
            modelContext.insert(newSettings)
            saveACSettings()
        }
    }
    
    // Save AC settings to persistent storage
    private func saveACSettings() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save AC settings: \(error)")
        }
    }
}

#Preview {
    ACView()
        .modelContainer(for: ACSettings.self)
}
