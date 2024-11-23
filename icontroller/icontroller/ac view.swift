//
//  ac view.swift
//  icontroller
//
//  Created by cyh on 11/22/24.
//

import SwiftUI

struct ACView: View {
    @State private var temperature: Double = 23
    @State private var isEcoModeOn = false
    @State private var isPowerOff = false

    var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        // Back action
                    }) {
                        Image(systemName: "chevron.left")
                    }
                    
                }
                .padding()

                Text("AC model1")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.leading)

                // Temperature Control
                HStack(alignment: .center) {
                    VStack {
                        Text("Hot")
                            .font(.headline)
                        Spacer()
                        Slider(value: $temperature, in: 16...30, step: 1)
                            .rotationEffect(.degrees(-90))
                            .frame(width:230,height: 300)
                            .padding()
                        Spacer()
                        Text("Cool")
                            .font(.headline)
                    }
                    .frame(width: 100)
                    .padding()

                    Text("\(Int(temperature))°C")
                        .font(.title)
                        .padding(.leading, 16)
                }
                .padding()

                Spacer()

                // Eco-mode and Power-off buttons
                HStack {
                    Button(action: {
                        isEcoModeOn.toggle()
                    }) {
                        VStack {
                            Image(systemName: "bolt")
                                .font(.largeTitle)
                                .foregroundColor(isEcoModeOn ? .green : .gray)
                            Text("eco-mode")
                                .font(.subheadline)
                                .foregroundColor(.black)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                    Spacer()
                    Button(action: {
                        isPowerOff.toggle()
                    }) {
                        VStack {
                            Image(systemName: "power")
                                .font(.largeTitle)
                                .foregroundColor(isPowerOff ? .red : .gray)
                            Text("power-off")
                                .font(.subheadline)
                                .foregroundColor(.black)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                }
                .padding()

                Text("Outside Temperature is 40°C")
                    .padding(.leading)

                Spacer()
            }
            .navigationTitle("AC in Living Room")
        }
    }

    #Preview {
        ACView()
    }
