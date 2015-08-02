//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Jason Scott Timmerman on 7/25/15.
//  Copyright (c) 2015 Jason Scott Timmerman. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var filePathUrl: NSURL!
    var title: String!
    
    init(url: NSURL, tit: String) {
        filePathUrl = url
        title = tit
    }
}
