//
//  Clock.swift
//  I'm here
//
//  Created by Victor Presumido on 2/27/17.
//  Copyright © 2017 Victor Presumido. All rights reserved.
//

import Foundation
import SwiftDate

class Clock{
    
    var currentTime: NSDate{
        return NSDate()
    }
    
    func timeDiffInSeconds(arrivalDate: NSDate, leavingDate: NSDate)->Int{
        let timeDiff = leavingDate.timeIntervalSince(arrivalDate as Date)
        return Int(timeDiff.rounded(.towardZero))
    }
    
    func workedSeconds(dates: Array<NSDate>)->Int{
        var seconds = 0
        let maxIndex = (dates.count % 2 == 0) ? dates.count : dates.count-1
        for index in stride(from: 0,to: maxIndex, by: 2) {
            seconds = seconds + Int(self.timeDiffInSeconds(arrivalDate: dates[index+1], leavingDate: dates[index]))
        }
        
        if seconds < 0{
            return seconds * -1
        }
        return seconds
    }
    
    func seconds2Timestamp(seconds: Int)->String {
        let mins:Int  = (seconds%3600)/60
        let hours:Int = (seconds/3600)
        let secs:Int  = (seconds%3600)%60
        
        let strTimestamp : String = ((hours < 10) ? "0" : "") + String(hours) + ":" + ((mins<10) ? "0" : "") + String(mins) + ":" + ((secs<10) ? "0" : "") + String(secs)

        return strTimestamp
    }
}
