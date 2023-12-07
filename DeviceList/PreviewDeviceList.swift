/*--------------------------------------------------------------------------------------------------------------------------
    File: PreviewDeviceList.swift
  Author: Kevin Messina
 Created: Jul 3, 2020
Modified: Jan 16, 2021
 
©2020-2023 Creative App Solutions, LLC. - All Rights Reserved.
----------------------------------------------------------------------------------------------------------------------------
Notes: To get a list of all preview devices, start TERMINAL and paste in: xcrun simctl list devicetypes
 
--------------------------------------------------------------------------------------------------------------------------*/

import Foundation

// MARK: - *** DEVICES (Preview) ***
struct PreviewDeviceList  {
    // MARK: - == Desktops ==
    static let Mac:String = "Mac"
    
    // MARK: - == iPhones ==
    struct iPhone {
        struct _4 {
            static let S:String = "iPhone 4s"
        }
        
        struct _5 {
            static let _1:String = "iPhone 5"
            static let S:String = "iPhone 5s"
        }
        
        struct _6 {
            static let _1:String = "iPhone 6"
            static let Plus:String = "iPhone 6 Plus"
        }

        struct _6s {
            static let _1:String = "iPhone 6s"
            static let Plus:String = "iPhone 6s Plus"
        }

        struct _7 {
            static let _1:String = "iPhone 7"
            static let Plus:String = "iPhone 7 Plus"
        }

        struct _8 {
            static let _1:String = "iPhone 8"
            static let Plus:String = "iPhone 8 Plus"
        }
        
        struct SE {
            static let _1:String = "iPhone SE"
            static let _2:String = "iPhone SE (2nd gen)"
        }

        struct X {
            static let _1:String = "iPhone X"
            static let XR:String = "iPhone Xr"
        }
        
        struct _11 {
            static let _1:String = "iPhone 11"
            struct Pro {
                static let _1:String = "iPhone 11 Pro"
                static let Max:String = "iPhone 11 Pro Max"
            }

            struct Xs {
                static let _1:String = "iPhone Xs"
                static let Max:String = "iPhone Xs Max"
            }
        }

        struct _12 {
            static let _1:String = "iPhone 12"
            static let Mini:String = "iPhone 12 Mini"
            struct Pro {
                static let _1:String = "iPhone 12 Pro"
                static let Max:String = "iPhone 12 Pro Max"
            }
        }
        
        struct _13 {
            static let _1:String = "iPhone 13"
            static let Mini:String = "iPhone 13 Mini"
            struct Pro {
                static let _1:String = "iPhone 13 Pro"
                static let Max:String = "iPhone 13 Pro Max"
            }
        }

        struct _14 {
            static let Base:String = "iPhone 14"
            static let Pro:String = "iPhone 14 Pro"
            static let Max:String = "iPhone 14 Pro Max"
        }
    }
    
    // MARK: - == iPads ==
    struct iPad {
        static let Retina = "iPad Retina"
        static let _1 = "iPad"
        static let _2 = "iPad 2"
        static let _3 = "iPad 3"
        static let _4 = "iPad 4"
        static let _5 = "iPad (5th gen)"
        static let _6 = "iPad (6th gen)"
        static let _7 = "iPad (7th gen)"
        static let _8 = "iPad (8th gen)"
        static let _9 = "iPad (9th gen)"

        struct Mini {
            static let _1 = "iPad mini"
            static let _2 = "iPad mini 2"
            static let _3 = "iPad mini 3"
            static let _4 = "iPad mini 4"
            static let _5 = "iPad mini 5th generation"
            static let _6 = "iPad mini 6th generation"
        }
        
        struct Air {
            static let _1 = "iPad Air"
            static let _2 = "iPad Air 2"
            static let _3 = "iPad Air (3rd gen)"
            static let _4 = "iPad Air (4th gen)"
        }

        struct Pro {
            static let _9_7 = "iPad Pro (9.7-inch)"
            static let _10_5 =  "iPad Pro (10.5-inch)"

            struct _11 {
                static let _1 = "iPad Pro (11-inch)"
                static let _2 = "iPad Pro (11-inch)  (2nd gen)"
                static let _3 = "iPad Pro (11-inch)  (3rd gen)"
            }
            
            struct _12_9 {
                static let _1 = "iPad Pro"
                static let _2 = "iPad Pro 12.9-inch)  (2nd gen)"
                static let _3 = "iPad Pro 12.9-inch)  (3rd gen)"
                static let _4 = "iPad Pro (12.9-inch) (4th gen)"
                static let _5 = "iPad Pro (12.9-inch) (5th gen)"
            }
        }
    }
    
    // MARK: - == iPods ==
    struct iPodTouch {
        static let _6 = "iPod touch (6th gen)"
        static let _7 = "iPod touch (7th gen)"
        static let _8 = "iPod touch (8th gen)"
    }

    // MARK: - == TV ==
    struct TV {
        static let _1 = "Apple TV (1st Gen)"
        static let _2 = "Apple TV (2nd Gen)"
        static let _3 = "Apple TV (3rd Gen)"
        static let _4 = "Apple TV (4th Gen)"
        static let _4k_1 = "Apple TV 4K (1st Gen)"
        static let _4k_2 = "Apple TV 4K (2nd Gen)"
    }
    
    // MARK: - == Watches ==
    struct Watch {
        struct _1 {
            static let _38mm = "Apple Watch 38mm"
            static let _42mm = "Apple Watch 42mm"
        }

        struct _2 {
            static let _38mm = "Apple Watch Series 2 38mm"
            static let _42mm = "Apple Watch Series 2 42mm"
        }
        
        struct _3 {
            static let _38mm = "Apple Watch Series 3 38mm"
            static let _42mm = "Apple Watch Series 3 42mm"
        }
        
        struct _4 {
            static let _40mm = "Apple Watch Series 4 40mm"
            static let _44mm = "Apple Watch Series 4 44mm"
        }
        
        struct _5 {
            static let _40mm = "Apple Watch Series 5 40mm"
            static let _44mm = "Apple Watch Series 5 44mm"
        }
        
        struct SE {
            static let _40mm = "Apple Watch SE 40mm"
            static let _44mm = "Apple Watch SE 44mm"
        }

        struct _6 {
            static let _40mm = "Apple Watch Series 6 40mm"
            static let _44mm = "Apple Watch Series 6 44mm"
        }

        struct _7 {
            static let _40mm = "Apple Watch Series 7 40mm"
            static let _44mm = "Apple Watch Series 7 44mm"
        }
    }
    
    // MARK: - == Color Schemes ==
    struct colorScheme {
        static let dark = "Dark Scheme"
        static let light = "Light Scheme"
    }
}
