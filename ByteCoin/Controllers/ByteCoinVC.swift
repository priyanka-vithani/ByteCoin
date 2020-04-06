//
//  ByteCoinVC.swift
//  ByteCoin
//
//  Created by Apple on 05/04/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class ByteCoinVC: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var lblBitCoin: UILabel!
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    //MARK: - Constants
    var coinManager = CoinManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
}
//MARK: - CurrencyManagerDelegate
extension ByteCoinVC : CurrencyManagerDelegate{
    func didUpdateCoinPrice(price: String, currency: String) {
        DispatchQueue.main.async {
            self.lblCurrency.text = price
            self.lblBitCoin.text = currency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - UIPickerview datasource


extension ByteCoinVC : UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        coinManager.currencyArray.count
        
    }
    
    
}

//MARK: - UIPickerview Delegate

extension ByteCoinVC : UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.getCoinPrice(for: coinManager.currencyArray[row]
        )
    }
}
