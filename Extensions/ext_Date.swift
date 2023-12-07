/*--------------------------------------------------------------------------------------------------------------------------
    File: extDate.swift
  Author: Kevin Messina
 Created: Jan 5, 2020
Modified:
 
©2020-2023 Creative App Solutions, LLC. - All Rights Reserved.
----------------------------------------------------------------------------------------------------------------------------
NOTES:
--------------------------------------------------------------------------------------------------------------------------*/

import Foundation
import Swift
import SwiftUI

// MARK: - *** DATE DEFINITIONS ***
extension Date {
    static let secondsInterval:TimeInterval = 60
    static let minutesInterval:TimeInterval = 60
    static let hoursInDayInterval:TimeInterval = 24
    static let dayInterval:TimeInterval = (secondsInterval * minutesInterval * hoursInDayInterval)

    enum monthNum:Int { case Jan=1,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec }
    static let monthNames = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    static let monthAbbr = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
    static let dayNames = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    static let dayAbbr = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]

    func monthName(for monthNum: Int) -> String { return Date.monthNames[monthNum] }
    func monthAbbrev(for monthNum: Int) -> String { return Date.monthNames[monthNum] }
    func dayName(for dayNum: Int) -> String { return Date.monthNames[dayNum] }
    func dayAbbrev(for dayNum: Int) -> String { return Date.monthNames[dayNum] }

    // MARK: - *** DATE VARIABLES ***
    var day: Int { Calendar.current.dateComponents([.day], from: self).day ?? 0 }
    var dayName: String { days.arrWeek[ Calendar.current.dateComponents([.day], from: self).weekday ?? 0].name }
    var daysSinceNow: DateComponents { Calendar.current.dateComponents([.day], from: self, to: Date()) }
    var isToday: Bool { Calendar.current.isDateInToday(self) }
    var isTomorrow: Bool { Calendar.current.isDateInTomorrow(self) }
    var isWeekend: Bool { Calendar.current.isDateInWeekend(self) }
    var isyesterday: Bool { Calendar.current.isDateInYesterday(self) }
    var month: Int { Calendar.current.dateComponents([.month], from: self).month ?? 0 }
    var monthName: String { Date.months.arr[ Calendar.current.dateComponents([.month], from: self).month ?? 0].name }
    var monthNameAbbrev: String { Date.monthAbbr[(Calendar.current.dateComponents([.month], from: self).month)! - 1]} //0 based array
    var year: Int { Calendar.current.dateComponents([.year], from: self).year ?? 0 }
    var year2: Int { (Calendar.current.dateComponents([.year], from: self).year ?? 0) - 2000 }
    var components: DateComponents { Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,.timeZone], from: self) }
    
