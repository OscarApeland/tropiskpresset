//
//  Key.swift
//  PianoApp
//
//  Created by Oscar Apeland on 06/08/2018.
//  Copyright © 2018 OleR. All rights reserved.
//

import UIKit

enum TangentSide {
    case none, right, left, both
}

struct PianoKey {
    let name: String
    let note: Int
    
    let tangent: TangentSide
    
    
    // maarhk; supr serius bzns stuffh
    
    var isPiercedBoob: Bool {
        return note == 12
    }
    
    /// AKA Upside down, stem on left side
    var isRightBoobed: Bool {
        return note < 8
    }
    
    /// AKA Right way, stem on right side
    var isLeftBoobed: Bool {
        return !isRightBoobed
    }
    
    // TODO: var isBoobBoobed: Bool { }
    // TODO: var isHashtagged: Bool { }
}

let pianoKeys = [
    PianoKey(name: "C", note: 12, tangent: .right),
    PianoKey(name: "D", note: 11, tangent: .both),
    PianoKey(name: "E", note: 10, tangent: .left),
    PianoKey(name: "F", note: 9,  tangent: .right),
    PianoKey(name: "G", note: 8,  tangent: .both),
    
    PianoKey(name: "A", note: 7,  tangent: .both),
    PianoKey(name: "B", note: 6,  tangent: .left),
    PianoKey(name: "C", note: 5,  tangent: .right),
    PianoKey(name: "D", note: 4,  tangent: .both),
    PianoKey(name: "E", note: 3,  tangent: .left),
    PianoKey(name: "F", note: 2,  tangent: .right),
    PianoKey(name: "G", note: 1,  tangent: .both),
]
