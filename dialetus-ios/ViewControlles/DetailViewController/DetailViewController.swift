//
//  DetailViewController.swift
//  dialetus-ios
//
//  Created by Felipe Antonio Cardoso on 02/03/19.
//  Copyright © 2019 Pamela Ianovalli. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    var viewModel: DetailViewModel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Example"

        tableView.register(UINib(nibName: "ExampleTableViewCell", bundle: nil), forCellReuseIdentifier: "ExampleTableViewCell")
    
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 80
        tableView.tableFooterView = UIView()
    }
    
     override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.examples.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExampleTableViewCell", for: indexPath) as? ExampleTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        
        cell.textLabel?.text = viewModel.examples[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0:
            
            guard let view = Bundle.main.loadNibNamed("DialectView", owner: self, options: nil)?.first as? DialectView else {
                return nil
            }
            view.config(with: viewModel.dialect)
            return view
            
        default:
            return nil
        }
    }
    
    
}