// MARK: - *** DATE FUNCTIONS ***
    var startOfWeek: Date? {
        let calendar = Calendar.current
        guard let sunday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return calendar.date(byAdding: .day, value: 1, to: sunday)
    }
    
    var endOfWeek: Date? {
        let calendar = Calendar.current
        guard let sunday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return calendar.date(byAdding: .day, value: 7, to: sunday)
    }

    func getWeekNumber() -> Int {
        let calendar = Calendar.current
        let currentDate = Date()
        return calendar.component(.weekOfYear, from: currentDate)
    }
    
    func getLast6Month() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -6, to: self)
    }
    
    func getLast3Month() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -3, to: self)
    }
    
    func getYesterday() -> Date? {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)
    }
    
    func getLast7Day() -> Date? {
        return Calendar.current.date(byAdding: .day, value: -7, to: self)
    }
    
    func getLast30Day() -> Date? {
        return Calendar.current.date(byAdding: .day, value: -30, to: self)
    }
    
    func getPreviousMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)
    }
    
    // This Month Start
    func getThisMonthStart() -> Date? {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: components)!
    }
    
    func getThisMonthEnd() -> Date? {
        let components:NSDateComponents = Calendar.current.dateComponents([.year, .month], from: self) as NSDateComponents
        components.month += 1
        components.day = 1
        components.day -= 1
        return Calendar.current.date(from: components as DateComponents)!
    }
    
    //Last Month Start
    func getLastMonthStart() -> Date? {
        let components:NSDateComponents = Calendar.current.dateComponents([.year, .month], from: self) as NSDateComponents
        components.month -= 1
        return Calendar.current.date(from: components as DateComponents)!
    }
    
    //Last Month End
    func getLastMonthEnd() -> Date? {
        let components:NSDateComponents = Calendar.current.dateComponents([.year, .month], from: self) as NSDateComponents
        components.day = 1
        components.day -= 1
        return Calendar.current.date(from: components as DateComponents)!
    }
    
    func initDays(inMonth:Int, inYear: Int) -> [String] {
        var days:[String] = []
        
        let maxDays = Date.months.arr[month].days
        for day in 1...maxDays {
            days.append(String(day))
        }
        
        if inMonth == 2 { // Handle Feb Leap Years
            if Date().isLeapYearDate(inYear) {
                days.append(String(29))
            }
        }
        
        return days
    }

    func addDays(_ numDays:TimeInterval) -> Date { return Date().addingTimeInterval(Date.dayInterval * numDays) }
    func addYears(_ numYears:TimeInterval) -> Date { return Date().addDays(numYears * 365) }
    func duration(fromDate:Date) -> (formattedText:String,yearText:String,monthText:String,dayText:String,years:Int,months:Int,days:Int) {
        let dateDiff = self.monthsDaysSince(fromDate)
        let durationYears = dateDiff.year ?? 0
        let durationMonths = dateDiff.month ?? 0
        let durationDays = dateDiff.day ?? 0
        let yearTitle = (durationYears > 1) ?"years" :"year"
        let monthTitle = (durationMonths > 1) ?"months" :"month"
        let dayTitle = (durationDays > 1) ?"days" :"day"
        let yearText = (durationYears > 0) ?"\( durationYears ) \( yearTitle ), " :""
        let monthText = (durationMonths > 0) ?"\( durationMonths ) \( monthTitle ), " :""
        let dayText = (durationDays > 0) ?"\( durationDays ) \( dayTitle )" :""
        let fullText = "\( yearText )\( monthText )\( dayText )"
        
        return (fullText,yearText,monthText,dayText,durationYears,durationMonths,durationDays)
    }
    /// Date FormattedAs
    /// - Parameter dateFormat: Date.formats.xxxxx
    /// - example: todayDate.formattedAs(Date.formats.ddMMyy)
    /// - Returns: A formatted String in the date format specicified
    func formattedAs(_ dateFormat:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "\( dateFormat )"

        return formatter.string(from: self as Date)
    }
    
    func isIn(date:Date,equalToDate:Date,within:Calendar.Component) -> Bool { return Calendar.current.isDate(date, equalTo: equalToDate, toGranularity: within) }
    func isLeapYearDate(_ year: Int) -> Bool { ((year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0)) }
    func isLeapYear(_ date: Date = Date()) -> Bool { return isLeapYearDate(Calendar.current.dateComponents([.year], from: date).year!) }
    func monthsDaysSince(_ sinceDate:Date) -> DateComponents { return Calendar.current.dateComponents([.day,.month,.year], from: sinceDate, to: self) }
    func isSameDay(date1:Date,date2:Date) -> Bool { return Calendar.current.isDate(date1, equalTo: date2, toGranularity: .day) }
    func isSameMonth(date1:Date,date2:Date) -> Bool { return Calendar.current.isDate(date1, equalTo: date2, toGranularity: .month) }
    func isSameYear(date1:Date,date2:Date) -> Bool { return Calendar.current.isDate(date1, equalTo: date2, toGranularity: .year) }
    func isBefore(_ date:Date) -> Bool { return Calendar.current.compare(self, to: date, toGranularity: .day) == .orderedAscending }
    func isAfter(_ date:Date) -> Bool { return Calendar.current.compare(self, to: date, toGranularity: .day) == .orderedDescending }
    func isSameAs(_ date:Date) -> Bool { return Calendar.current.compare(self, to: date, toGranularity: .day) == .orderedSame }

