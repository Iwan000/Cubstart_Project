//
//  ContentView.swift
//  Cubstart_Project
//
//  Created by 郭城 on 2024/11/20.
//
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            SmartHomeView()
                .navigationTitle("Smart Home")
        }
    }
}


#Preview {
    ContentView()
}
