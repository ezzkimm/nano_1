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
    @Binding var today: String

    
    @State private var diary: String = ""
    @State private var openPhoto = false
    @State private var image = UIImage()
    
    @State var selectedEmoji: String = ""
    
    @State private var showAlert = false
    @State private var emojiPresented = false
    

    @Environment(\.dismiss) var dismiss
    
    
    
    
    var body: some View {
        
        VStack{
            Text(convertDateString(today))
                .font(.title2)
                .fontWeight(.bold)

            ScrollView{
                VStack(spacing: 20){
                    Text(selectedEmoji)
                        .font(.system(size: 80))
                        .frame(height: 100)
//                        .background(Color.gray)
                    
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


//private extension InputView {
//    func convertDateString(_ dateString: String) -> String {
//        let year = dateString.prefix(4) // 처음 4자리 추출
//        let monthStartIndex = dateString.index(dateString.startIndex, offsetBy: 4)
//        let monthEndIndex = dateString.index(dateString.startIndex, offsetBy: 6)
//        let month = dateString[monthStartIndex..<monthEndIndex] // 5번째부터 6번째 자리 추출
//        let day = dateString.suffix(2) // 마지막 2자리 추출
//        
//        return "\(year)년 \(month)월 \(day)일"
//    }
//}




#Preview {
    InputView(today: .constant("20240418"))
}
