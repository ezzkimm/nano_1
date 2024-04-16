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

struct todayInput{
    var today: Date = Date()
    var diary : String = ""
    var image = UIImage()

}



@Model
class diaryInput {
    @Attribute (.unique) var today: Date
    var diary : String
    
    init(today: Date, diary: String) {
        self.today = today
        self.diary = diary
    }
//    var image: UIImage()

}
