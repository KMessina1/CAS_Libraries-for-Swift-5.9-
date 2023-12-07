/*--------------------------------------------------------------------------------------------------------------------------
    File: AppRating.swift
  Author: Kevin Messina
 Created: Jan 7, 2020
Modified: Nov 2, 2020

©2020-2023 Creative App Solutions, LLC. - All Rights Reserved.
----------------------------------------------------------------------------------------------------------------------------
NOTES:

2020/11/02 - Converted to SwiftUI
--------------------------------------------------------------------------------------------------------------------------*/

import SwiftUI
import StoreKit

/// Functions relating to StoreKit App Rating functionality.
struct AppRating {
    var minimumRunCount:Int = 10
    
    struct keys {
        static let appRunCount = "appRating.runcount"
    }

    var runCount:Int {
        UserDefaults.standard.integer(forKey: AppRating.keys.appRunCount)
    }

    func incrementAppRating(reset:Bool? = false) -> Void {
        let newRunCount = reset! ?0 :(runCount + 1)
            
        UserDefaults.standard.setValue(newRunCount, forKey: AppRating.keys.appRunCount)
        UserDefaults.standard.synchronize()
    }
    
    func displayReviewInScene() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
    func showReview(forceShowForTest:Bool) {
        simPrint(type: .info, msg: "AppRating: Show review", log: logFileFunctionLine())

        if (forceShowForTest && !runtimeIs().Release) {
            simPrint(type: .info, msg: "AppRating: Forced Review from AppDelegate requested from AppStore", log: logFileFunctionLine())
            displayReviewInScene()
            return
        }

        if (runCount >= minimumRunCount) {
            simPrint(type: .info, msg: "AppRating: Review requested from AppStore", log: logFileFunctionLine())
            displayReviewInScene()
            incrementAppRating(reset:true)
            simPrint(type: .info, msg: "AppRating: Run count reset to 0", log: logFileFunctionLine())
        } else {
            simPrint(type: .info, msg: "AppRating: Run count of: \(runCount) are not enough to request review.", log: logFileFunctionLine())
        }
    }
}

