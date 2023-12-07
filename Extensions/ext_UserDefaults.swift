/*--------------------------------------------------------------------------------------------------------------------------
    File: lib_UserDefaults.swift
  Author: Kevin Messina
 Created: 7/1/23
Modified:
 
©2023 Creative App Solutions, LLC. - All Rights Reserved.
----------------------------------------------------------------------------------------------------------------------------
NOTES:
--------------------------------------------------------------------------------------------------------------------------*/

import Foundation

extension UserDefaults {
    func isKeyPresent(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
