/*--------------------------------------------------------------------------------------------------------------------------
    File: ext_String.swift
  Author: Kevin Messina
 Created: Jan 5, 2020
Modified: Jun 22, 2022
 
©2020-2023 Creative App Solutions, LLC. - All Rights Reserved.
----------------------------------------------------------------------------------------------------------------------------
NOTES:
 
2022_06_22 - Added double line formatting to Address.
2021_05_26 - Added formatAsPhoneNumber and removeAllExcept... formatting functions to String.
--------------------------------------------------------------------------------------------------------------------------*/

import Foundation
import SwiftUI
import UIKit
import AudioToolbox

// MARK: - *** STRING ***
extension String {
    // MARK: LENGTH
    func length(_ stringvar: inout String, length: Int, vibrate:Bool = false) {
        if (stringvar.count > length) {
            stringvar = String(stringvar.prefix(length))
            if vibrate {
                AudioServicesPlayAlertSoundWithCompletion(kSystemSoundID_Vibrate) { return }
            }
        }
    }

    // MARK: TRIMMING
    enum TrimmingOptions {
        case replaceAll
        case leading
        case trailing
        case ends
    }
    
    func trim(_ spaces: TrimmingOptions, using characterSet: CharacterSet = .whitespacesAndNewlines) ->  String {
        switch spaces {
            case .replaceAll: return trimAllSpaces(using: characterSet)
            case .leading: return trimLeadingSpaces(using: characterSet)
            case .trailing: return trimTrailingSpaces(using: characterSet)
            case .ends:  return trimLeadingAndTrailingSpaces(using: characterSet)
        }
    }
    
    private func trimLeadingSpaces(using characterSet: CharacterSet) -> String {
        guard let index = firstIndex(where: { !CharacterSet(charactersIn: String($0)).isSubset(of: characterSet) }) else {
            return self
        }
        
        return String(self[index...])
    }
    
    private func trimTrailingSpaces(using characterSet: CharacterSet) -> String {
        guard let index = lastIndex(where: { !CharacterSet(charactersIn: String($0)).isSubset(of: characterSet) }) else {
            return self
        }
        
        return String(self[...index])
    }
    
    private func trimLeadingAndTrailingSpaces(using characterSet: CharacterSet) -> String {
        return trimmingCharacters(in: characterSet)
    }
    
    private func trimAllSpaces(using characterSet: CharacterSet) -> String {
        return components(separatedBy: characterSet).joined()
    }

    // MARK: IS NUMBER
    var isNumber : Bool {
        get{
            return !self.isEmpty && (rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil)
        }
    }

    // MARK: SUBSTRING
/// let str = "Hello, playground"
/// print(str.substring(from: 7))         // playground
/// print(str.substring(to: 5))           // Hello
/// print(str.substring(with: 7..<11))    // play
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
    
    func substring(fromTo r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    // MARK: SUBSCRIPT
    subscript(_ i: Int) -> String {
        let idx1 = index(startIndex, offsetBy: i)
        let idx2 = index(idx1, offsetBy: 1)
        return String(self[idx1..<idx2])
    }
    
/// let s = "hello"
/// s[0..<3] // "hel"
/// s[3...]  // "lo"
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }
    
    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        return String(self[start...])
    }
    
    // MARK: KEY Exists in User Defaults
