//
//  HomeViewModel.swift
//  YahooFinances
//
//  Created by Bento luiz Rodrigues filho on 02/03/23.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func didFetchDataWithSuccess()
    func didFetchDataWithError(error: String)
}

class HomeViewModel {
    // MARK: - Properties
    let service: HomeServiceProtocol
    var response: [StockChartData]?

    // MARK: - delegate
    weak var delegate: HomeViewModelDelegate?

    // MARK: - Closures
    var isLoading: (Bool) -> Void = {_ in }

    // MARK: - Init method
    init(service: HomeServiceProtocol) {
        self.service = service
    }

    // MARK: - Public methods
    func fetchData() {
        isLoading(true)
        service.fetchHomeResponse { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.isLoading(false)
                self.response = response
                self.sendDataToFlutter()
                self.delegate?.didFetchDataWithSuccess()
            case .failure(let error):
                self.isLoading(false)
                self.delegate?.didFetchDataWithError(error: error.localizedDescription)
            }
        }
    }

    func getDataToSendToFlutter() -> [[String: Any]] {
        var arrayDictionary: [[String: Any]] = []
        response?.forEach({ stockChart in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/YYYY"
            let stringDate = dateFormatter.string(from: stockChart.date ?? Date())
            let stringOpenValue = String(format: "%.2f", stockChart.open ?? 0)
            let dictionary: [String: Any] = ["open": stringOpenValue,// stockChart.open,
                                             "date": stringDate]//stockChart.date]
            arrayDictionary.append(dictionary)
        })

        return arrayDictionary
    }

    // MARK: - Private methods
    private func sendDataToFlutter() {
        var arrayDictionary: [[String: Any]] = []
        response?.forEach({ stockChart in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/YYYY"
            let stringDate = dateFormatter.string(from: stockChart.date ?? Date())
            let stringOpenValue = String(format: "%.2f", stockChart.open ?? 0)
            let dictionary: [String: Any] = ["open": stringOpenValue,// stockChart.open,
                                             "date": stringDate]//stockChart.date]
            arrayDictionary.append(dictionary)
        })

        FlutterManager.sharedInstance.invokeMethodSendDataToFlutter(json: arrayDictionary)
    }
}

