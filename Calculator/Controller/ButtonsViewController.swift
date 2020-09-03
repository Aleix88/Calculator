//
//  ButtonsViewController.swift
//  Calculator
//
//  Created by Aleix Diaz Baggerman on 02/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import UIKit

class ButtonsViewController: UIViewController {

    //MARK: Variables
    @IBOutlet weak private var collectionView: UICollectionView!
    
    var buttonsDelegate: CellButtonDelegate?
    
    //MARK: Constants
    private let buttonsPerRow = 4
    private let nRows = 5
    
    //MARK: Lyfe Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: SimpleButtonCollectionViewCell.ID, bundle: nil), forCellWithReuseIdentifier: SimpleButtonCollectionViewCell.ID)
        collectionView.delegate = self
        collectionView.bounces = false
        collectionView.clipsToBounds = false
    }

}

extension ButtonsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nRows * buttonsPerRow
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimpleButtonCollectionViewCell.ID, for: indexPath) as! SimpleButtonCollectionViewCell
        let provider = ButtonsProvider()
        cell.content = provider.buttonAt(indexPath)
        cell.delegate = self.buttonsDelegate
        return cell
    }
}

extension ButtonsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.collectionView.frame.width / CGFloat(buttonsPerRow)
        let height = self.collectionView.frame.height / CGFloat(nRows)
        let size = CGSize(width: width, height: height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

