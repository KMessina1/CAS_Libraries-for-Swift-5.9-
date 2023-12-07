/*--------------------------------------------------------------------------------------------------------------------------
    File: extDouble.swift
  Author: Kevin Messina
 Created: Jan 5, 2020
Modified:

©2020-2023 Creative App Solutions, LLC. - All Rights Reserved.
----------------------------------------------------------------------------------------------------------------------------
NOTES:
--------------------------------------------------------------------------------------------------------------------------*/

import Foundation

// MARK: - *** DOUBLE ***
extension Double {
    var intValue: Int { return Int(self) }
    
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func fractionChar() -> String {
        let fraction = modf(self).1
        var fractionChar = ""
        
        switch fraction {
        case ..<0.125: fractionChar = ""
        case ..<0.250: fractionChar = "⅛"
        case ..<0.375: fractionChar = "¼"
        case ..<0.500: fractionChar = "⅜"
        case ..<0.625: fractionChar = "½"
        case ..<0.750: fractionChar = "⅝"
        case ..<0.875: fractionChar = "¾"
        case ..<1.000: fractionChar = "⅞"
        default: fractionChar = ""
        }
        
        return fractionChar
    }

    
    // MARK: ---- FORMATTING ----
    func formatAsCurrency(showSymbol:Bool? = true, CountryCode:String? = "",negPrefix:String?="(",negSuffix:String?=")") -> String {
        let formatter:NumberFormatter! = NumberFormatter()
            formatter.locale = CountryCode!.isEmpty ?Locale.current :Locale.init(identifier: CountryCode!)
            formatter.numberStyle = .currency
            formatter.currencySymbol = showSymbol! ?formatter.locale.currencySymbol : ""
            formatter.groupingSeparator = Locale.current.groupingSeparator ?? ","
            formatter.maximumFractionDigits = 2
            formatter.negativePrefix = negPrefix!
            formatter.negativeSuffix = negSuffix!

        return formatter.string(from: NSNumber(value: self)) ?? "n/a"
    }
    
    func formatAsNumber(decimalPlaces:Int?=0,negPrefix:String?="-",negSuffix:String?="") -> String {
        let formatter:NumberFormatter! = NumberFormatter()
            formatter.locale = Locale.current
            formatter.numberStyle = .decimal
            formatter.groupingSeparator = Locale.current.groupingSeparator ?? ","
            formatter.maximumFractionDigits = decimalPlaces!
            formatter.negativePrefix = negPrefix!
            formatter.negativeSuffix = negSuffix!

        return formatter.string(from: NSNumber(value: self)) ?? "n/a"
    }

    func formatAsPercent(decimalPlaces:Int?=0,negPrefix:String?="-",negSuffix:String?="") -> String {
        let formatter:NumberFormatter! = NumberFormatter()
            formatter.locale = Locale.current
            formatter.numberStyle = .percent
            formatter.groupingSeparator = Locale.current.groupingSeparator ?? ","
            formatter.maximumFractionDigits = decimalPlaces!
            formatter.negativePrefix = negPrefix!
            formatter.negativeSuffix = negSuffix!
            formatter.maximumSignificantDigits = 3

        return formatter?.string(from: NSNumber(value: self)) ?? "n/a"
    }

    // MARK: ---- 📏Measurements IMPERIAL -> METRIC ----
    // MARK: 📏Miles to Imperial...
    /// - returns: miles to yards conversion
    var convert_miles_yards: Double { return self / 1760 }
    /// - returns: miles to feet conversion
    var convert_miles_ft: Double { return self * 5280 }
    /// - returns: miles to inch conversion
    var convert_miles_inch: Double { return self * 63360 }

    // MARK: 📏Miles to  -> Metric...
    /// - returns: miles to kilometer conversion
    var convert_miles_km: Double { return self * 1.609 }
    /// - returns: miles to meter conversion
    var convert_miles_m: Double { return self * 1609.344 }
    /// - returns: miles to centimeters conversion
    var convert_miles_cm: Double { return self * 160934.4 }
    /// - returns: miles to millilmeters conversion
    var convert_miles_mm: Double { return self * 1.609e+6 }

    // MARK: 📏Yards -> Imperial...
    /// - returns:yards to miles conversion
    var convert_yards_miles: Double { return self / 1760 }
    /// - returns: yards to feet conversion
    var convert_yards_ft: Double { return self * 3 }
    /// - returns: yards to inch conversion
    var convert_yards_inch: Double { return self * 36 }

