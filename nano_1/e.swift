////
////  e.swift
////  nano_1
////
////  Created by 김은정 on 4/19/24.
////
//
//import SwiftUI
//
//
//if let clickedDate = clickedCurrentMonthDates {
//    let comparisonResult = Calendar.current.compare(clickedDate, to: Date(), toGranularity: .day)
//    if comparisonResult == .orderedAscending || comparisonResult == .orderedSame {
//        // 선택된 날짜가 오늘과 같거나 이전이면 Sheet 표시
//        showingSheet = true
//    }
//}
//
//
//
//struct CalenderView: View {
//@State var month: Date = Date()
//@State var clickedCurrentMonthDates: Date?
//
//
//@State var showingSheet = false
//
//init(
//month: Date = Date(),
//clickedCurrentMonthDates: Date? = nil
//) {
//_month = State(initialValue: month)
//_clickedCurrentMonthDates = State(initialValue: clickedCurrentMonthDates)
//}
//
//var body: some View {
//
////        NavigationStack{
//VStack {
//Text("\(month)")
//
//headerView
//.frame(alignment: .top)
//calendarGridView
//}
//
//.padding(15)
//.frame(width: 393, height: 700, alignment: .top)
//.sheet(isPresented: $showingSheet) {
//// Sheet 내용
//var DateString: String {
//CalenderView.calendardayFormatter.string(from: clickedCurrentMonthDates ?? Date())
//}
//DailyView(today: .constant(DateString))
//}
//
////            NavigationLink(destination: InputView(today: $todayString)
////            ) {
//Text("오늘쓰기")
//.frame(width: 100, height: 35)
//.foregroundColor(.white)
//.background(Color.blue)
//.cornerRadius(30)
//.fontWeight(.bold)
//
//
////            }
//
////        } /*NavigationStack*/
//} /*body*/
