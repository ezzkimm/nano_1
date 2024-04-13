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

struct InputView: View {
    @State private var diary : String = ""
    @State private var today: Date = Date()
    
    @State private var openPhoto = false
    @State private var image = UIImage()
    
    
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
            
            Button(action: {self.openPhoto = true})
            {Text("사진 추가")}
            
            Image(uiImage: self.image)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            
            
            TextField("오늘의 일기", text: $diary, axis: .vertical)
                .textFieldStyle(.roundedBorder)
            
            TextEditor(text: $diary)
                .border(.black)
                .frame(height: 300)
        }
        
        .padding(25)
        .frame(width: 393, height: 700, alignment: .top)
        .sheet(isPresented: $openPhoto) {
            ImagePicker(selectedImage: $image)
        }
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
