//
//  nano_1App.swift
//  nano_1
//
//  Created by 김은정 on 4/10/24.
//

import SwiftUI
import SwiftData




@main
struct nano_1App: App {
    @State var tInput = todayInput()
    
    var body: some Scene {
        WindowGroup {
//            InputView()
            CalenderView()
        }
//        .modelContainer(ModelContainer)
    }
}
