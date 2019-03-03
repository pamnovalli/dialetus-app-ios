//
//  MainViewModel.swift
//  dialetus-ios
//
//  Created by Felipe Antonio Cardoso on 02/03/19.
//  Copyright © 2019 Pamela Ianovalli. All rights reserved.
//

import Foundation

protocol MainViewModelDelegate: class {
    func reload()
}

class MainViewModel {
    
    
    private (set) var dialects = [Dialect]()
    
    weak var delegate: MainViewModelDelegate?
    
    func loadDialects(from region: String){
        
        DialetusManager.shared.dialects(from: region) { [weak self](dialects, error) in
            
            if let error = error {
                print("\(error)")
                return
            }
            if let dialects = dialects {
                self?.dialects = dialects
            } else {
                self?.dialects = []
            }
            
            self?.delegate?.reload()
        }
        
        
    }
    
}
