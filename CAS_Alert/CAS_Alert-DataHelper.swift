/*--------------------------------------------------------------------------------------------------------------------------
    File: CAS_Alert-DataHelper.swift
  Author: Kevin Messina
 Created: May 17, 2022
Modified:
 
 ©2022-2023 Creative App Solutions, LLC. - All Rights Reserved.
----------------------------------------------------------------------------------------------------------------------------
NOTES:


--------------------------------------------------------------------------------------------------------------------------*/

import SwiftUI
import SwiftData

//var CASAlert_dbQueue: DatabaseQueue!

// MARK: - *** CAS ALERT DATA ***
struct CASAlertData {
    // MARK: - *** Status Types ***
    struct StatusType:Identifiable,Equatable,Hashable {
        var id:UUID = UUID()
        var index:Int64 = -1
        var name:String = ""
        var number:Int = -1
        
//        // MARK: -
//        func getNumberForType(_ name:String) -> Int {
//            let whereCondition = "name='\(name)'"
//            var number:Int = -1
//            
//            do {
//                let allRecords = try SQL().get(dbQueue: CASAlert_dbQueue, table: CASAlertData.tableName.statusTypes, where: whereCondition)
//                if allRecords.count > 0 {
//                    number = allRecords.first!.asDictionary["index"] as! Int
//                }
//
//                simPrintDB(type:.success,action:.fetchAll,found:allRecords.count,table:CASAlertData.tableName.statusTypes,query:whereCondition, log: logFileFunctionLine())
//            } catch{
//                simPrint(type: .error, msg: "Error loading db record index: \(self.index)",errorMsg:error.localizedDescription, log: logFileFunctionLine())
//            }
//            
//            return number
//        }
    }

    // MARK: - *** Theme ***
//    struct Theme:Identifiable,Equatable,Hashable {
//        var id:UUID = UUID()
//        var index:Int64
//        var name:String
//        var backColor:Color
//        var iconColor:Color
//        var imgName:String
//        var tite:String
//        var message:String
//        var notation:String
//        var style:CAS_Alert.styleType
//        var operation:CAS_Alert.operationTypes
        
        // MARK: -
//        func load(where whereCondition:String = "") -> [Theme] {
//            var records:[Theme] = []
//
//            do {
//                let allRecords = try SQL().get(dbQueue: CASAlert_dbQueue, table: CASAlertData.tableName.themes, where: whereCondition, orderBy: "StatusType",ascending: true)
//                for record in allRecords {
//                    let dict = record.asDictionary
//
//                    records.append(
//                        Theme.init(
//                            id: UUID.init(),
//                            index: dict["indx"] as! Int64,
//                            name: dict["name"] as! String,
//                            backColor: Color.Alert.info,
//                            iconColor: Color.white,
//                            imgName: CAS_Alert.images().getImageNamed(dict["imgName"] as! String),
//                            title: dict["title"] as! String,
//                            message: dict["message"] as! String,
//                            notation: dict["notation"] as! String,
//                            style:CAS_AlertDataModel.styleType(rawValue: dict["StatusType"] as! Int) ?? .none,
//                            operation:.cannotSendMail
//                        )
//
//                        StatusType: CAS_AlertDataModel.statusTypes(rawValue: dict["StatusType"] as! Int) ?? .none,
//                        Text: dict["Text"] as! String
//                    ))
//                }
//
//                records.sort(by: { ($0.StatusType.rawValue < $1.StatusType.rawValue) })
//
//                simPrintDB(type:.success,action:.fetchAll,found:allRecords.count,table:CASAlertData.tableName.themes,query:whereCondition, log: logFileFunctionLine())
//            } catch{
//                simPrint(type: .error, msg: "Error loading db record index: \(self.index)",errorMsg:error.localizedDescription, log: logFileFunctionLine())
//            }
//
//            return records
//        }
//    }

    // MARK: - *** Predefined_Messages ***
    struct Predefined_Messages: Identifiable,Equatable,Hashable {
        var id:UUID = UUID()
        var Indx:Int64 = Int64()
        var StatusType:CAS_Alert.statusTypes = .none
        var Message:String = ""
        var Notation:String = ""
        
        // MARK: -
//        func load(where whereCondition:String = "") -> [Predefined_Messages] {
//            var records:[Predefined_Messages] = []
//            
//            do {
//                let allRecords = try SQL().get(dbQueue: CASAlert_dbQueue, table: CASAlertData.tableName.predefinedMessages, where: whereCondition, orderBy: "StatusType",ascending: true)
//                for record in allRecords {
//                    let dict = record.asDictionary
//                    
//                    records.append( Predefined_Messages.init(
//                        id: UUID.init(),
//                        Indx: dict["Indx"] as! Int64,
//                        StatusType: CAS_Alert.statusTypes(rawValue: dict["StatusType"] as! Int) ?? .none,
//                        Message: dict["Message"] as! String,
//                        Notation: dict["Notation"] as! String
//                    ))
//                }
//                
//                records.sort(by: { ($0.StatusType.rawValue < $1.StatusType.rawValue) })
//                
//                simPrintDB(type:.success,action:.fetchAll,found:allRecords.count,table:CASAlertData.tableName.predefinedMessages,query:whereCondition, log: logFileFunctionLine())
//            } catch{
//                simPrint(type: .error, msg: "Error loading db record index: \(self.Indx)",errorMsg:error.localizedDescription, log: logFileFunctionLine())
//            }
//            
//            return records
//        }
        
        func getMessageNamed(_ name:String, replacementText:String = "") -> String {
            var type = String(reflecting: name.lowercased()).components(separatedBy: ".").last ?? ""
            type = type.replacingOccurrences(of: "\"", with: "")

            var newMessage = CAS_AlertDataModel.returnValueForType().returnTextForStatusType(name).Message
            newMessage = newMessage.replacingOccurrences(of: "~text~", with: replacementText)

            return newMessage
        }

        func getNotationNamed(_ name:String,replacementText:String = "") -> String {
            var type = String(reflecting: name.lowercased()).components(separatedBy: ".").last ?? ""
            type = type.replacingOccurrences(of: "\"", with: "")
            
            var newNotation = CAS_AlertDataModel.returnValueForType().returnTextForStatusType(name).Notation
            newNotation = newNotation.replacingOccurrences(of: "~text~", with: replacementText)
            
            return newNotation
        }
    }
}


