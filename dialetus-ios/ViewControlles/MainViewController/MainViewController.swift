//
//  MainViewController.swift
//  dialetus-ios
//
//  Created by Felipe Antonio Cardoso on 02/03/19.
//  Copyright © 2019 Pamela Ianovalli. All rights reserved.
//

import UIKit
import JGProgressHUD

class MainViewController: UITableViewController {
    
    private lazy var searchController: UISearchController = {
        
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.placeholder = "Procurar Dialeto"
        controller.searchBar.delegate = self
        
        return controller
    }()

    
    private let hud = JGProgressHUD(style: .dark)
    private let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.regionName.capitalized
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        viewModel.delegate = self
        
        tableView.register(UINib(nibName: "CardTableViewCell", bundle: nil), forCellReuseIdentifier: "CardTableViewCell")
        tableView.tableFooterView = UIView()
        viewModel.loadDialects()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "FilterTableViewController":
            
                if
                    let navigationController = segue.destination as? UINavigationController,
                    let filterController = navigationController.viewControllers.first as?
                    FilterTableViewController
                {
                    filterController.delegate = self
                }
            
            case "DetailTableViewController":
                if
                    let detailController = segue.destination as? DetailViewController ,
                    let dialect = sender as? Dialect
                {
                    detailController.viewModel = DetailViewModel(dialect: dialect)
                }
            default:
                break
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dialects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell", for: indexPath) as? CardTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        
         let dialect = viewModel.dialects[indexPath.row]
        
        cell.setup(with: dialect)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dialect = viewModel.dialects[indexPath.row]
        self.performSegue(withIdentifier: "DetailTableViewController", sender: dialect)
    }
    
}


extension MainViewController: MainViewModelDelegate{
    
    func didReceive(error: Error) {
        DispatchQueue.main.async{
            self.hud.textLabel.text = error.localizedDescription
            self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
            self.hud.dismiss(afterDelay: 3.0)
        }
    }
    
    func willLoadData() {
        hud.position = .center
        hud.indicatorView = JGProgressHUDIndeterminateIndicatorView()
        hud.textLabel.text = "Loading..."
        hud.show(in: self.view)
        
    }
    
    func didLoadData() {
        DispatchQueue.main.async{
            
            self.hud.textLabel.text = "Success!"
            self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            self.hud.dismiss(afterDelay: 1.0)
            self.title = self.viewModel.regionName.capitalized
            self.tableView.reloadData()
        }
    }
}

extension MainViewController: FilterTableViewControllerDelegate{
    
    func controller(viewController: FilterTableViewController, didSelect region: Region) {
        
        viewModel.update(region: region)
        viewController.dismiss(animated: true) {
            self.viewModel.loadDialects()
        }
    }
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(searchText.isEmpty ? nil : searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text  = searchBar.text
        viewModel.search(text)
        searchController.isActive = false
        searchController.searchBar.text = text
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.search(nil)
    }
    
    
}
