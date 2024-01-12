//
//  Person.swift
//  PickerLibrary2
//
//  Created by Yunus Can on 06/01/2024.
//
import SwiftData
import Foundation



@Model
class Person: Identifiable{

    var name : String
    var passWord : String
    
    init(name: String, passWord: String) {
        self.name = name
        self.passWord = passWord
    }
}
