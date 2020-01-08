//
//  BaseViewController.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/01/2020.
//  Copyright © 2020 MindValley. All rights reserved.
//

import RxSwift

class BaseViewController: UIViewController, RxBaseProtocol, UIGestureRecognizerDelegate {
    var disposeBag = DisposeBag()
    private var loadingAlert: UIAlertController?
    private var loadingView: UIView?
    private var genericErrorView: GenericErrorView?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func showErrorView(_ error: Error, _ view: UIView) {
        switch error {
        case MindErrors.retryError(let message, let retryAction):
            if genericErrorView == nil {
                genericErrorView = GenericErrorView(frame: view.bounds)
            }
            genericErrorView?.errorMessage = message
            genericErrorView?.retryAction = {[unowned self] in
                self.removeErrorView(view)
                retryAction()
            }
            if !view.subviews.contains(genericErrorView!) {
                view.addSubview(genericErrorView!)
                genericErrorView?.pinToSuperview()
            }
        default:
            break
        }
    }
    
    private func removeErrorView(_ view: UIView) {
        if genericErrorView != nil && view.subviews.contains(genericErrorView!) {
            genericErrorView?.removeFromSuperview()
        }
    }
    
    func configureNavigationBar(_ title: String?) {
        navigationController?.navigationBar.shadowImage = UIImage()
        self.title = title
    }
    
    @objc func closeController() {
        dismiss(animated: true, completion: nil)
    }
    
    func configureNavigationLoading() {
        let activityIndicatorView = UIActivityIndicatorView(style: .white)
        activityIndicatorView.startAnimating()
        let barButton = UIBarButtonItem(customView: activityIndicatorView)
        navigationItem.rightBarButtonItem = barButton
    }
    
    func showSnackError(_ error: Error, _ hideAfter: Bool = true) {
        let timeToHide: Double? = hideAfter ? 4 : nil
        switch error {
        case MindErrors.apiError(_, let message, _):
            let model = MindSnackBarView.ViewModel(messageText: message,
                                                 buttonText: Strings.commonOkay.localized().uppercased())
            showSnackBar(model, timeToHide)
       default:
            let model = MindSnackBarView.ViewModel(messageText: Strings.commonGeneralError.localized(),
                                                 buttonText: Strings.commonOkay.localized().uppercased())
            showSnackBar(model, timeToHide)
        }
    }
    
    func showSnackBar(_ model: MindSnackBarView.ViewModel,
                      _ hideAfter: Double? = nil,
                      _ retryClosure: (() -> Void)? = nil) {
        let snackBar = MindSnackBarView(model)
        if let retryClosure = retryClosure {
            snackBar.setConfirmClosure(retryClosure)
        }
        view.endEditing(true)
        UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            UIApplication.shared.keyWindow?.addSubview(snackBar)
            snackBar.pinToSuperview()
        }) { _ in
            guard let hideAfter = hideAfter else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + hideAfter, execute: { [weak self] in
                guard let self = self else { return }
                UIView.transition(with: self.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    snackBar.removeFromSuperview()
                }, completion: nil)
            })
        }
    }
    
    func keyboardHeight(notification: NSNotification) -> CGFloat {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            return keyboardRectangle.height
        }
        return 0
    }
    
    func showAlertLoading(message: String = Strings.commonPleaseWait.localized(),
                          isMessageLengthy: Bool = false) {
        if loadingAlert == nil {
            loadingAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)
            let messageFont = [NSAttributedString.Key.font: UIFont.MindFont.regular.font(17),
                               NSAttributedString.Key.foregroundColor: UIColor.darkGray]
            let messageAttrString = NSMutableAttributedString(string: message, attributes: messageFont)
            loadingAlert?.setValue(messageAttrString, forKey: "attributedMessage")
            let xCoordinate = isMessageLengthy ? 0 : 15
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: xCoordinate, y: 11, width: 40, height: 40))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = .whiteLarge
            loadingIndicator.color = .purple
            loadingIndicator.startAnimating()
            loadingAlert?.view.addSubview(loadingIndicator)
        }
        guard let loadingAlert = loadingAlert else {
            return
        }
        present(loadingAlert, animated: true)
    }

}


