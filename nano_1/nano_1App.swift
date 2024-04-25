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
    
    var body: some Scene {
        WindowGroup {
            CalenderView()
        }
        .modelContainer(for: DiaryInput.self)
        //        .modelContainer(modelContainer)
    }
    init(){
        print(URL.applicationSupportDirectory.path(percentEncoded: false ))
        
    }
}

