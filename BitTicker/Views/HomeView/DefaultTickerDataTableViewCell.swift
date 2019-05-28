//
//  DefaultTickerDataTableViewCell.swift
//  BitTicker
//
//  Created by Thafer Shahin on 5/28/19.
//  Copyright © 2019 Thafer Shahin. All rights reserved.
//

import UIKit

/// <#Description#>
class DefaultTickerDataTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var arrowIV: UIImageView!
    
    @IBOutlet weak var currencyPairLbl: UILabel!
    
    @IBOutlet weak var lastPriceLbl: UILabel!
    
    @IBOutlet weak var lowestAskLbl: UILabel!
    
    @IBOutlet weak var heighestBid: UILabel!
    
    // MARK: - DefaultTickerDataTableViewCell
    
    func configureWithTickerData(tickerData : TickerData, comparePrice : Double) {
        self.currencyPairLbl.text = CurrencyPairID.pairs[tickerData.pairId]
        
        // Highlight UI according to compare price and last trade price.
        guard let lastPrice = tickerData.lastTradePrice else {
            self.resetTickerUI()
            return
        }
        
        if lastPrice > comparePrice {
            // Show up arrow and color last price with green.
            self.arrowIV.image = #imageLiteral(resourceName: "UpArrow.pdf")
            self.lastPriceLbl.textColor = UIColor.tickerGreen
        } else if lastPrice < comparePrice {
            // Show down arrow and color last price with red.
            self.arrowIV.image = #imageLiteral(resourceName: "DownArrow.pdf")
            self.lastPriceLbl.textColor = UIColor.tickerRed
        } else {
            // If they are equal, hide the arrow and color last price with black.
            self.arrowIV.image = nil
            self.lastPriceLbl.textColor = UIColor.black
        }
        
        self.lastPriceLbl.text = lastPrice.tickerFormattesString()
        self.lowestAskLbl.text = tickerData.lowestAsk.tickerFormattesString()
        self.heighestBid.text = tickerData.highestBid.tickerFormattesString()
    }
    
    /// Reset all UI to default or empty except currency pair label.
    func resetTickerUI() {
        self.arrowIV.image = nil
        self.lastPriceLbl.text = ""
        self.lowestAskLbl.text = ""
        self.heighestBid.text = ""
    }
    
    // MARK: - UITableViewCell
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
