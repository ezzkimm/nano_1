//
//  CellView.swift
//  nano_1
//
//  Created by 김은정 on 4/25/24.
//

import SwiftUI
import SwiftData

// MARK: - 일자 셀 뷰
struct CellView: View {
    @Query var diaries: [DiaryInput]
    
    private var dateString: String
    private var day: Int
    private var clicked: Bool
    private var isToday: Bool
    private var isCurrentMonthDay: Bool


    private var textColor: Color {
        if clicked {
            return Color.white
        } else if isCurrentMonthDay {
            return Color.black
        } else {
            return Color.gray
        }
    }
    private var backgroundColor: Color {
        if clicked {
            return Color.black
        } else if isToday {
            return Color.gray
        } else {
            return Color.white
        }
    }
    
    init(
        dateString: String,
        day: Int,
        clicked: Bool = false,
        isToday: Bool = false,
        isCurrentMonthDay: Bool = true
    ) {
        self.dateString = dateString
        self.day = day
        self.clicked = clicked
        self.isToday = isToday
        self.isCurrentMonthDay = isCurrentMonthDay
        self._diaries = Query(filter: #Predicate<DiaryInput> {
            $0.time == dateString
        })
    }
    
    private var backgroundColor2: Color {
        if isCurrentMonthDay {
            if diaries.isEmpty{
                return Color(hex: "C7E7FF")
            }
            else
            {
                return Color.blue
            }
        } else {
            return Color.white
        }
    }
    
    
    
    var body: some View {
        VStack {
            ZStack{
                Circle()
                    .fill(backgroundColor2)
                if diaries.isEmpty == false && isCurrentMonthDay{
                    Text(diaries[0].selectEmoji).font(.system(size: 30))
                }}
            .frame(width: 45, height: 45)
            .padding(.bottom, -5)
            
            
            Circle()
                .fill(backgroundColor)
                .overlay(Text(String(day)))
                .foregroundColor(textColor)
                .frame(width: 30, height: 30)
                .padding(.bottom, -5)
            
            if clicked {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.red)
                    .frame(width: 10, height: 10)
                
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .frame(width: 10, height: 10)
            }
            Spacer()
        }
        .frame(height: 90)
    }
}
