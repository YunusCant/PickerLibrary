//
//  ContentView.swift
//  PickerLibrary2
//
//  Created by Yunus Can on 06/01/2024.
//

import SwiftUI

struct ContentView: View {
    var name = ""
    var body: some View {
        TabView{
            MainView()
                .tabItem {
                    Text("Photo Library")
                    Image(systemName: "photo.on.rectangle.angled")
                }
            AddPicker()
                .tabItem {
                    Text("Add The Photo")
                    Image(systemName: "photo.badge.plus")
                }
            AccountView()
                .tabItem {
                    Text("Account")
                    Image(systemName: "person.crop.circle")
                }
        }
    }
}

#Preview {
    ContentView()
}
