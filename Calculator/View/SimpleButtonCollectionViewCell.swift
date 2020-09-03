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
    @IBOutlet weak private var cellButton: CalculatorButton!
    
    var content: ButtonContent? {
        didSet {
            prepareContent()
        }
    }
    
    var delegate: CellButtonDelegate?
    
    //MARK: Constants
    private let maxExteriorAlpha: CGFloat = 0.1
    private let maxInteriorAlpha: CGFloat = 0.2
    
    
    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCircles()
        setupButton()
    }
    
    override func draw(_ rect: CGRect) {
        exteriorCircleView.layer.cornerRadius = exteriorCircleView.frame.width/2
        interiorCircleView.layer.cornerRadius = interiorCircleView.frame.width/2
        cellButton.layer.cornerRadius = cellButton.frame.width/2
    }
    
    private func prepareContent() {
        guard let content = self.content else { return }
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
        self.cellButton.setTitleColor(.darkGray, for: .normal)
        self.cellButton.setTitle(content?.content ?? "", for: .normal)
    }
    
    private func prepareSpecialButton() {
        if let imageName = content?.imageName {
            self.cellButton.setImage(UIImage(named: imageName), for: .normal)
            let insets = self.cellButton.frame.width * 0.15
            self.cellButton.imageEdgeInsets = UIEdgeInsets(top: insets, left: insets, bottom: insets, right: insets)
            self.cellButton.setTitle("", for: .normal)

        } else {
            self.cellButton.setTitle(self.content?.content ?? "", for: .normal)
        }
        self.cellButton.tintColor = UIColor.rgb(r: 0, g: 112, b: 248)
        self.cellButton.setTitleColor(UIColor.rgb(r: 0, g: 112, b: 248), for: .normal)
    }
    
    private func prepareEqual() {
        if let imageName = content?.imageName {
            self.cellButton.setImage(UIImage(named: imageName), for: .normal)
            let insets = self.cellButton.frame.width * 0.15
            self.cellButton.imageEdgeInsets = UIEdgeInsets(top: insets, left: insets, bottom: insets, right: insets)
            self.cellButton.setTitle("", for: .normal)
        }
        self.cellButton.backgroundColor = UIColor.rgb(r: 0, g: 112, b: 248)
        self.cellButton.tintColor = .white
    }
    
    private func setupButton() {
        cellButton.titleLabel?.font = UIFont(name: "Avenir Next", size: 30)
        cellButton.titleLabel?.minimumScaleFactor = 0.1
        cellButton.titleLabel?.numberOfLines = 1
        cellButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    private func setupCircles() {
        interiorCircleView.backgroundColor = UIColor.rgb(r: 0, g: 112, b: 248)
        exteriorCircleView.backgroundColor = UIColor.rgb(r: 0, g: 112, b: 248)
        interiorCircleView.alpha = 0
        exteriorCircleView.alpha = 0
        self.clipsToBounds = false
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        guard content?.type != .empty else {return}

        delegate?.didClickButton(type: content!.type, content: content?.content)
        
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
