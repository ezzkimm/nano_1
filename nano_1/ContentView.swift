//
//  ContentView.swift
//  nano_1
//
//  Created by 김은정 on 4/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var date = Date()

    var body: some View {
        Text("hello")
        DatePicker(
            "Start Date",
            selection: $date,
            displayedComponents: [.date]
        )
        .datePickerStyle(.graphical)
    }

}

#Preview {
    ContentView()
}



