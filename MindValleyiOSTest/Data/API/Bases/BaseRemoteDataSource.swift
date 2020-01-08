//
//  BaseRemoteDataSource.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/08/2019.
//  Copyright © 2019 MindValley. All rights reserved.
//

import RxSwift

class BaseRemoteDataSource {
    private let api: APIClient
    
    init() {
        api = APIClient()
    }
    
    func apiRequest<T: Codable>(_ urlRequest: URLRequest) -> Single<(T, HTTPURLResponse)> {
        return api.request(urlRequest).catchError({ error in
            return Single.create(subscribe: { [unowned self] single -> Disposable in
                single(.error(self.parseError(error)))
                return Disposables.create()
            })
        })
    }
    
    func apiRequest(_ urlRequest: URLRequest) -> Single<HTTPURLResponse> {
        return api.request(urlRequest).catchError({ error in
            return Single.create(subscribe: { [unowned self] single -> Disposable in
                single(.error(self.parseError(error)))
                return Disposables.create()
            })
        })
    }
    
    private func parseError(_ error: Error) -> Error {
        switch error {
        case MindErrors.apiError(let code, _, _):
            if code == 401 || code == 406 {
                return MindErrors.unauthorized
            }
        default:
            break
        }
        return error
    }
}

