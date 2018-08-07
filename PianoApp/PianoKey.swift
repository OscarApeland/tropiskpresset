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

struct Key {
    let name: String
    let noteImage: UIImage
    let tangent: TangentSide
}
