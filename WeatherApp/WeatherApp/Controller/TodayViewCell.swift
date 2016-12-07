//
//  TodayViewCell.swift
//  WeatherApp
//
//  Created by Igor Grankin on 07.12.16.
//  Copyright © 2016 VSU. All rights reserved.
//

import UIKit

class TodayViewCell: UITableViewCell {

    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var tempDistinction: UILabel!
    @IBOutlet weak var info: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