// MARK: - *** DATE STRUCTS ***
    struct dayStruct {
      var name:String
      var abbrev:String
      var short:String
      var num:Int
    }

    struct days {
      static let Unkown = dayStruct(name: "??", abbrev: "???", short: "??", num: 0)
      static let Mon = dayStruct(name: "Monday", abbrev: "Mon", short: "Mo", num: 1)
      static let Tue = dayStruct(name: "Tuesday", abbrev: "Tue", short: "Tu", num: 2)
      static let Wed = dayStruct(name: "Wedfsday", abbrev: "Wed", short: "We", num: 3)
      static let Thu = dayStruct(name: "Thursday", abbrev: "Thu", short: "Th", num: 4)
      static let Fri = dayStruct(name: "Friday", abbrev: "Fri", short: "Fr", num: 5)
      static let Sat = dayStruct(name: "Saturday", abbrev: "Sat", short: "Sa", num: 6)
      static let Sun = dayStruct(name: "Sunday", abbrev: "Sun", short: "Su", num: 7)

      static let arrWeek:[dayStruct] = [Unkown,Mon,Tue,Wed,Thu,Fri,Sat,Sun]
      static let arrWeekEnd:[dayStruct] = [Sat,Sun]
      static let arrWeekDays:[dayStruct] = [Mon,Tue,Wed,Thu,Fri]
    }

    struct monthStruct {
      var name:String
      var abbrev:String
      var num:Int
      var days:Int
    }

    struct months {
      static let Unknown = monthStruct(name: "???", abbrev: "???", num: 1, days:31)
      static let Jan = monthStruct(name: "January", abbrev: "Jan", num: 1, days:31)
      static let Feb = monthStruct(name: "February", abbrev: "Feb", num: 2, days:28)
      static let Mar = monthStruct(name: "March", abbrev: "Mar", num: 3, days:31)
      static let Apr = monthStruct(name: "April", abbrev: "Apr", num: 4, days:30)
      static let May = monthStruct(name: "May", abbrev: "May", num: 5, days:31)
      static let Jun = monthStruct(name: "June", abbrev: "Jun", num: 6, days:30)
      static let Jul = monthStruct(name: "July", abbrev: "Jul", num: 7, days:31)
      static let Aug = monthStruct(name: "August", abbrev: "Aug", num: 8, days:31)
      static let Sep = monthStruct(name: "September", abbrev: "Sep", num: 9, days:30)
      static let Oct = monthStruct(name: "October", abbrev: "Oct", num: 10, days:31)
      static let Nov = monthStruct(name: "November", abbrev: "Nov", num: 11, days:30)
      static let Dec = monthStruct(name: "December", abbrev: "Dec", num: 12, days:31)

      static let arr:[monthStruct] = [Unknown,Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec]
    }

    