    // MARK: 📏 Yards -> Metric...
    /// - returns: yards to kilometer conversion
    var convert_yards_km: Double { return self / 1093.613 }
    /// - returns: yards to meter conversion
    var convert_yards_m: Double { return self / 1.094 }
    /// - returns: yards to centimeters conversion
    var convert_yards_cm: Double { return self * 91.44 }
    /// - returns: yards to millilmeters conversion
    var convert_yards_mm: Double { return self * 914.4 }

    
    // MARK: 📏Feet -> Imperial...
    /// - returns: feet to miles conversion
    var feetToMiles: Double { return self / 5280 }
    /// - returns: feet to yards conversion
    var feetToYards: Double { return self / 3 }
    /// - returns: feet to inch conversion
    var feetToInches: Int { return Int(self * 12) }

    // MARK: 📏Feet -> Metric...
    /// - returns: feet to kilometer conversion
    var convert_ft_km: Double { return self * 0.0003048 }
    /// - returns: feet to meters conversion
    var convert_ft_m: Double { return self * 0.3048 }
    /// - returns: feet to centimeters conversion
    var convert_ft_cm: Double { return self * 30.48 }
    /// - returns: feet to millilmeters conversion
    var convert_ft_mm: Double { return self * 304.8 }

    
    // MARK: 📏Inches -> Imperial...
    /// - returns: Inches to miles conversion
    var inchesToMiles: Double { return self / 63360 }
    /// - returns: Inches to yards conversion
    var inchesToYards: Double { return self / 36 }
    /// - returns: Inches to inch conversion
    var inchesToFeet: Double { return self / 12 }
    var inchesToFeetAndInches: (feet: Int,inches: Int,string:String) {
        let feetInInches:Int = self.intValue
        let feet:Int = self.inchesToFeet.intValue
        let inches:Int = Int(feetInInches - (feet * 12))
        let string:String = "\( feet )'\( inches )\""
        
        return (feet,inches,string)
    }

    // MARK: 📏Inches -> Metric...
    /// - returns: Inches to kilometer conversion
    var convert_in_km: Double { return self / 39370.079 }
    /// - returns: Inches to meters conversion
    var convert_in_m: Double { return self / 39.37 }
    /// - returns: Inches to centimeters conversion
    var convert_in_cm: Double { return self * 2.54 }
    /// - returns: Inches to millilmeters conversion
    var convert_in_mm: Double { return self * 25.4 }

    
// MARK: ---- 📏Measurements METRIC -> IMPERIAL ----
    // MARK: 📏km -> Imperial...
    /// - returns: kilometer to miles conversion
    var convert_km_miles: Double { return self / 1.609 }
    /// - returns: kilometer to yards conversion
    var convert_km_yards: Double { return self * 1093.613 }
    /// - returns: kilometer to feet conversion
    var convert_km_feet: Double { return self * 3280.84 }
    /// - returns: kilometer to inches conversion
    var convert_km_inches: Double { return self * 39370.079 }

    // MARK: 📏km -> ...Metric
    /// - returns: kilometer to meter conversion
    var convert_km_m: Double { return self / 100.0 }
    /// - returns: kilometer to centimeter conversion
    var convert_km_cm: Double { return self / 100.0 }
    /// - returns: kilometer to millimeter conversion
    var convert_km_mm: Double { return self / 1000 }

    // MARK: 📏m -> Imperial...
    /// - returns: meter to miles conversion
    var convert_m_miles: Double { return self / 1609.344 }
    /// - returns: meter to yards conversion
    var convert_m_yards: Double { return self * 1.094 }
    /// - returns: meter to feet conversion
    var convert_m_feet: Double { return self * 3.281 }
    /// - returns: meter to inches conversion
    var convert_m_inches: Double { return self * 39.37 }

    // MARK: 📏m -> ...Metric
    /// - returns: meter to kilmeter conversion
    var convert_m_km: Double { return self / 1000 }
    /// - returns: meter to centimeter conversion
    var convert_m_cm: Double { return self * 100 }
    /// - returns: meter to millimeter conversion
    var convert_m_mm: Double { return self * 1000 }

    // MARK: 📏cm -> Imperial...
    /// - returns: centimeter to miles conversion
    var convert_cm_miles: Double { return self / 160934.4 }
    /// - returns: centimeter to yards conversion
    var convert_cm_yards: Double { return self / 91.44 }
    /// - returns: centimeter to feet conversion
    var convert_cm_feet: Double { return self / 30.48 }
    /// - returns: centimeter to inches conversion
    var convert_cm_inches: Double { return self * 39.37 }

    // MARK: 📏cm -> ...Metric
    /// - returns: centimeter to kilmeter conversion
    var convert_cm_km: Double { return self / 100000 }
    /// - returns: centimeter to meter conversion
    var convert_cm_m: Double { return self / 100 }
    /// - returns: centimeter to millimeter conversion
    var convert_cm_mm: Double { return self / 2.54 }

    // MARK: 📏mm -> Imperial...
    /// - returns: millimeter to miles conversion
    var convert_mm_miles: Double { return self / 1.609e+6 }
    /// - returns: millimeter to yards conversion
    var convert_mm_yards: Double { return self / 914.4 }
    /// - returns: millimeter to feet conversion
    var convert_mm_feet: Double { return self / 304.8 }
    /// - returns: millimeter to inches conversion
    var convert_mm_inches: Double { return self / 25.4 }

