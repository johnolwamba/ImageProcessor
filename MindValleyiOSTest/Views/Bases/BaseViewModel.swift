//
//  BaseViewModel.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/01/2020.
//  Copyright © 2020 MindValley. All rights reserved.
//

import RxSwift
import RxCocoa

class BaseViewModel: RxBaseProtocol {
    let disposeBag = DisposeBag()
    let errorRelay = PublishRelay<Error>()
    
    func handleError(_ error: Error, _ retryAction: @escaping (() -> Void)) {
        errorRelay.accept(parseApiErrorToRetry(error, retryAction))
    }
    
    private func parseApiErrorToRetry(_ error: Error, _ retryAction: @escaping (() -> Void)) -> Error {
        switch error {
        case MindErrors.apiError(_, let message, _):
            return MindErrors.retryError(message: message, retryAction: retryAction)
        case MindErrors.internetError:
            return MindErrors.retryError(message: Strings.commonInternetError.localized(), retryAction: retryAction)
        default:
            return error
        }
    }
}

