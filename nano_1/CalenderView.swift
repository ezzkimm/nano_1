//
//  CalendarView.swift
//  nano_1
//
//  Created by 김은정 on 4/10/24.
//

import SwiftUI
import SwiftData
import UIKit


struct CalenderView: View {
    @State var month: Date = Date()
    @State var clickedCurrentMonthDates: Date?
    
    
    @State var showingSheet = false
    
    init(
        month: Date = Date(),
        clickedCurrentMonthDates: Date? = nil
    ) {
        _month = State(initialValue: month)
        _clickedCurrentMonthDates = State(initialValue: clickedCurrentMonthDates)
    }
    
    
    var body: some View {
        //        @State var todayString: String = calendardayString(in: month)
        
        
        //        NavigationStack{
        VStack {
            headerView
                .frame(alignment: .top)
            calendarGridView
        }
        .padding(15)
        .frame(width: 393, height: 700, alignment: .top)
        .sheet(isPresented: $showingSheet) {
            // Sheet 내용
            var DateString: String {
                CalenderView.calendardayFormatter.string(from: clickedCurrentMonthDates ?? Date())
            }
            DailyView(today: .constant(DateString))
        }
        
        
        //            NavigationLink(destination: InputView(today: $todayString)
        //            ) {
        Text("오늘쓰기")
            .frame(width: 100, height: 35)
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(30)
            .fontWeight(.bold)
        
        
        //            }
        
        //        } /*NavigationStack*/
    } /*body*/
    
    
    // MARK: - 헤더 뷰
    private var headerView: some View {
        VStack {
            HStack {
                yearMonthView
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 30)
            
            HStack {
                ForEach(Self.weekdaySymbols.indices, id: \.self) { symbol in
                    Text(Self.weekdaySymbols[symbol].uppercased())
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, 20)
        }
    }
    
    // MARK: - 연월 표시
    private var yearMonthView: some View {
        HStack(alignment: .center, spacing: 20) {
            Text(month, formatter: Self.calendarHeaderDateFormatter)
                .font(.title.bold())
            Spacer()
            
            HStack{
                Button(
                    action: {
                        changeMonth(by: -1)
                    },
                    label: {
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                )
                //            Image(systemName: "chevron.left")
                
                Text("오늘")
                    .frame(width: 50, height: 35)
                    .foregroundColor(.gray)
                    .fontWeight(.bold)
                    .background(Color(hex: "f2f2f2"))
                
                    .cornerRadius(10)
                    .onTapGesture {
                        month = Date() // 여기서 'month' 변수를 업데이트합니다. 실제 사용에 맞게 조정하세요.
                    }
                
                
                
                Button(
                    action: {
                        changeMonth(by: 1)
                    },
                    label: {
                        Image(systemName: "chevron.right")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                )
            }
        }
    }
    
    
    // MARK: - 날짜 그리드 뷰
    private var calendarGridView: some View {
        let daysInMonth: Int = numberOfDays(in: month)
        let firstWeekday: Int = firstWeekdayOfMonth(in: month) - 1
        let lastDayOfMonthBefore = numberOfDays(in: previousMonth())
        let numberOfRows = Int(ceil(Double(daysInMonth + firstWeekday) / 7.0))
        let visibleDaysOfNextMonth = numberOfRows * 7 - (daysInMonth + firstWeekday)
        //        let full: String = today.formattedCalendarDayDate
        //        let full: String = today.formattedCalendarDayDate
        
        
        return LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
            ForEach(-firstWeekday ..< daysInMonth + visibleDaysOfNextMonth, id: \.self) { index in
                Group {
                    if index > -1 && index < daysInMonth {
                        let date = getDate(for: index)
                        let day = Calendar.current.component(.day, from: date)
                        let clicked = clickedCurrentMonthDates == date
                        let isToday = date.formattedCalendarDayDate == today.formattedCalendarDayDate
                        
                        CellView(date: date, day: day, clicked: clicked, isToday: isToday, isCurrentMonthDay: true)
                        //                            .onAppear{print(date)}
                        
                    } else if let prevMonthDate = Calendar.current.date(
                        byAdding: .day,
                        value: index + lastDayOfMonthBefore,
                        to: previousMonth()
                    ) {
                        let day = Calendar.current.component(.day, from: prevMonthDate)
                        
                        //                        Text(month)
                        CellView(date: prevMonthDate, day: day, isCurrentMonthDay: false)
                        
                    }
                }
                .onTapGesture {
                    if 0 <= index && index < daysInMonth {
                        let date = getDate(for: index)
                        let currentMonth = Calendar.current.component(.month, from: month)
                        let selectedMonth = Calendar.current.component(.month, from: date)
                        
                        if currentMonth == selectedMonth {
                            clickedCurrentMonthDates = date
                            // 2024-04-18 00:00:00 +0000
                        }
                    }
                    if let clickedDate = clickedCurrentMonthDates {
                        let comparisonResult = Calendar.current.compare(clickedDate, to: Date(), toGranularity: .day)
                        if comparisonResult == .orderedAscending || comparisonResult == .orderedSame {
                            // 선택된 날짜가 이번 달에 속하며, 오늘과 같거나 이전이면 Sheet 표시
                            showingSheet = true
                        }
                    }
                }
            }
        }
    }
}
// MARK: - 일자 셀 뷰
private struct CellView: View {
    @Query var diaries: [DiaryInput]
    
    
    private var day: Int
    private var date: Date
    private var clicked: Bool
    private var isToday: Bool
    private var isCurrentMonthDay: Bool
    
    private var DateString: String {
        CalenderView.calendardayFormatter.string(from: date)
    }
    
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
    
    
    fileprivate init(
        date: Date,
        day: Int,
        clicked: Bool = false,
        isToday: Bool = false,
        isCurrentMonthDay: Bool = true
    ) {
        self.date = date
        self.day = day
        self.clicked = clicked
        self.isToday = isToday
        self.isCurrentMonthDay = isCurrentMonthDay
        self._diaries = Query(filter: #Predicate<DiaryInput> {
            $0.time == DateString
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

// MARK: - CalendarView Static 프로퍼티
private extension CalenderView {
    var today: Date {
        let now = Date()
        let components = Calendar.current.dateComponents([.year, .month, .day], from: now)
        return Calendar.current.date(from: components)!
    }
    
    static let calendarHeaderDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY.MM"
        return formatter
    }()
    
    static let calendardayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYYMMdd"
        return formatter
    }()
    
    static let weekdaySymbols: [String] = Calendar.current.shortWeekdaySymbols
}

// MARK: - 내부 로직 메서드
private extension CalenderView {
    func calendardayString(in today: Date?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYYMMdd"
        return formatter.string(from: today ?? Date())
    }
    
    
    /// 특정 해당 날짜
    func getDate(for index: Int) -> Date {
        let calendar = Calendar.current
        guard let firstDayOfMonth = calendar.date(
            from: DateComponents(
                year: calendar.component(.year, from: month),
                month: calendar.component(.month, from: month),
                day: 1
            )
        ) else {
            return Date()
        }
        
        var dateComponents = DateComponents()
        dateComponents.day = index
        
        let timeZone = TimeZone.current
        let offset = Double(timeZone.secondsFromGMT(for: firstDayOfMonth))
        dateComponents.second = Int(offset)
        
        let date = calendar.date(byAdding: dateComponents, to: firstDayOfMonth) ?? Date()
        return date
    }
    
    /// 해당 월에 존재하는 일자 수
    func numberOfDays(in date: Date) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    /// 해당 월의 첫 날짜가 갖는 해당 주의 몇번째 요일
    func firstWeekdayOfMonth(in date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        
        return Calendar.current.component(.weekday, from: firstDayOfMonth)
    }
    
    /// 이전 월 마지막 일자
    func previousMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: month)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: firstDayOfMonth)!
        
        return previousMonth
    }
    
