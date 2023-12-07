
/*--------------------------------------------------------------------------------------------------------------------------
    File: ext_UIDevice.swift
  Author: Kevin Messina
 Created: 2/6/22
Modified:
 
©2022-2023 Creative App Solutions, LLC. - All Rights Reserved.
----------------------------------------------------------------------------------------------------------------------------
NOTES:
--------------------------------------------------------------------------------------------------------------------------*/

import Foundation
import UIKit

// MARK: - *** UIDevice extensions ***
public extension UIDevice {
    static let isZoomed = UIScreen.isZoomed

    struct Family {
        // display Mode
        static let isSim = Bool(TARGET_IPHONE_SIMULATOR == 1)
        static let isPreview = Bool(ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1")
        // device Mode
        static let isPad = (UIDevice.current.userInterfaceIdiom == .pad)
        static let isPhone = (UIDevice.current.userInterfaceIdiom == .phone)
        static let isMac = (UIDevice.current.userInterfaceIdiom == .mac)
        static let isTV = (UIDevice.current.userInterfaceIdiom == .tv)
        static let isCar = (UIDevice.current.userInterfaceIdiom == .carPlay)
        static let isVision = (UIDevice.current.userInterfaceIdiom == .vision)
        
        func typeIs() -> String {
            switch UIDevice.current.userInterfaceIdiom {
                case .pad: return "iPad"
                case .phone: return "iPhone"
                case .carPlay: return "CarPlay"
                case .mac: return "Mac"
                case .vision: return "Vision"
                case .tv: return "TV"
                case .unspecified: return "Unspecified"
                @unknown default:
                    return "Unknown"
            }
        }
    }
}
