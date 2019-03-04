//
//  MainViewModel.swift
//  dialetus-ios
//
//  Created by Felipe Antonio Cardoso on 02/03/19.
//  Copyright © 2019 Pamela Ianovalli. All rights reserved.
//

import Foundation

protocol MainViewModelDelegate: class {
    func willLoadData()
    func didLoadData()
    func didReceive(error: Error)
}

class MainViewModel {
    
    private (set) var regionName: String = "paulistes"
    
    private var original = [Dialect]()
    private var searchText: String?
    
    var dialects: [Dialect] {
        
        guard let searchText = self.searchText else {
            return original
        }
        
        let searchResult = original.filter({ (dialect) -> Bool in
            return dialect.dialect.lowercased().contains(searchText.lowercased())
        })
        
        return searchResult
    }
    
    
    weak var delegate: MainViewModelDelegate?
    
    func update(region: Region){
        
        self.regionName = region.name
    }
    
    func loadDialects(){
        
        delegate?.willLoadData()
        
        DialetusManager.shared.dialects(from: regionName) { [weak self](dialects, error) in
            
            if let error = error {
                self?.delegate?.didReceive(error: error)
                return
            }
            if let dialects = dialects {
                self?.original = dialects
            } else {
                self?.original = []
            }
            
            self?.delegate?.didLoadData()
        }
        
        
    }
    
    func search(_ text: String?) {
        self.searchText = text
        self.delegate?.didLoadData()
        
    }
    
}