// MARK: - *** DATE FORMATTING ***
    struct formats {
        enum types { case unix,system,HTML_HDR_RESPONSE }

        struct DateFormats {
            let year2:String = "yy"
            let year4:String = "yyyy"
            let month:String = "M"
            let months:String = "MM"
            let monthAbbrev:String = "MMM"
            let monthName:String = "MMMM"
            let day:String = "d"
            let days:String = "dd"
            let dayAbbrev:String = "EEE"
            let dayName:String = "EEEE"
        }

        struct TimeFormats {
            let hour:String = "h"
            let hours:String = "h"
            let hour24:String = "H"
            let hours24:String = "HH"
            let minute:String = "m"
            let minutes:String = "mm"
            let second:String = "s"
            let seconds:String = "ss"
            let ampm:String = "a"

            struct ZoneFormats {
                let abbrev:String = "zzz"
                let name:String = "zzzz"
                let RFC_GMT:String = "Z"
                let ISO:String = "ZZZZZ"
                let GMT:String = "VV"
            }
        }
        
        // SYSTEMS
        static let unix:String = "\(DateFormats().year4)-\(months())-\(DateFormats().days) \(TimeFormats().hours):\(TimeFormats().minutes):\(TimeFormats().seconds) \(TimeFormats.ZoneFormats().GMT)"
        static let system:String = "\(DateFormats().year4)-\(DateFormats().months)-\(DateFormats().days) \(TimeFormats().hours):\(TimeFormats().minutes):\(TimeFormats().seconds) \(TimeFormats.ZoneFormats().RFC_GMT)"
        static let HTML_HDR_RESPONSE:String = "\(DateFormats().dayAbbrev), \(DateFormats().day) \(DateFormats().monthName) \(DateFormats().year4) \(TimeFormats.ZoneFormats().RFC_GMT)"

        // DAYS
        static let ddMMyy:String                        = "\(DateFormats().days)/\(DateFormats().months)/\(DateFormats().year2)"
        static let ddMMyyyy:String                      = "\(DateFormats().days)/\(DateFormats().months)/\(DateFormats().year4)"
        static let d_MMM_yyyy:String                    = "\(DateFormats().day) \(DateFormats().monthAbbrev) \(DateFormats().year4)"
        static let d_MMM_yyyy_EEE:String                = "\(d_MMM_yyyy) (\(DateFormats().dayAbbrev))"
        static let d_MMM_yyyy_EEE_at_hmm_a:String       = "\(d_MMM_yyyy_EEE) @ \(h_mm_a)"
        static let d_MMM_yyyy_EEE_hmm_a:String          = "\(d_MMM_yyyy) \(DateFormats().dayAbbrev) @ \(h_mm_a)"
        static let d_MMM_yyyy_EEEE:String               = "\(d_MMM_yyyy) (\(DateFormats().dayName))"
        static let d_MMM_yyyy_EEEE_at_hmm_a:String      = "\(d_MMM_yyyy_EEEE) @ \(h_mm_a)"
        static let d_MMM_yyyy_EEEE_hmm_a:String         = "\(d_MMM_yyyy_EEEE) \(h_mm_a)"
        static let dd_MMM_YY:String                     = "\(DateFormats().days) \(DateFormats().monthAbbrev) \(DateFormats().year2)"
        static let dd_MMM_YYYY:String                   = "\(DateFormats().days) \(DateFormats().monthAbbrev) \(DateFormats().year4)"
        static let d_MMMM_yyyy:String                    = "\(DateFormats().day) \(DateFormats().monthName) \(DateFormats().year4)"
        static let d_MMMM_yyyy_EEE:String                = "\(d_MMMM_yyyy) (\(DateFormats().dayAbbrev))"
        static let d_MMMM_yyyy_EEE_at_hmm_a:String       = "\(d_MMMM_yyyy_EEE) @ \(h_mm_a)"
        static let d_MMMM_yyyy_EEE_hmm_a:String          = "\(d_MMMM_yyyy) \(DateFormats().dayAbbrev) @ \(h_mm_a)"
        static let d_MMMM_yyyy_EEEE:String               = "\(d_MMMM_yyyy) (\(DateFormats().dayName))"
        static let d_MMMM_yyyy_EEEE_at_hmm_a:String      = "\(d_MMMM_yyyy_EEEE) @ \(h_mm_a)"
        static let d_MMMM_yyyy_EEEE_hmm_a:String         = "\(d_MMMM_yyyy_EEEE) \(h_mm_a)"
        static let dd_MMMM_YY:String                     = "\(DateFormats().days) \(DateFormats().monthName) \(DateFormats().year2)"
        static let dd_MMMM_YYYY:String                   = "\(DateFormats().days) \(DateFormats().monthName) \(DateFormats().year4)"

        // DAY NAMES
        static let EEE_MMddyyyy:String                  = "\(DateFormats().dayAbbrev) \(DateFormats().months)/\(DateFormats().day)/\(DateFormats().year4)"
        static let EEE_MMddyy:String                    = "\(DateFormats().dayAbbrev) \(DateFormats().months)/\(DateFormats().day)/\(DateFormats().year2)"
        static let EEE_d_MMM_yyyy:String                = "\(DateFormats().dayAbbrev) \(DateFormats().day) \(DateFormats().monthAbbrev), \(DateFormats().year4)"
        static let EEE_d_MMMM_yyyy:String               = "\(DateFormats().dayAbbrev) \(DateFormats().day) \(DateFormats().monthName), \(DateFormats().year4)"
        static let EEE_d_MMMM_yyyy_at_hmm_a:String      = "\(DateFormats().dayAbbrev) \(DateFormats().day) \(DateFormats().monthName), \(DateFormats().year4) @ \(h_mm_a)"
        static let EEEE_d_MMM_yyyy:String               = "\(DateFormats().dayName) \(DateFormats().day) \(DateFormats().monthAbbrev), \(DateFormats().year4)"
        static let EEEE_d_MMMM_yyyy:String              = "\(DateFormats().dayName) \(DateFormats().day) \(DateFormats().monthName), \(DateFormats().year4)"
        static let EEEE_d_MMMM_yyyy_at_hmm_a:String     = "\(DateFormats().dayName) \(DateFormats().day) \(DateFormats().monthName), \(DateFormats().year4) @ \(h_mm_a)"
        static let EEE_MMM_d_yyyy:String                = "\(DateFormats().dayAbbrev) \(DateFormats().monthAbbrev) \(DateFormats().day), \(DateFormats().year4)"
        static let EEE_MMMM_d_yyyy:String               = "\(DateFormats().dayAbbrev) \(DateFormats().monthName) \(DateFormats().day), \(DateFormats().year4)"
        static let EEE_MMMM_d_yyyy_at_hmm_a:String      = "\(DateFormats().dayAbbrev) \(DateFormats().monthName) \(DateFormats().day), \(DateFormats().year4) @ \(h_mm_a)"
        static let EEEE_MMM_d_yyyy:String               = "\(DateFormats().dayName) \(DateFormats().monthAbbrev) \(DateFormats().day), \(DateFormats().year4)"
        static let EEEE_MMMM_d_yyyy:String              = "\(DateFormats().dayName) \(DateFormats().monthName) \(DateFormats().day), \(DateFormats().year4)"
        static let EEEE_MMMM_d_yyyy_at_hmm_a:String     = "\(DateFormats().dayName) \(DateFormats().monthName) \(DateFormats().day), \(DateFormats().year4) @ \(h_mm_a)"

        // MONTHS
        static let MM:String                            = "\(DateFormats().months)"
        static let MMd:String                           = "\(DateFormats().months)/\(DateFormats().day)"
        static let MMdd:String                          = "\(DateFormats().months)/\(DateFormats().days)"
        static let MMddyy:String                        = "\(DateFormats().months)/\(DateFormats().days)/\(DateFormats().year2)"
        static let MMddyy_hmm_a:String                  = "\(MMddyy) \(h_mm_a)"
        static let MMddyyyy:String                      = "\(DateFormats().months)/\(DateFormats().days)/\(DateFormats().year4)"
        static let MMddyyyy_hmm_a:String                = "\(MMddyyyy) \(h_mm_a)"
        static let MMM:String                           = "\(DateFormats().monthAbbrev)"
        static let MMMyy:String                         = "\(DateFormats().monthAbbrev) '\(DateFormats().year2)"
        static let MMMyyyy:String                       = "\(DateFormats().monthAbbrev) \(DateFormats().year4)"
        static let MMM_d_yyyy:String                    = "\(DateFormats().monthAbbrev) \(DateFormats().day), \(DateFormats().year4)"
        static let MMM_d_yyyy_EEE:String                = "\(MMM_d_yyyy) (\(DateFormats().dayAbbrev))"
        static let MMM_d_yyyy_EEE_at_hmm_a:String       = "\(MMM_d_yyyy) (\(DateFormats().dayAbbrev).) @ \(h_mm_a)"
        static let MMM_d_yyyy_EEE_hmm_a:String          = "\(MMM_d_yyyy) (\(DateFormats().dayAbbrev).) \(h_mm_a)"
        static let MMM_d_yyyy_EEEE:String               = "\(MMM_d_yyyy) (\(DateFormats().dayName))"
        static let MMM_d_yyyy_EEEE_at_hmm_a:String      = "\(MMM_d_yyyy) (\(DateFormats().dayName)) @ \(h_mm_a)"
        static let MMM_d_yyyy_EEEE_hmm_a:String         = "\(MMM_d_yyyy) (\(DateFormats().dayName)) \(h_mm_a)"
        static let MMM_dd_yyyy:String                   = "\(DateFormats().monthAbbrev) \(DateFormats().days), \(DateFormats().year4)"
        static let MMMM_d_yyyy:String                   = "\(DateFormats().monthName) \(DateFormats().day), \(DateFormats().year4)"
        static let MMMM_d_yyyy_EEE:String               = "\(MMMM_d_yyyy) (\(DateFormats().dayAbbrev))"
        static let MMMM_d_yyyy_EEE_at_hmm_a:String      = "\(MMMM_d_yyyy) (\(DateFormats().dayAbbrev).) @ \(h_mm_a)"
        static let MMMM_d_yyyy_EEE_hmm_a:String         = "\(MMMM_d_yyyy) (\(DateFormats().dayAbbrev).) \(h_mm_a)"
        static let MMMM_d_yyyy_EEEE:String              = "\(MMMM_d_yyyy) (\(DateFormats().dayName))"
        static let MMMM_d_yyyy_EEEE_at_hmm_a:String     = "\(MMMM_d_yyyy) (\(DateFormats().dayName)) @ \(h_mm_a)"
        static let MMMM_d_yyyy_EEEE_hmm_a:String        = "\(MMMM_d_yyyy) (\(DateFormats().dayName)) \(h_mm_a)"
        static let MMMM_dd_yyyy:String                  = "\(DateFormats().monthName) \(DateFormats().days), \(DateFormats().year4)"

        // YEARS
        static let yyyy:String                          = "\(DateFormats().year4)"
        static let yyyyMMd:String                       = "\(DateFormats().year4)-\(DateFormats().months)-\(DateFormats().day)"
        static let yyyyMMdd:String                      = "\(DateFormats().year4)-\(DateFormats().months)-\(DateFormats().days)"
        static let yyyyMMdd_hmmss_a:String              = "\(yyyyMMdd) \(h_mm_ss_a)"
        static let yyyyMMdd_HHmmss:String               = "\(yyyyMMdd) \(HH_mm_ss)"
        static let yyyyMMdd_HHmmss_Z:String             = "\(yyyyMMdd_HHmmss) \(TimeFormats.ZoneFormats().RFC_GMT)"
        static let yyyyMMMdd:String                     = "\(DateFormats().year4)-\(DateFormats().monthAbbrev)-\(DateFormats().days)"

        // TIME
        static let h_mm:String                          = "\(TimeFormats().hour):\(TimeFormats().minutes)"
        static let h_mm_a:String                        = "\(h_mm) \(TimeFormats().ampm)"
        static let h_mm_ss:String                       = "\(h_mm):\(TimeFormats().seconds)"
        static let h_mm_ss_a:String                     = "\(h_mm_ss) \(TimeFormats().ampm)"
        static let H_mm:String                          = "\(TimeFormats().hour24):\(TimeFormats().minutes)"
        static let H_mm_a:String                        = "\(H_mm) \(TimeFormats().ampm)"
        static let H_mm_ss:String                       = "\(H_mm):\(TimeFormats().seconds)"
        static let H_mm_ss_a:String                     = "\(H_mm_ss) \(TimeFormats().ampm)"
        static let HH_mm:String                         = "\(TimeFormats().hours24):\(TimeFormats().minutes)"
        static let HH_mm_a:String                       = "\(HH_mm) \(TimeFormats().ampm)"
        static let HH_mm_ss:String                      = "\(HH_mm):\(TimeFormats().seconds)"
        static let HH_mm_ss_a:String                    = "\(HH_mm_ss) \(TimeFormats().ampm)"
    }
}

extension Date: RawRepresentable {
    private static let formatter = ISO8601DateFormatter()
    
    public var rawValue: String {
        Date.formatter.string(from: self)
    }
    
    public init?(rawValue: String) {
        self = Date.formatter.date(from: rawValue) ?? Date()
    }
}
