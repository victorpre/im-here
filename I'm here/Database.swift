//
//  Database.swift
//  I'm here
//
//  Created by Victor Presumido on 2/28/17.
//  Copyright © 2017 Victor Presumido. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Shifts: NSObject{
  
  var instance: NSManagedObjectContext{
    return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  }
  
  func drop() {
    let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "Shift"))
    do {
      try instance.execute(DelAllReqVar)
    }
    catch {
      print(error)
    }
  }
  
  func add(time: NSDate) -> Bool{
    if(isBeginning() == false){
      print("saindo")
      last().endTime = time
    } else{
      print("Entrando")
      let shift = Shift(context: instance)
      shift.beginTime = time
      
    }
    return commit()
  }
  
  func update(shift: Shift, time: NSDate) -> Bool {
    shift.endTime = time
    return self.commit()
  }
  
  func commit() -> Bool {
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
    print("Saved on DB")
    return true
  }
  
  func all() -> Array<Shift> {
    var shifts : [Shift] = []
    do{
      shifts = try instance.fetch(Shift.fetchRequest())
    }
    catch{
      print("Fetching failed")
    }
    return shifts
  }
  
  func punches() -> Array<NSDate> {
    var punches : [NSDate] = []
    for shift in all(){
      punches.append(shift.beginTime!)
      if(shift.endTime != nil){
        punches.append(shift.endTime!)
      }
    }
    return punches
  }
  
  func last() -> Shift {
    return all()[all().count-1]
  }
  
  func isBeginning() -> Bool {
    
    if(all().count == 0){
      return true
    }
    
    if (last().endTime != nil){
      return true
    }
    return false
  }
  

}

extension Date {
  var startOfDay: Date {
    return Calendar.current.startOfDay(for: self)
  }
  
  var endOfDay: Date? {
    var components = DateComponents()
    components.day = 1
    components.second = -1
    return Calendar.current.date(byAdding: components, to: startOfDay)
  }
}



