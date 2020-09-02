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
    
    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func draw(_ rect: CGRect) {
        exteriorCircleView.layer.cornerRadius = exteriorCircleView.frame.width/2
        interiorCircleView.layer.cornerRadius = interiorCircleView.frame.width/2
        cellButton.layer.cornerRadius = cellButton.frame.width/2
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        print("Ei")
    }
    

}
