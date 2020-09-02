//
//  SimpleButtonCollectionViewCell.swift
//  Calculator
//
//  Created by Aleix Diaz Baggerman on 02/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import UIKit

class SimpleButtonCollectionViewCell: UICollectionViewCell {

    static let ID = "SimpleButtonCollectionViewCell"
    
    //MARK: Variables
    @IBOutlet weak private var interiorCircleView: UIView!
    @IBOutlet weak private var exteriorCircleView: UIView!
    @IBOutlet weak private var cellButton: UIButton!
    
    var content: ButtonContent? {
        didSet {
            prepareContent()
        }
    }
    
    //MARK: Constants
    private let maxExteriorAlpha: CGFloat = 0.1
    private let maxInteriorAlpha: CGFloat = 0.2
    
    
    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCircles()
    }
    
    override func draw(_ rect: CGRect) {
        exteriorCircleView.layer.cornerRadius = exteriorCircleView.frame.width/2
        interiorCircleView.layer.cornerRadius = interiorCircleView.frame.width/2
        cellButton.layer.cornerRadius = cellButton.frame.width/2
    }
    
    private func prepareContent() {
        guard let content = self.content else { return }
        self.cellButton.setTitle(content.content, for: .normal)
        let prepareHandlers = [
            ButtonType.number:prepareNumber,
            .equal:prepareEqual,
        ]
        guard let handler = prepareHandlers[content.type] else {
            prepareSpecialButton()
            return
        }
        handler()
    }
    
    private func prepareNumber() {
        self.cellButton.setTitleColor(.black, for: .normal)
    }
    
    private func prepareSpecialButton() {
        self.cellButton.setTitleColor(.purple, for: .normal)
    }
    
    private func prepareEqual() {
        self.cellButton.backgroundColor = .purple
        self.cellButton.setTitleColor(.white, for: .normal)
    }
    
    private func setupCircles() {
        interiorCircleView.backgroundColor = UIColor.rgb(r: 156, g: 132, b: 214)
        exteriorCircleView.backgroundColor = UIColor.rgb(r: 156, g: 132, b: 214)
        interiorCircleView.alpha = 0
        exteriorCircleView.alpha = 0
        self.clipsToBounds = false
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        guard content?.type != .empty else {return}
        if (content?.type != .equal) {
            self.cellButton.backgroundColor = .white
        }
        let exteriorTransform = self.exteriorCircleView.transform
        let interiroTransform = self.interiorCircleView.transform
        
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseOut, animations: {
            self.exteriorCircleView.alpha = self.maxExteriorAlpha
            self.exteriorCircleView.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
        }) { (_) in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
                self.exteriorCircleView.alpha = 0
            }) { (_) in
                self.exteriorCircleView.transform = exteriorTransform
            }
        }
        
        UIView.animate(withDuration: 0.15, delay: 0.05, options: .curveEaseOut, animations: {
            self.interiorCircleView.alpha = self.maxInteriorAlpha
            self.interiorCircleView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)

        }) { (_) in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
                self.interiorCircleView.alpha = 0
                if (self.content?.type != .equal) {
                    self.cellButton.backgroundColor = .clear
                }
            }) { (_) in
                self.interiorCircleView.transform = interiroTransform
            }
        }
    }
    

}
