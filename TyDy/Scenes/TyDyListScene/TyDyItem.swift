//
//  TyDyItem.swift
//  TyDy
//
//  Created by Mac on 27/02/2019.
//  Copyright © 2019 Lammax. All rights reserved.
//

import Foundation

class TyDyItem {
    var title: String = ""
    var done: Bool = false
    
    init(title: String, done: Bool) {
        self.title = title
        self.done = done
    }
}
