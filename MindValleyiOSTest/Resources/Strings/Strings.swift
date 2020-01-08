////
//  
//
//	Strings.swift written using Swift 4.0
//
//  Created on: 19/12/2018
//
//  Copyright © 2018 SafeBoda. All rights reserved.
//

import Foundation

enum Strings: String {
    // MARK: Common
    case commonOkay = "Common_Okay"
    case commonCancel = "Common_Cancel"
    case commonNo = "Common_No"
    case commonYes = "Common_Yes"
    case commonHours = "Common_Hours"
    case commonMinutes = "Common_Minutes"
    case commonShortMinutes = "Common_ShortMinutes"
    case commonPleaseWait = "Common_PleaseWait"
    
    // MARK: Errors
    case commonGeneralError = "Common_GeneralError"
    case commonInternetError = "Common_InternetError"
    
    // MARK: Date
    case dateToday = "Date_Today"
    case dateTime = "Date_Time"
    case dateYesterday = "Date_Yesterday"
    
    // MARK: Home
    case homeTitle = "Home_Title"
   
    func localized() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
