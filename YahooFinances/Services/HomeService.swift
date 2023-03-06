//
//  HomeService.swift
//  YahooFinances
//
//  Created by Bento luiz Rodrigues filho on 02/03/23.
//

import Foundation


protocol HomeServiceProtocol {
    func fetchHomeResponse(result: @escaping (Result<[StockChartData]?, Error>) -> Void)
}

class HomeService: HomeServiceProtocol {
    func fetchHomeResponse(result: @escaping (Result<[StockChartData]?, Error>) -> Void) {
        let fromDate = Calendar.current.date(byAdding: .day, value: -30, to: Date())

        YahooFinancesProvider.chartDataBy(identifier: "AAPL", start: fromDate!, end: Date(), interval: .oneday) { data, error in
            if let error = error {
                return result(.failure(error))
            }

            if let response = data {
                
                return result(.success(response))
            }
        }
    }
}

enum PersonalizedError: Error {
    case genericError
    case invalidURL
    case network
}

