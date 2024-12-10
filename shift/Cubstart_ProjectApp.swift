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
<<<<<<<< HEAD:shift/iControllerApp.swift
                .modelContainer(for: [SmartDevice.self, SmartTV.self, ACSettings.self])
========
                .modelContainer(for: [SmartDevice.self])
>>>>>>>> 80c82af36f944af4226e6dad4ee65e966fea7a9b:shift/Cubstart_ProjectApp.swift
        }
    }
}
