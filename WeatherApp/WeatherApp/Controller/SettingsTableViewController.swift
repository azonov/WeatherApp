//
//  SettingsTableViewController.swift
//  WeatherApp
//
//  Created by xcode on 19.11.16.
//  Copyright © 2016 VSU. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    var measureAndLocationHolder = LocationAndMeasureConfiguration();
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var measureSwitch: UISegmentedControl!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.section == 0
        {
         locationTextField.becomeFirstResponder()
        }
    }
    
    @IBAction func OnDone(_ sender: AnyObject)
    {
       let selectedPlace = locationTextField.text ?? ""
       let selectedMeasure: String? = measureSwitch.titleForSegment(at: measureSwitch.selectedSegmentIndex)
       
       measureAndLocationHolder.UpdateValues(newPlace: selectedPlace, newMeasure: selectedMeasure!)
       measureAndLocationHolder.SaveChanges()
    
       dismiss(animated: true, completion: nil)
    }
    
    func GetValueForLocation() -> String{
       return measureAndLocationHolder.getLocation()
    }
    
    func GetValueForMeasure() -> String{
        return measureAndLocationHolder.getMeasure()
    }

}
