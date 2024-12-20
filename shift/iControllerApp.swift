//
//  Cubstart_ProjectApp.swift
//  Cubstart_Project
//
//  Created by 郭城 on 2024/11/20.
//

import SwiftUI
import SwiftData

@main
struct Cubstart_ProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [SmartDevice.self, SmartTV.self, ACSettings.self])
        }
    }
}
