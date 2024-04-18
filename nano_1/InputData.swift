//
//  InputData.swift
//  nano_1
//
//  Created by 김은정 on 4/15/24.
//


//https://velog.io/@maddie/iOSSwiftUI-SwiftData를-알아보아요


import Foundation
import SwiftData
import UIKit
import SwiftUI



struct todayInput{
    var today: String = ""
    var diary : String = ""
    var image = UIImage()
}


@Model
class DiaryInput {
//    @Attribute(.unique) var id: UUID = UUID()
    @Attribute(.unique) var time: String
    var content: String
    var selectEmoji: String
//    var image: UIImage = UIImage()

    init(time: String, content: String, selectEmoji: String) {
        self.time = time
        self.content = content
        self.selectEmoji = selectEmoji
    }
}


extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
//        print(cleanHexCode)
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}


func convertDateString(_ dateString: String) -> String {
    let year = dateString.prefix(4) // 처음 4자리 추출
    let monthStartIndex = dateString.index(dateString.startIndex, offsetBy: 4)
    let monthEndIndex = dateString.index(dateString.startIndex, offsetBy: 6)
    let month = dateString[monthStartIndex..<monthEndIndex] // 5번째부터 6번째 자리 추출
    let day = dateString.suffix(2) // 마지막 2자리 추출
    
    return "\(year)년 \(month)월 \(day)일"
}
//
//@Model
//struct diaryInput {
//    @Attribute (.unique) var today: Date
//    var diary : String
//    var image: UIImage = UIImage()
//
//    
//    init(today: Date, diary: String, image: UIImage) {
//        self.today = today
//        self.diary = diary
//        self.image = image
//    }
//}