    /// 월 변경
    func changeMonth(by value: Int) {
        self.month = adjustedMonth(by: value)
    }
    
    
    //    /// 이전 월로 이동 가능한지 확인
    //    func canMoveToPreviousMonth() -> Bool {
    //        let currentDate = Date()
    //        let calendar = Calendar.current
    //        let targetDate = calendar.date(byAdding: .month, value: -3, to: currentDate) ?? currentDate
    //
    //        if adjustedMonth(by: -1) < targetDate {
    //            return false
    //        }
    //        return true
    //    }
    //
    //    /// 다음 월로 이동 가능한지 확인
    //    func canMoveToNextMonth() -> Bool {
    //        let currentDate = Date()
    //        let calendar = Calendar.current
    //        let targetDate = calendar.date(byAdding: .month, value: 3, to: currentDate) ?? currentDate
    //
    //        if adjustedMonth(by: 1) > targetDate {
    //            return false
    //        }
    //        return true
    //    }
    
    /// 변경하려는 월 반환
    func adjustedMonth(by value: Int) -> Date {
        if let newMonth = Calendar.current.date(byAdding: .month, value: value, to: month) {
            return newMonth
        }
        return month
    }
    
}

// MARK: - Date 익스텐션
extension Date {
    static let calendarDayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy dd"
        return formatter
    }()
    
    var formattedCalendarDayDate: String {
        return Date.calendarDayDateFormatter.string(from: self)
    }
}



#Preview {
    CalenderView()
        .modelContainer(for: DiaryInput.self, inMemory: true)
    
}
