//
//  EmojiDraw.swift
//  nano_1
//
//  Created by 김은정 on 4/18/24.
//

import SwiftUI
import SwiftData


    


struct EmojiDraw: View {
    @Query var diaries: [DiaryInput]

    init(today: String) {
        self._diaries = Query(filter: #Predicate<DiaryInput> {
            $0.time == today
        })
    }
    
    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        ForEach(diaries){ text in
            Text(text.selectEmoji)
                .font(.system(size: 80))
        }
    }
}


#Preview {
    EmojiDraw(today: "20240411")
        .modelContainer(for: DiaryInput.self, inMemory: true)

}
