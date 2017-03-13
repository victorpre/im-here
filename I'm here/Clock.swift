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
    
    func timeDiffInSeconds(begin: NSDate, end: NSDate)->Int{
        let timeDiff = end.timeIntervalSince(begin as Date)
        return Int(timeDiff.rounded(.towardZero))
    }
    
    func workedSeconds(dates: Array<NSDate>)->Int{
        var seconds = 0
        var maxIndex = 0
        var fromIndex = 0
        if(dates.count % 2 == 0){
            maxIndex = dates.count
        }else{
            fromIndex = 1
            maxIndex = dates.count-1
        }
        
        for index in stride(from: fromIndex,to: maxIndex, by: 2) {
            seconds = seconds + Int(self.timeDiffInSeconds(begin: dates[index+1], end: dates[index]))
        }
        print (seconds)
        if seconds < 0 {
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
