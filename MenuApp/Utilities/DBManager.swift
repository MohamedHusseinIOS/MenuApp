//
//  DBManager.swift
//  pagination-demo
//
//  Created by Mohamed Hussien on 16/10/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation
import SQLite

class DBManager {
   
    static let shared = DBManager()
    private let db: Connection?
    private let dataTable = Table("AppData")
    private let Key = Expression<String>("key")
    private let Value = Expression<Data?>("value")
    
    private init() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

        do {
            self.db = try Connection("\(path)/pagination.sqlite3")
            createDataTable(dataTable: dataTable, dbConnection: db)
        } catch {
            self.db = nil
            print("Unable to open database")
        }
    }
    
    func createDataTable(dataTable:Table, dbConnection: Connection?) {
        do {
            try db?.run(dataTable.create(temporary: false, ifNotExists: true, withoutRowid: true, block: { (table) in
                table.column(Key, primaryKey: true)
                table.column(Value)
            }))
        } catch let error{
            print(error)
        }
    }
    
    func insert(value: Data?, forKey key: String){
        let insert = dataTable.insert(Key <- key, Value <- value)
        do{
            try db?.run(insert)
        } catch let error{
            print(error)
        }
    }
    
    func update(value: Data?, forKey key: String){
        let obj = dataTable.filter(Key == key)
        let update = obj.update(Value <- value)
        do{
            try db?.run(update)
        } catch let error{
            print(error)
        }
    }
    
    func deleteValueFor(key: String){
        let obj = dataTable.filter(Key == key)
        do{
            try db?.run(obj.delete())
        } catch let error{
            print(error)
        }
    }
    
    func getValueBy(key: String) -> Data{
        let obj = dataTable.filter(Key == key)
        do{
            for objRow in try db!.prepare(obj) {
                return objRow[Value] ?? Data("".utf8)
            }
        }catch let error{
            print(error)
        }
        return Data("".utf8)
    }
}
