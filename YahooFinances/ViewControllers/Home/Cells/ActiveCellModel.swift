//
//  ActiveCellModel.swift
//  YahooFinances
//
//  Created by Bento luiz Rodrigues filho on 03/03/23.
//

import Foundation

class ActiveCellModel {
    // MARK: - Properties
    private let active: StockChartData
    private let firstDateActive: StockChartData
    private let dayAgoActive: StockChartData?

    // MARK: - Init
    init(active: StockChartData,
         firstDateActive: StockChartData,
         dayAgoActive: StockChartData?) {
        self.active = active
        self.firstDateActive = firstDateActive
        self.dayAgoActive = dayAgoActive
    }
}

extension ActiveCellModel {
    var data: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        return dateFormatter.string(from: active.date ?? Date())
    }

    var openValue: String {
        return String(format: "R$ %@", String(format: "%.2f", active.open ?? 0))
    }

    var variationD1: String {
        if let dayAgo = dayAgoActive {
            let doubleDayAgoActiveOpen = Double(dayAgo.open ?? 0)
            let doubleActiveOpen = Double(active.open ?? 0)
            let numbers: [Double] = [doubleDayAgoActiveOpen, doubleActiveOpen]
            let percentageDifference = numbers.percentageDifference
            return dayAgo == active ? "-" : String(format: "%.2f", percentageDifference[1]) + "%"
        }
        return "-"
    }

    var variationFirstDate: String {
        let doubleFirstActiveOpen = Double(firstDateActive.open ?? 0)
        let doubleActiveOpen = Double(active.open ?? 0)
        let numbers: [Double] = [doubleFirstActiveOpen, doubleActiveOpen]
        let percentageDifference = numbers.percentageDifference
        return firstDateActive == active ? "-" : String(format: "%.2f", percentageDifference[1]) + "%"
    }
}

extension Collection where Element: FloatingPoint {
    var percentageDifference: [Element] {
        guard var last = first else { return [] }
        return map { element in
            defer { last = element }
            return (element - last) / last * 100
        }
    }
}
