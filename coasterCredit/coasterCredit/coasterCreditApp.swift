//
//  coasterCreditApp.swift
//  coasterCredit
//
//  Created by Noah Lloyd on 4/28/26.
//

import SwiftUI
import SwiftData

@main
struct coasterCreditApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Coaster.self)
    }
}
