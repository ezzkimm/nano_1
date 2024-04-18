//
//  File.swift
//  nano_1
//
//  Created by 김은정 on 4/16/24.
//

import Foundation

import SwiftUI

struct ResultView: View {
    var choice: String
    
    var body: some View {
        Text("\(choice)을 선택하셨습니다. ")
    }
}

struct ContenView: View {
    
    
    var todaydate: String = "20240418"
    var content: String = "오늘은 리니니니닌ㄴㄴ와 카페에 와서 마지막 작업을 하는 중이다 집에 가고 싶다. 왜 위로 정렬이 안될까 개쓰레기 같은 스위프트"
    var selectEmoji: String = "💙"
    
    var body: some View {
        VStack(spacing: 30){
            
            Text(todaydate)
                .font(.title2)
                .fontWeight(.bold)
            
            
            Text(selectEmoji)
                .font(.system(size: 80))
            
            ZStack{
                Rectangle()
                    .cornerRadius(30)
                    .foregroundColor(Color(hex: "f2f2f2"))
                    .frame(height: 300)
                VStack{
                    Text(content)
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




#Preview {
    ContenView()
}

