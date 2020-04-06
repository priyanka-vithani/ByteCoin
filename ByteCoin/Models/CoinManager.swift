//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CurrencyManagerDelegate {
    func didUpdateCoinPrice(price : String, currency : String)
    func didFailWithError(error : Error)
}

struct CoinManager {
    
     var delegate : CurrencyManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "C833331C-9AD0-4B60-8560-7C9BD191AC11"
   
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    
    func getCoinPrice(for currency : String){
        let strURL = "\(baseURL)\(currency)?apikey=\(apiKey)"
   
        if let url = URL(string: strURL){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let rate = self.parseJSON(safeData){
                        let strPrice = String(format: "%.2f", rate)
                        self.delegate?.didUpdateCoinPrice(price: strPrice, currency: currency)
                    }
                    
                }
            }
            task.resume()
        }
    }
    func parseJSON(_ data :Data)->Double?{
        
     let decoder = JSONDecoder()
        do{
          let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
             return lastPrice
            
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
