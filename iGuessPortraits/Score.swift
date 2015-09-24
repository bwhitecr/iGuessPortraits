//
//  Score.swift
//  iGuessPortraits
//
//  Created by Brad on 27/02/2015.
//  Copyright (c) 2015 iOSDevCamp. All rights reserved.
//

import Foundation

class Score {
    var Name: String?
    var BestScore: Int = 0
    
    init (name: String) {
        self.Name = name
    }
}
