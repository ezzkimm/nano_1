//
//  InputView.swift
//  nano_1
//
//  Created by 김은정 on 4/10/24.
//


//카메라
//https://minnit-develop.tistory.com/12

//PhotosPicker
//https://swiftsenpai.com/development/swiftui-photos-picker/


import Foundation
import SwiftUI
import SwiftData
import MCEmojiPicker


struct InputView: View {
    @Environment(\.modelContext) private var modelContext
    
    
    //    @Binding var tInput = todayInput()
    
    //    @State var todayInfo: todayInput = todayInput()
    
    //    @Binding var DairyDict: [String:todayInput]
    //    @Binding var todayInfoList: [todayInput]
    @Binding var today: String

    
    @State private var diary: String = ""
    @State private var openPhoto = false
    @State private var image = UIImage()
    
    @State var selectedEmoji: String = " "
    
    
    @State private var showAlert = false
    @State private var emojiPresented = false
    

    @Environment(\.dismiss) var dismiss
    
    
    
    
    var body: some View {
        
        VStack{
            HStack{
                //                Text(monthTitle(from:todayInfo.today))
                //                Text(monthTitle(from: today))
                //                    .font(.title2)
                //                    .foregroundColor(.black)
                //                    .fontWeight(.bold)
                //                Spacer()
                //                Circle()
                //                    .frame(width: 45, height: 45)
            }
            Text("\(today)")
                .font(.title2)
                .fontWeight(.bold)

            ScrollView{
                VStack(spacing: 20){
                    Text(selectedEmoji)
                        .font(.system(size: 80))
                    
                    Button(action: {self.emojiPresented = true})
                    {Text("이모지 선택")}
                        .emojiPicker(
                            isPresented: $emojiPresented,
                            selectedEmoji: $selectedEmoji
                        )
                    ZStack{
                        Rectangle()
                            .cornerRadius(30)
                            .foregroundColor(Color(hex: "f2f2f2"))
                            .frame(height: 300)
                        TextEditor(text: $diary)
                            .scrollContentBackground(.hidden)
                            .padding(20)
                    }
                    .padding(.bottom, 50)

                    
                    Text("저장")
                        .frame(width: 100, height: 35)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .fontWeight(.bold)
                        .onTapGesture {
                        if diary.isEmpty || selectedEmoji.isEmpty {
                            showAlert = true
                        }
                        else{
                            let newDiaryInput = DiaryInput(time: today, content: diary, selectEmoji: selectedEmoji)
                            modelContext.insert(newDiaryInput)
                            dismiss()
                        }
                    }

                }
            }
        }
        .padding(30)
        .frame(width: 393, height: 700, alignment: .top)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("알림"), message: Text("내용을 입력해주세요."), dismissButton: .default(Text("확인")))
        }
    }
}




private extension InputView {
    /// 날짜 표시 2024년 4월 18일
    func monthTitle(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 MMMM dd일"
        
        formatter.locale=Locale(identifier: "ko_KO")
        //dateFormatter.dateStyle = .long
        return formatter.string(from: date)
    }
    
    // 날짜 20240418
    func calendardayFormatter(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYYMMdd"
        
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
    InputView(today: .constant("20240418"))
}