    // MARK: 📏cm -> ...Metric
    /// - returns: millimeter to kilmeter conversion
    var convert_mm_km: Double { return self / 1e+6 }
    /// - returns: millimeter to meter conversion
    var convert_mm_m: Double { return self / 1000 }
    /// - returns: millimeter to centimeter conversion
    var convert_mm_cm: Double { return self / 10 }
    
// MARK: ---- 📏Weights IMPERIAL -> IMPERIAL ----
    // MARK: 📏oz -> ...Imperial
    /// - returns: Ounce to Pounds conversion
    var oz_lbs: Double { return self / 16 }
    var oz_lbsAndOunces: (lbs: Int,ounces: Int,shortString:String,string:String,fullString:String) {
        let poundsInOunces:Int = self.intValue
        let pounds:Int = self.oz_lbs.intValue
        let ounces:Int = Int(poundsInOunces - (pounds * 16))
        let shortString:String = "\( pounds ).\( ounces )"
        let string:String = "\( pounds ).\( ounces ) lbs"
        let fullString:String = "\( pounds ) lbs \( ounces ) oz"

        return (pounds,ounces,shortString,string,fullString)
    }

    /// - returns: Ounce to Stone conversion
    var oz_stone: Double { return self / 224 }

    // MARK: ---- 📏Weights IMPERIAL -> METRIC ----
    // MARK: 📏oz -> ...Metric
    /// - returns: Ounce to Kilograms conversion
    var convert_oz_kg: Double { return self / 35.274 }
    /// - returns: Ounce to Grams conversion
    var convert_oz_g: Double { return self * 28.35 }
    /// - returns: Ounce to Milligrams conversion
    var convert_oz_mg: Double { return self * 28349.523 }

    // MARK: 📏st -> ...Imperial
    /// - returns: Stone to Pounds conversion
    var convert_st_lbs: Double { return self * 14 }
    /// - returns: Stone to Ounces conversion
    var convert_st_oz: Double { return self * 224 }

    // MARK: 📏st -> ...Metric
    /// - returns: Stone to Kilograms conversion
    var convert_st_kg: Double { return self * 6.35 }
    /// - returns: Stone to Grams conversion
    var convert_st_g: Double { return self * 6350.293 }
    /// - returns: Stone to Milligrams conversion
    var convert_st_mg: Double { return self * 6.35e+6 }

    
// MARK: ---- 📏Weights METRIC -> IMPERIAL ----
    // MARK: 📏kg -> ...Imperial
    /// - returns: Kilogram to Pounds conversion
    var convert_kg_lbs: Double { return self * 2.205 }
    /// - returns: Kilogram to Ounces conversion
    var convert_kg_oz: Double { return self * 35.274 }
    /// - returns: Kilogram to Stone conversion
    var convert_kg_st: Double { return self / 6.35 }

    // MARK: 📏kg -> ...Metric
    /// - returns: Kilogram to Milligrams conversion
    var convert_kg_mg: Double { return self * 1e+6 }
    /// - returns: Kilogram to Grams conversion
    var convert_kg_g: Double { return self * 1000 }

    // MARK: 📏g -> ...Imperial
    /// - returns: Grams to Pounds conversion
    var convert_g_lbs: Double { return self / 453.592 }
    /// - returns: Grams to Ounces conversion
    var convert_g_oz: Double { return self / 28.35 }
    /// - returns: Grams to Stone conversion
    var convert_g_st: Double { return self / 6350.293 }

    // MARK: 📏g -> ...Metric
    /// - returns: Grams to Kilograms conversion
    var convert_g_kg: Double { return self / 1000 }
    /// - returns: Grams to Milligrams conversion
    var convert_g_mg: Double { return self * 1000 }

    // MARK: 📏mg -> ...Imperial
    /// - returns: Milligram to Pounds conversion
    var convert_mg_lbs: Double { return self / 453592.37 }
    /// - returns: Milligram to Ounces conversion
    var convert_mg_oz: Double { return self / 28349.523 }
    /// - returns: Milligram to Stone conversion
    var convert_mg_st: Double { return self / 6.35e+6 }

    // MARK: 📏mg -> ...Metric
    /// - returns: Milligram to Kilograms conversion
    var convert_mg_kg: Double { return self / 1e+6 }
    /// - returns: Milligram to Grams conversion
    var convert_mg_g: Double { return self / 1000 }

// MARK: ---- 📏Liquids IMPERIAL -> METRIC ----
//TODO: 🔖(Reminder) Add Liquid Conversions
    
// MARK: ---- 📏Liquids METRIC -> IMPERIAL ----

}


