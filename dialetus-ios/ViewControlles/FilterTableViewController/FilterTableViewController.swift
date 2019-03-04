//
//  FilterTableViewController.swift
//  dialetus-ios
//
//  Created by Felipe Antonio Cardoso on 02/03/19.
//  Copyright © 2019 Pamela Ianovalli. All rights reserved.
//

import UIKit
import JGProgressHUD

protocol FilterTableViewControllerDelegate: class {
    
    func controller(viewController: FilterTableViewController, didSelect region: Region)
    
}

class FilterTableViewController: UITableViewController {
    
    private let hud = JGProgressHUD(style: .dark)
    
    private let viewModel = FilterViewModel()

    @IBOutlet weak var btnCancel: UIBarButtonItem!
    
    weak var delegate: FilterTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Available Regions"
        
        tableView.register(UINib(nibName: "RegionTableViewCell", bundle: nil), forCellReuseIdentifier: "RegionTableViewCell")
        tableView.tableFooterView = UIView()
        viewModel.delegate = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadRegions()
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.regions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RegionTableViewCell", for: indexPath) as? RegionTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        let region = viewModel.regions[indexPath.row]
        
        cell.textLabel?.text = "\(region.name) (\(region.total))"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let region =  viewModel.regions[indexPath.row]
        self.delegate?.controller(viewController: self, didSelect: region)
        
    }
}

extension FilterTableViewController: FilterViewModelDelegate {
    
    func willStartLoadRegions() {
        hud.textLabel.text = "Loading..."
        hud.show(in: self.view)
        
    }
    
    func didFinishLoadRegions() {
        DispatchQueue.main.async {
            self.hud.dismiss(afterDelay: 0.3)
            self.tableView.reloadData()
        }
    }
    
    
    
}
