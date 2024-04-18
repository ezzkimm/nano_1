//
//  nano_1App.swift
//  nano_1
//
//  Created by 김은정 on 4/10/24.
//

import SwiftUI
import SwiftData

//
//@Model
//class DiaryInput {
//    @Attribute (.unique) var id: UUID = UUID()
//
//    var time: String
//
//    var content: String
//
//    init(time: String, content: String) {
//        self.time = time
//        self.content = content
//    }
//}



@main
struct nano_1App: App {
    
    //    @State var tInput = todayInput()
    
    //    var modelContainer: ModelContainer = {
    //        let schema = Schema([DiaryInput.self])
    //        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    //
    //        do {
    //            return try ModelContainer(for: schema, configurations: [modelConfiguration])
    //        } catch {
    //            fatalError("Could not create ModelContainer: \(error)")
    //        }
    //    }()
    
    
    
    var body: some Scene {
        WindowGroup {
            //            InputView()
            CalenderView()
            //            EmojiDraw(today: "20240411")
            //            DailyView(today: .constant("20240418"))
            
        }
        .modelContainer(for: DiaryInput.self)
        ////        .modelContainer(modelContainer)
    }
    init(){
        print(URL.applicationSupportDirectory.path(percentEncoded: false ))
        
    }
}