//    var existsInUserDefaults:Bool {
//        return UserDefaults.standard.isKeyPresent(key: self)
//    }
    
    // MARK: EMAIL ADDRESS Validation
    var isValidEmailAddress: Bool {
        if self.count > 100 {
            return false
        }
        
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)

        return emailPredicate.evaluate(with: self)
    }

    // MARK: Convert String to Date
    func toDate(format:String) -> Date? {
        let formatter = DateFormatter()
            formatter.dateFormat = "\( format )"

        return formatter.date(from: self)
    }

    func toDateFormat(_ format:Date.formats) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "\( format )"
        
        return formatter.date(from: self)
    }

    func toDateFormatType(_ format:Date.formats.types) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "\( format )"
        
        return formatter.date(from: self)
    }

    // MARK: -
    var toDouble: Double? { NumberFormatter().number(from: self)?.doubleValue }
    var toDecimal: Decimal? { NumberFormatter().number(from: self)?.decimalValue }
    var toInt: Int? { NumberFormatter().number(from: self)?.intValue }
    var toInt64: Int64? { NumberFormatter().number(from: self)?.int64Value }

    func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.text = self
            label.font = font
            label.sizeToFit()
        
        return label.frame.height
    }
    
    // MARK: Remove all chars except Numbers
    var removeAllCharsExceptCurrency:String {
        return String(self.filter { String($0).rangeOfCharacter(from: CharacterSet(charactersIn: CharSet.valid.currency_US)) != nil })
    }
    
    var removeAllCharsExceptNumeric:String {
        return String(self.filter { String($0).rangeOfCharacter(from: CharacterSet(charactersIn: CharSet.valid.numeric)) != nil })
    }
    
    var removeAllCharsExceptNumbersOnly:String {
        return String(self.filter { String($0).rangeOfCharacter(from: CharacterSet(charactersIn: CharSet.valid.numbersOnly)) != nil })
    }

    var removeAllCharsExceptDecimal:String {
        return String(self.filter { String($0).rangeOfCharacter(from: CharacterSet(charactersIn: CharSet.valid.decimalPad)) != nil })
    }
    
    // MARK: Remove all chars except alphas
    var removeAllCharsExceptAlpha:String {
        return String(self.filter { String($0).rangeOfCharacter(from: CharacterSet(charactersIn: CharSet.valid.alphaOnly)) != nil })
    }
    
    // MARK: SQL Remove double \\ in Text string from database
    enum ReplacementOptions:Int {
        case doubleBackSlashes
        case doubleApostrophes
        case doubleQuotes
        case allDoubleControlChars
    }
    
    var replaceDoubleBackSlashes:String {
        return self.replacingOccurrences(of: CharSet.SQL.doubleBackSlashes, with: #"\"#)
    }
    
    var replacedoubleQuotes:String {
        return self.replacingOccurrences(of: CharSet.SQL.doubleQuotes, with: "\"" )
    }
    
    var replaceCR:String {
        return self.replacingOccurrences(of: "\\n", with: "\n")
    }
                                         
    var replaceDoubleApostrophes:String {
        return self.replacingOccurrences(of: CharSet.SQL.doubleApostrophes, with: "'" )
    }

    var replaceAllDoubleControlChars:String {
        var temp = self.replaceDoubleBackSlashes
        temp = self.replaceDoubleApostrophes
        temp = self.replacedoubleQuotes
        
        return temp
    }
    
    func replaceSQLChars(_ replacementOptions: ReplacementOptions) ->  String {
        switch replacementOptions {
            case .doubleBackSlashes: return self.replaceDoubleBackSlashes
            case .doubleApostrophes: return self.replaceDoubleApostrophes
            case .doubleQuotes: return self.replacedoubleQuotes
            case .allDoubleControlChars: return self.replaceAllDoubleControlChars
        }
    }

// MARK: Markdown -> AttributedString
    func markdownToAttributed() -> AttributedString {
        do {
            return try AttributedString(
                markdown: self.trim(.trailing),
                options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)
            )
        } catch {
            return AttributedString("Error parsing markdown: \(error)")
        }
    }
    
    // MARK: Format Strings to Address
    func formatAsAddress(address1:String,address2:String,city:String,state:String,zip:String,country:String,abbrevState:Bool,abbrevCountry:Bool=false)
        -> (singleLine:String,doubleLine:String,multipleLine:String)
    {
        var address_single:String = ""
        var address_double:String = ""
        var address_multiple:String = ""
        let stateCode:String = ((state.count > 2) && abbrevState)
            ? Jurisdictions().returnStateCodeFor(state).code
            : state
        let countryCode:String = ((country.count > 2) && abbrevCountry)
            ? Jurisdictions().returnCodeForCountryName(country)
            : country

        //Single
        if !address1.isEmpty { address_single += "\( address1 )" }
        if !address2.isEmpty { address_single += " \( address2 )" }
        if !city.isEmpty { address_single += " \( city )," }
        if !state.isEmpty { address_single += " \( stateCode )" }
        if !zip.isEmpty { address_single += " \( zip )" }
        if !country.isEmpty { address_single += " \( countryCode )" }

        //Double
        if !address1.isEmpty { address_double += "\( address1 )" }
        if !address2.isEmpty { address_double += " ・ \( address2 ) " }
        if !city.isEmpty { address_double += "\n\( city ), " }
        if !state.isEmpty { address_double += "\( stateCode ) " }
        if !zip.isEmpty { address_double += "\( zip ) " }
        if !country.isEmpty { address_double += "\( countryCode )" }

        //Multiple
        if !address1.isEmpty { address_multiple += "\( address1 )" }
        if !address2.isEmpty { address_multiple += "\n\( address2 ) " }
        if !city.isEmpty { address_multiple += "\n\( city ), " }
        if !state.isEmpty { address_multiple += "\( stateCode ) " }
        if !zip.isEmpty { address_multiple += "\( zip ) " }
        if !country.isEmpty { address_multiple += "\n\( countryCode )" }
        
        return (address_single,address_double,address_multiple)
    }
    
    // MARK: Convert String to Phone Number
    var formatAsPhoneNumber:String {
        var formattedString:String = ""
        let strippedValue:String = self.removeAllCharsExceptNumbersOnly
        let length = strippedValue.count

        switch length { // ###-####, (###) ###-####, +# (###) ###-####
            case ..<1 : formattedString = ""
            case 1...3 : formattedString = "\(strippedValue)"
            case 4...6 : formattedString = "(\(strippedValue[0..<3])) \(strippedValue[3..<length])"
            case 7...10 : formattedString = "(\(strippedValue[0..<3])) \(strippedValue[3..<6])-\(strippedValue[6..<length])"
            default: formattedString = strippedValue
        }
        
        return formattedString
    }

    var isValidPhoneNumber: Bool {
        self.removeAllCharsExceptNumbersOnly.count > 9
    }

    // MARK: URL: Validate
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
    
    // MARK: Convert String to U.S. or Canadian Social Security Number
    var isValidSocSecNum: Bool {
        self.removeAllCharsExceptNumbersOnly.count == 9
    }

    func formatAsSocSecNum(isUSA:Bool) -> String {
        // US Format is ###-##-###, Canadian Format is ###-###-###
        
        var formattedString:String = ""
        let strippedValue:String = self.removeAllCharsExceptNumbersOnly
        let length = strippedValue.count

        if isUSA {
            switch length { // ###, ###-##, ###-##-####
                case ..<1 : formattedString = ""
                case 1...3 : formattedString = "\(strippedValue)"
                case 4...5 : formattedString = "\(strippedValue[0..<3])-\(strippedValue[3..<length])"
                case 6...9 : formattedString = "\(strippedValue[0..<3])-\(strippedValue[3..<5])-\(strippedValue[5..<length])"
                default: formattedString = strippedValue
            }
        }else{ //Canada
            switch length { // ###, ###-###, ###-###-###
                case ..<1 : formattedString = ""
                case 1...3 : formattedString = "\(strippedValue)"
                case 4...6 : formattedString = "\(strippedValue[0..<3])-\(strippedValue[3..<length])"
                case 7...9 : formattedString = "\(strippedValue[0..<3])-\(strippedValue[3..<6])-\(strippedValue[6..<length])"
                default: formattedString = strippedValue
            }

        }

        return formattedString
    }
}

