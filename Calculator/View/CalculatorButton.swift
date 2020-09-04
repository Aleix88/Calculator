//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Aleix Diaz Baggerman on 03/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import UIKit
import AVFoundation

class CalculatorButton: UIButton {
    
    //MARK: Variables
    var audioPlayer: AVAudioPlayer!
    var enableInputClicksWhenVisible: Bool {
        return true
    }
    
    //MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addTarget(self, action: #selector(pressed), for: .touchUpInside)
    }
    
    @objc func pressed () {
        if let soundURL = Bundle.main.url(forResource: "keyboard_sound", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            } catch {
                print(error)
            }
            audioPlayer.play()
        }
    }
    
}
