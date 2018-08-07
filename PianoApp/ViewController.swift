//
import UIKit
import AVFoundation


// TODO: Add force touch volume control
// TODO: Better piano


class ViewController: UIViewController, PianoKeyDelegate {
  
    var currentNoteView: UIView?
    let stackView = UIStackView()
    let noteBackgroundImageView = UIImageView(image: #imageLiteral(resourceName: "PianoKeysBackground").withRenderingMode(.alwaysTemplate))

    var players: [AVAudioPlayer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        becomeFirstResponder()
        
        pianoKeys.map(PianoKeyView.init).forEach {
            $0.delegate = self
            stackView.addArrangedSubview($0)
        }
        
        stackView.backgroundColor = .lightGray
        stackView.alignment = .fill
        stackView.spacing = 0.0
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        let noteCenteringGuide = UILayoutGuide()
        view.addLayoutGuide(noteCenteringGuide)
        
        noteBackgroundImageView.tintColor = .lightGray //#colorLiteral(red: 0.1254901961, green: 0.1254901961, blue: 0.1254901961, alpha: 1)
        
        [stackView, noteBackgroundImageView].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            noteCenteringGuide.bottomAnchor.constraint(equalTo: stackView.topAnchor),
            noteCenteringGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),

            noteBackgroundImageView.centerYAnchor.constraint(equalTo: noteCenteringGuide.centerYAnchor),
            noteBackgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noteBackgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            noteBackgroundImageView.heightAnchor.constraint(equalToConstant: 75.0)
        ])
    }
    
    
    func play(_ note: PianoKey) {
        guard let url = Bundle.main.url(forResource: String(note.note), withExtension: "wav") else {
            print(note)
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            let wavPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            wavPlayer.play()
            
            players.append(wavPlayer)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // lmfao
                guard let index = self.players.index(of: wavPlayer) else {
                    return
                }
                
                self.players.remove(at: index)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func didPress(_ pianoKey: PianoKey) {
        play(pianoKey)
        
        let noteView = NoteView(pianoKey: pianoKey)
        noteView.translatesAutoresizingMaskIntoConstraints = false
        
        // its a coup
        currentNoteView?.removeFromSuperview()
        currentNoteView = noteView
        view.addSubview(noteView)

        
        NSLayoutConstraint.activate([
            noteView.centerXAnchor.constraint(equalTo: noteBackgroundImageView.centerXAnchor),
            noteView.centerYAnchor.constraint(equalTo: noteBackgroundImageView.centerYAnchor),
            noteView.heightAnchor.constraint(equalTo: noteBackgroundImageView.heightAnchor, multiplier: 1.375)
        ])
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            let keyColor = UIColor.random
            
            stackView.arrangedSubviews
                .compactMap { $0 as? PianoKeyView }
                .forEach { $0.keyTintColor = keyColor }
        }
    }
}


extension UIColor {
    static var random: UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
}
