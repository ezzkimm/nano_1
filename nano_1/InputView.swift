//
//  InputView.swift
//  nano_1
//
//  Created by 김은정 on 4/10/24.
//

import Foundation


import SwiftUI

struct InputView: View {
    @State private var diary : String = ""
    @State private var today: Date = Date()
    
    
    var body: some View {
        VStack {
            HStack{
                Text(monthTitle(from: today))
                    .font(.title2)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
//                Spacer()
//                Circle()
//                    .frame(width: 45, height: 45)

                
            }
            Text("")
                        TextField("오늘의 일기", text: $diary, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
            
            TextEditor(text: $diary)
                .border(.black)
                .frame(height: 300)
//                .textEditorStyle(z)
            
        }
        .padding(25)
        .frame(width: 393, height: 700, alignment: .top)


    }
}


private extension InputView {
    /// 월 표시
    func monthTitle(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 MMMM dd일"
        
        formatter.locale=Locale(identifier: "ko_KO")
        //dateFormatter.dateStyle = .long
        return formatter.string(from: date)
    }
    
    /// 요일 추출
    func day(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("E")
        return dateFormatter.string(from: date)
    }
}


#Preview {
    InputView()
}
