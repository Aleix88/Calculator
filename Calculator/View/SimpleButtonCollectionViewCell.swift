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
    
    //MARK: Constants
    private let maxExteriorAlpha: CGFloat = 0.1
    private let maxInteriorAlpha: CGFloat = 0.2
    
    
    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        interiorCircleView.backgroundColor = UIColor.rgb(r: 156, g: 132, b: 214)
        exteriorCircleView.backgroundColor = UIColor.rgb(r: 156, g: 132, b: 214)
        interiorCircleView.alpha = 0
        exteriorCircleView.alpha = 0
        self.clipsToBounds = false
    }
    
    override func draw(_ rect: CGRect) {
        exteriorCircleView.layer.cornerRadius = exteriorCircleView.frame.width/2
        interiorCircleView.layer.cornerRadius = interiorCircleView.frame.width/2
        cellButton.layer.cornerRadius = cellButton.frame.width/2
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        self.cellButton.backgroundColor = .white
        let exteriorTransform = self.exteriorCircleView.transform
        let interiroTransform = self.interiorCircleView.transform
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.exteriorCircleView.alpha = self.maxExteriorAlpha
            self.exteriorCircleView.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
        }) { (_) in
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                self.exteriorCircleView.alpha = 0
            }) { (_) in
                self.exteriorCircleView.transform = exteriorTransform
            }
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
            self.interiorCircleView.alpha = self.maxInteriorAlpha
            self.interiorCircleView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)

        }) { (_) in
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                self.interiorCircleView.alpha = 0
                self.cellButton.backgroundColor = .clear
            }) { (_) in
                self.interiorCircleView.transform = interiroTransform
            }
        }
    }
    

}
