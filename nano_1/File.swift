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
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("당신은 동전을 던질것입니다\n앞면 과 뒷면 중에 하나를 선택해 주세요.")
                    .multilineTextAlignment(.center)
                
                
                NavigationLink(destination: ResultView(choice: "앞면")) {
                    Text("앞면을 선택하셨습니다.")
                }
                
                NavigationLink(destination: ResultView(choice: "뒷면")) {
                    Text("뒷면을 선택하셨습니다.")
                }
            }
//            .navigationBarTitle("Navigation")
        }
    }
}


#Preview {
    ContenView()
}

