//
//  ContentView.swift
//  SSStoryStatusDemo
//
//  Created by Krunal Patel on 26/10/23.
//

import SwiftUI
import SSStoryStatus

struct ContentView: View {
    var body: some View {
        VStack {
            SSStoryStatus(users: SSStoryStatusDemo.mockData)
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
