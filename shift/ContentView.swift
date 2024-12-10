//
//  ContentView.swift
//  Cubstart_Project
//
//  Created by 郭城 on 2024/11/20.
//
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        NavigationView {
            SmartHomeView()
                .navigationTitle("Smart Home")
                .modelContainer(for: [SmartDevice.self, SmartTV.self, ACSettings.self])
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: [SmartDevice.self, SmartTV.self, ACSettings.self])
}
