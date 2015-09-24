//
//  Portrait.swift
//  iGuessPortraits
//
//  Created by Brad on 27/02/2015.
//  Copyright (c) 2015 iOSDevCamp. All rights reserved.
//

import Foundation

class Portrait {
    var title: String!
    var imageUrl: String!
    
    init (title: String, imageUrl: String) {
        self.title = title
        self.imageUrl = imageUrl
    }
}