//
//  PickerLibrary2App.swift
//  PickerLibrary2
//
//  Created by Yunus Can on 06/01/2024.
//
import SwiftData
import SwiftUI

@main
struct PickerLibrary2App: App {
    var body: some Scene {
        WindowGroup {
            Login()
        }
        .modelContainer(for: [Person.self, Post.self])
    }
}
