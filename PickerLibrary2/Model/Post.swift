//
//  Post.swift
//  PickerLibrary2
//
//  Created by Yunus Can on 08/01/2024.
//

import Foundation
import SwiftData
import PhotosUI

@Model
class Post{
    var title : String
    var subTitle : String
    var date : Date
    var image : Data?
    
    init(title: String, subTitle: String, date: Date, image: Data? = nil) {
        self.title = title
        self.subTitle = subTitle
        self.date = date
        self.image = image
    }
    
}
