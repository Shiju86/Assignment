//
//  ViewController.swift
//  Tricog-Wikipedia-Example
//
//  Created by Shiju Varghese on 07/08/18.
//  Copyright © 2018 Shiju. All rights reserved.
//

import UIKit
import Alamofire

class WikipediaVC: UIViewController {
    
    //MARK: -IBOutlet
    @IBOutlet weak var txtFieldSearchUser: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelNoResult: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - constant & property
    private var arraySearchResult = [WikipediaModel]()
    private var arrayLocalSearch = [WikipediaModel]() // update search

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        setUpSearchBar()
    }
  
    //MARK: - SetUp Search Bar
    private func setUpSearchBar() {
        searchBar.delegate = self
        // search bar in navigation bar
        //navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
        //navigationItem.titleView = searchBar
        searchBar.showsScopeBar = false // you can show/hide this dependant on your layout
        searchBar.placeholder = "Search within the application"
    }
    
    //MARK: - SetUp TableView
    private func setUpTableView() {
     
        tableView.estimatedSectionHeaderHeight = 0
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
}

//MARK:- IBActions

extension WikipediaVC {
    
    @IBAction func tapGestureAction(_ sender: Any) {
        
        self.view.endEditing(true)
    }
    //MARK: - Submit Search Result
    @IBAction func submitAction(_ sender: Any) {
        
        guard txtFieldSearchUser.text != "" else {
            
            self.singleButtonAlertWith(message: Messages.enterSearchText, button: AlertButtonTitle.ok)
            return
        }
        
        guard !txtFieldSearchUser.isBlank else {
            self.singleButtonAlertWith(message: Messages.enterSearchText, button: AlertButtonTitle.ok)
            
            return
        }
        
        if let formattedString = txtFieldSearchUser.text?.replacingOccurrences(of: " ", with: "+") {
            
            self.view.endEditing(true)
            
            self.arraySearchResult.removeAll()
            
            tableView.reloadTableData()
            
            getWikipediaSearchResultWebservice(searchUser: formattedString, pageLimit: 50) { (searchResult) in
                
                self.arraySearchResult = searchResult
                self.arrayLocalSearch = self.arraySearchResult
                self.labelNoResult.isHidden = self.arrayLocalSearch.count > 0 ? true : false
                
               self.tableView.reloadTableData()
                
            }
        }
    }
}

//MARK:- TableView Delegate & DataSource
extension WikipediaVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return arrayLocalSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WikipediaSearchTableCell.identifier) as? WikipediaSearchTableCell  else { return UITableViewCell()}
        cell.selectionStyle = .none

        if arrayLocalSearch.count > 0  {
            cell.searchResultModel =  arrayLocalSearch[indexPath.row]
        }
        
        return cell
    }
}

//MARK: Search Bar Delegate
extension WikipediaVC: UISearchBarDelegate {
    
    // This two functions can be used if you want to show the search bar in the section header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            return searchBar
       
    }
    // search bar in section header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return UITableViewAutomaticDimension
       
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        arrayLocalSearch = arraySearchResult.filter({ result -> Bool in
            
            if searchText.isEmpty { return true }
            return result.title!.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }    
}










