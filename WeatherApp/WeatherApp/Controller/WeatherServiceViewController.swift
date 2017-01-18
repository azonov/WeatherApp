//
//  WeatherSourceViewController.swift
//  WeatherApp
//
//  Created by Vladimir Orlov on 17.01.17.
//  Copyright © 2017 VSU. All rights reserved.
//

import UIKit

class WeatherSourceViewController: UITableViewController {
    
    @IBOutlet var sourceTableView: UITableView!
    
    var services = [SupportedServices]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sourceTableView.delegate = self
        sourceTableView.dataSource = self
        self.getAllServices()
    }
    
    private func getAllServices() {
        for service in SupportedServices.allValues {
            services.append(SupportedServices(rawValue: service.rawValue)!)
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = services[indexPath.row].rawValue
        cell.accessoryType = .none
        if cell.textLabel?.text == currentService.rawValue {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let chosenService = tableView.cellForRow(at: indexPath)! as UITableViewCell
        let text = chosenService.textLabel?.text
        
        for service in SupportedServices.allValues {
            if text == service.rawValue {
                currentService = service
            }
        }
        chosenService.accessoryType = .checkmark
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
}
