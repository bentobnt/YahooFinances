//
//  YFinanceResponseError.swift
//  YahooFinances
//
//  Created by Bento luiz Rodrigues filho on 03/03/23.
//

import Foundation

public struct YFinanceResponseError: Error {
    public var message: String?
}

public enum ChartTimeInterval: String {
    case oneday = "1d"

}

public struct StockChartData: Codable, Equatable {
    public static func == (lhs: StockChartData, rhs: StockChartData) -> Bool {
        return lhs.date == rhs.date
    }

    public var date: Date?
    public var open: Float?
}
