//
//  AFRequest+DebugLog.swift
//  TVShowApp
//
//  Created by Alexandre Thadeu  on 19/05/22.
//

import Foundation
import Alamofire

let sessionManager: Session = {
    let configuration = URLSessionConfiguration.af.default
    configuration.timeoutIntervalForRequest = 30

    return Session(configuration: configuration,
                   eventMonitors: [AlamofireLogger()]
    )
}()


final class AlamofireLogger: EventMonitor {
    func requestDidResume(_ request: Request) {
        let body = request.request.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "None"
        let message = """
        ⚡️ Request Started: \(request)
        ⚡️ Body Data: \(body)
        """
        NSLog(message)
    }

    func request<Value>(_ request: DataRequest, didParseResponse response: AFDataResponse<Value>) {
        NSLog("⚡️ Response Received: \(response.debugDescription)")
    }
}
