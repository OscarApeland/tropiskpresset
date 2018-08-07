//
//  NoteView.swift
//  PianoApp
//
//  Created by Oscar Apeland on 06/08/2018.
//  Copyright © 2018 OleR. All rights reserved.
//

import UIKit

protocol PianoKeyDelegate: class {
    func didPress(_ pianoKey: PianoKey)
}

class PianoKeyView: UIControl {
    
    let pianoKey: PianoKey
    
    weak var delegate: PianoKeyDelegate?
    
    init(pianoKey: PianoKey) {
        self.pianoKey = pianoKey
        
        super.init(frame: .zero)
        
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.0
        layer.masksToBounds = true
        
        [.touchDown].forEach {
            addTarget(self, action: #selector(didTouchDown), for: $0)
        }
        
        [.touchUpInside, .touchCancel, .touchDragExit].forEach {
            addTarget(self, action: #selector(didReleaseInside), for: $0)
        }

        
        // Tangents
        
        let leftTangent = UIView()
        let rightTangent = UIView()

        
        [leftTangent, rightTangent].forEach {
            $0.isUserInteractionEnabled = false
            
            $0.layer.masksToBounds = true
            $0.backgroundColor = .black
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        leftTangent.isHidden = [.right, .none].contains(pianoKey.tangent)
        rightTangent.isHidden = [.left, .none].contains(pianoKey.tangent)
        
        
        // Label
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .regular)
        label.textColor = UIColor.black.withAlphaComponent(0.8)
        label.text = pianoKey.name
        label.textAlignment = .center
        label.isUserInteractionEnabled = false
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        NSLayoutConstraint.activate([
            leftTangent.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45),
            leftTangent.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -5),
            leftTangent.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            leftTangent.topAnchor.constraint(equalTo: topAnchor),
            
            rightTangent.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45),
            rightTangent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5),
            rightTangent.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            rightTangent.topAnchor.constraint(equalTo: topAnchor),
            
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didReleaseInside(_: UIControl) {
        backgroundColor = .white
        delegate?.didPress(pianoKey)
    }
    
    var keyTintColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    
    @objc func didTouchDown(_: UIControl) {
        backgroundColor = keyTintColor
    }
}

