//
//  ViewController.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 30/09/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import UIKit

class ForecastViewController: UITableViewController {
    
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var temperaturesRange: UILabel!
    
    private var provider = WeatherProvider(location: "Voronezh")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

