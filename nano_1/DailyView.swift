//
//  DailyView.swift
//  nano_1
//
//  Created by 김은정 on 4/15/24.
//

import SwiftUI
import SwiftData

struct DailyView: View {
    @Binding var today: String
    @State var isPast: Bool = false
    
    var body: some View {
        VStack{
            ContentShowView(today: today, setIsPast: { value in
                self.isPast = value
            })
            if isPast{
                InputView(today: $today)
            }
        }
    }
}

struct ContentShowView: View {
    @State private var isTapped = false
    @Query var diaries: [DiaryInput]
    @Environment(\.dismiss) var dismiss
    var setIsPast: (Bool) -> Void
    var todaydate: String
    
    init(today: String, setIsPast: @escaping (Bool) -> Void) {
        self._diaries = Query(filter: #Predicate<DiaryInput> {
            $0.time == today
        })
        self.todaydate = today
        self.setIsPast = setIsPast
    }
    
    var body: some View {
        VStack {
            
            if diaries.isEmpty
            {
                VStack(spacing: 20){
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(isTapped ? .white : .black)
                        .font(isTapped ? .system(size: 1) : .system(.body))
                    
                    Text("밀린 일기 쓰러 가기")
                        .foregroundColor(isTapped ? .white : .black)
                        .font(isTapped ? .system(size: 1) : .system(.body))
                        .bold()
                    Image("cow")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                }
                .onTapGesture {
                    isTapped.toggle()
                    setIsPast(true)
                }
                
            }
            
            else{
                VStack(spacing: 30){
                    Text(convertDateString(todaydate))
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text(diaries[0].selectEmoji)
                        .font(.system(size: 80))
                    
                    ZStack{
                        Rectangle()
                            .cornerRadius(30)
                            .foregroundColor(Color(hex: "f2f2f2"))
                            .frame(height: 300)
                        VStack{
                            Text(diaries[0].content)
                                .padding(20)
                            //                        .background(Color.cyan)
                            Spacer()
                        }
                        .frame(height: 300)
                    }
                }
                .padding(30)
                
            }
        }
    }
}




#Preview {
    DailyView(today: .constant("20240415"))
        .modelContainer(for: DiaryInput.self, inMemory: true)
}
