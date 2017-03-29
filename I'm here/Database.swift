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
//      print("saindo")
      last().endTime = time
    } else{
//      print("Entrando")
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
//    print("Saved on DB")
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
  
  func punches(start: NSDate?, end: NSDate?) -> Array<NSDate> {
    var punches : [NSDate] = []
    var shifts : [Shift] = []
    if(start != nil && end != nil){
      for shift in between(start: start!, end: end!){
        shifts.append(shift)
      }
    }else{
      for shift in all(){
        shifts.append(shift)
      }
      
    }
    for shift in shifts{
      if(shift.endTime != nil){
        punches.append(shift.endTime!)
      }
      punches.append(shift.beginTime!)
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
  
  func between(start: NSDate, end: NSDate) -> Array<Shift> {
    var shifts : [Shift] = []
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Shift")
    //    TODO get in descending order
    let sortDescriptor = NSSortDescriptor(key: "beginTime", ascending: false)
    fetchRequest.sortDescriptors = [sortDescriptor]
    fetchRequest.predicate = NSPredicate(format: "beginTime >= %@ AND beginTime <= %@", start, end)
    
    let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: instance, sectionNameKeyPath:nil, cacheName: nil)

    do {
      try fetchedResultController.performFetch()
      shifts = fetchedResultController.fetchedObjects as! [Shift]
      
    }
    catch let error as NSError {
      print("Could not fetch \(error), \(error.userInfo)")
    }
    
    return shifts
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
  
  func startOfMonth() -> Date {
    return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
  }
  
  func endOfMonth() -> Date {
    return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
  }
}



