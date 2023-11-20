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
            Text(SSStoryStatus().text)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
