//
//  APIClient.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/08/2019.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Alamofire
import RxAlamofire
import RxSwift

public class APIClient {
    private var sessionManager: SessionManager
    
    public init() {
        sessionManager = SessionManager()
    }
    
    func request<T: Decodable>(_ urlRequest: URLRequest) -> Single<(T, HTTPURLResponse)> {
        return Single.create(subscribe: { [unowned self] (observer) -> Disposable in
            if ConnectivityManager().isConnected() {
                return self.request(urlRequest, { (response, urlResponse) in
                    observer(.success((response, urlResponse)))
                }, { (error) in
                    observer(.error(error))
                })
            } else {
                observer(.error(MindErrors.internetError))
                return Disposables.create()
            }
        })
    }
    
    func request(_ urlRequest: URLRequest) -> Single<(HTTPURLResponse)> {
        return Single.create(subscribe: { [unowned self] (observer) -> Disposable in
            if ConnectivityManager().isConnected() {
                return self.request(urlRequest, { (urlResponse) in
                    observer(.success((urlResponse)))
                }, { (error) in
                    observer(.error(error))
                })
            } else {
                observer(.error(MindErrors.internetError))
                return Disposables.create()
            }
        })
    }
    
    private func request<T: Decodable>(_ urlRequest: URLRequest,
                                       _ responseHandler: @escaping (T, HTTPURLResponse) -> Void,
                                       _ errorHandler: @escaping ((_ error: MindErrors) -> Void)) -> Disposable {
        let disposableResponse = sessionManager
            .rx
            .request(urlRequest: urlRequest)
            .responseJSON()
            .asSingle()
            .timeout(RxTimeInterval.seconds(30), scheduler: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] (response) in
                guard let self = self else { return }
                if let httpUrlResponse = response.response, 200..<300 ~= httpUrlResponse.statusCode {
                    self.decode(response, responseHandler)
                } else {
                    guard let data = response.data else { return }
                    self.decode(data, errorHandler)
                }
            })
        return disposableResponse
    }
    
    private func request(_ urlRequest: URLRequest,
                         _ responseHandler: @escaping (HTTPURLResponse) -> Void,
                         _ errorHandler: @escaping ((_ error: MindErrors) -> Void)) -> Disposable {
        let disposableResponse = sessionManager
            .rx
            .request(urlRequest: urlRequest)
            .responseData()
            .asSingle()
            .timeout(RxTimeInterval.seconds(30), scheduler: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] (httpUrlResponse, data) in
                if 200..<300 ~= httpUrlResponse.statusCode {
                    responseHandler(httpUrlResponse)
                } else {
                    guard let self = self else { return }
                    self.decode(data, errorHandler)
                }
            })
        return disposableResponse
    }
    
    private func decode(_ data: Data, _ errorHandler: ((_ error: MindErrors) -> Void)) {
        do {
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
            errorHandler(MindErrors.apiError(code: errorResponse.code,
                                           message: errorResponse.message,
                                           reason: errorResponse.reason ?? ""))
        } catch {}
    }
    
    private func decode<T: Decodable>(_ response: DataResponse<Any>,
                                      _ responseHandler: @escaping (T, HTTPURLResponse) -> Void) {
        if let jsonData = response.data, let httpUrlResponse = response.response {
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                responseHandler(try decoder.decode(T.self, from: jsonData), httpUrlResponse)
            } catch {
                print(T.self)
            }
        }
    }
}

