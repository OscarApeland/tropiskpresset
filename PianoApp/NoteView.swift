//
//  NoteView.swift
//  PianoApp
//
//  Created by Oscar Apeland on 07/08/2018.
//  Copyright © 2018 OleR. All rights reserved.
//

import UIKit

class NoteView: UIView {
    
    init(pianoKey: PianoKey) {
        super.init(frame: .zero)
        
        let noteView = UIImageView(image: pianoKey.isLeftBoobed ? #imageLiteral(resourceName: "leftboob") : #imageLiteral(resourceName: "rightboob"))
        // TODO: Piercing
        
        [noteView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        let spacerGuide = UILayoutGuide()
        addLayoutGuide(spacerGuide)
        
        let lineGuide = UILayoutGuide()
        addLayoutGuide(lineGuide)
        
        NSLayoutConstraint.activate([
            lineGuide.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1 / 12),
            
            spacerGuide.topAnchor.constraint(equalTo: topAnchor),
            spacerGuide.heightAnchor.constraint(equalTo: lineGuide.heightAnchor, multiplier: CGFloat(pianoKey.note)),

            (pianoKey.isLeftBoobed ? noteView.bottomAnchor : noteView.topAnchor)
                .constraint(equalTo: spacerGuide.bottomAnchor),
            noteView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noteView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 3.5 / 12)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
}
