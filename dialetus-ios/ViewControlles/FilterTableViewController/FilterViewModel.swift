//
//  FilterViewModel.swift
//  dialetus-ios
//
//  Created by Felipe Antonio Cardoso on 02/03/19.
//  Copyright © 2019 Pamela Ianovalli. All rights reserved.
//

import Foundation

protocol FilterViewModelDelegate: class {
    func willStartLoadRegions()
    func didFinishLoadRegions()
}

class FilterViewModel{
    
    private (set) var regions = [Region]()
    
    weak var delegate: FilterViewModelDelegate?
    
    func loadRegions() {
        
        delegate?.willStartLoadRegions()
        DialetusManager.shared.regions { (regions, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let regions = regions {
                self.regions = regions
            } else {
                self.regions = []
            }
            
            self.delegate?.didFinishLoadRegions()
        }
        
    }
}
