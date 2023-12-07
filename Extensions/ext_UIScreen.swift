/*--------------------------------------------------------------------------------------------------------------------------
    File: ext_UIScreen.swift
  Author: Kevin Messina
 Created: 1/25/21
Modified:
 
 ©2021-2023 Creative App Solutions, LLC. - All Rights Reserved.
----------------------------------------------------------------------------------------------------------------------------
 NOTES:
--------------------------------------------------------------------------------------------------------------------------*/


import Foundation
import UIKit

extension UIScreen{
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let size = UIScreen.main.bounds.size
    static let isZoomed:Bool = UIScreen.main.scale > UIScreen.main.nativeScale
}
