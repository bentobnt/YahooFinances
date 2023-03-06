//
//  YahooFinancesProvider.swift
//  YahooFinances
//
//  Created by Bento luiz Rodrigues filho on 03/03/23.
//

import Alamofire
import Foundation
import SwiftyJSON

public class YahooFinancesProvider {
    /**
     The counter of requests. This parameter is added to the urls to change them as, sometimes, caching of content does a bad thing.
     By changing url with this parameter, the app expects uncached response.
     */
    static var cacheCounter: Int = 0

    /**
     The headers to use in all requests
     */
    static var headers: HTTPHeaders = [
        "Accept": "*/*",
        "Pragma": "no-cache",
        "Origin": "https://finance.yahoo.com",
        "Cache-Control": "no-cache",
        "Host": "query2.finance.yahoo.com",
        "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1.2 Safari/605.1.15",
        "Accept-Encoding": "gzip, deflate, br"
    ]

    /**
     Session to use in all requests.
     - Note: it is crucial as without httpShouldSetCookies parameter, sometemes, Yahoo sends invalid cookies that are saved. Then, all consequent requests corrupt.
     */
    static var session: Session = {
        let configuration = Session.default.sessionConfiguration
        //        configuration.waitsForConnectivity = false
        configuration.httpShouldSetCookies = false
        configuration.requestCachePolicy = .reloadIgnoringCacheData

        configuration.httpCookieStorage?.cookieAcceptPolicy = .always

        return Session(configuration: configuration)
    }()

    /**
     Fetches chart data points
     - Warning:
     * Identifier must exist or data will be nil and error will be setten
     * When you select minute – day interval, you can't get historicaly old points. Select oneday interval if you want to fetch maximum available number of points.
     - Parameters:
     - identifier: Name of identifier
     - start: `Date` type start of points retrieve
     - end: `Date` type end of points retrieve
     - interval: interval between points
     - queue: queue to use for request asyncgtonous processing
     - callback: callback, two parameters will be passed
     */
    public class func chartDataBy(identifier: String, start: Date = Date(), end: Date = Date(), interval: ChartTimeInterval = .oneday, queue: DispatchQueue = .main, callback: @escaping ([StockChartData]?, Error?) -> Void) {
        if identifier.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            callback(nil, YFinanceResponseError(message: "Empty identifier"))
            return
        }

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "query2.finance.yahoo.com"
        urlComponents.path = "/v8/finance/chart/\(identifier)"
        Self.cacheCounter += 1
        urlComponents.queryItems = [
            URLQueryItem(name: "symbols", value: identifier),
            URLQueryItem(name: "symbol", value: identifier),
            URLQueryItem(name: "period1", value: String(Int(start.timeIntervalSince1970))),
            URLQueryItem(name: "period2", value: String(Int(end.timeIntervalSince1970))),
            URLQueryItem(name: "interval", value: interval.rawValue),
            URLQueryItem(name: "includePrePost", value: "true"),
            URLQueryItem(name: "cachecounter", value: String(Self.cacheCounter))
        ]

        print(try! urlComponents.asURL())

        session.request(urlComponents, headers: Self.headers).responseData(queue: queue) { response in
            if response.error != nil {
                callback(nil, response.error)
                return
            }
            let json = try! JSON(data: response.value!)

            if json["chart"]["error"]["description"].string != nil {
                callback(nil, YFinanceResponseError(message: json["chart"]["error"]["description"].string))
                return
            }
            if json["finance"]["error"]["description"].string != nil {
                callback(nil, YFinanceResponseError(message: json["error"].string))
                return
            }

            let fullData = json["chart"]["result"][0].dictionary
            let quote = fullData?["indicators"]?["quote"][0].dictionary
            let timestamps = fullData?["timestamp"]?.array

            var result: [StockChartData] = []

            if timestamps == nil {
                callback([], YFinanceResponseError(message: "Empty chart data"))
                return
            }
            for reading in 0..<timestamps!.count {
                result.append(StockChartData(
                                date: Date(timeIntervalSince1970: Double(timestamps![reading].float!)),
                                open: quote?["open"]?[reading].float)
                )
            }
            callback(result, nil)
        }
    }
}

