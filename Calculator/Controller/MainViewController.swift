//
//  MainViewController.swift
//  Calculator
//
//  Created by Aleix Diaz Baggerman on 02/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: Variables
    private var displayViewController: DisplayViewController?
    private var buttonsViewController: ButtonsViewController?
    //MARK: Constants
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.buttonsViewController?.buttonsDelegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let displayViewController as DisplayViewController:
            self.displayViewController = displayViewController
        case let buttonsViewController as ButtonsViewController:
            self.buttonsViewController = buttonsViewController
        default:
            break
        }
    }

}

extension MainViewController: CellButtonDelegate {
    func didClickButton(type: ButtonType, content: String?) {
        guard let content = content else {return}
        switch type {
        case .C:
            self.displayViewController?.clearDisplay()
        break
        case .remove:
            self.displayViewController?.removeLastInput()
        break
        default:
            self.displayViewController?.addSymbol(symbol: content, type: type)
        }
        print(type, content)
    }
}
