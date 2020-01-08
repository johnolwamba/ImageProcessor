////
//  SafeBoda
//
//	MindSnackBarView.swift written using Swift 4.0
//
//  Created on: 14/02/2019
//
//  Copyright © 2019 SafeBoda. All rights reserved.
//

import UIKit

class MindSnackBarView: UIView {
    // MARK: IBOutlets
    @IBOutlet private var view: UIView!
    @IBOutlet private weak var snackBarView: UIView!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var actionButton: UIButton!
    
    // MARK: Variables
    private var snackBarViewModel: MindSnackBarView.ViewModel
    
    // MARK: Closures
    private var confirmClosure: (() -> Void)?

    required init(_ viewModel: MindSnackBarView.ViewModel) {
        snackBarViewModel = viewModel
        super.init(frame: UIScreen.main.bounds)
        loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: IBActions
    @IBAction func confirmAction(_ sender: Any) {
        closeView { _ in
            self.confirmClosure?()
        }
    }
    
    // MARK: Public methods
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self.view ? nil : view
    }
    
    func setConfirmClosure(_ confirmClosure: (() -> Void)?) {
        self.confirmClosure = confirmClosure
    }
    
    // MARK: Private methods
    private func loadViewFromNib() {
        view = UINib(nibName: "MindSnackBarView", bundle: nil)
            .instantiate(withOwner: self, options: nil).first as? UIView
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        snackBarView.layer.cornerRadius = 6
        messageLabel.text = snackBarViewModel.messageText
        actionButton.setTitle(snackBarViewModel.buttonText, for: .normal)
        addSubview(view)
    }

    private func closeView(_ completion: @escaping ((Bool) -> Void)) {
        UIView.transition(with: superview ?? view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.removeFromSuperview()
        }, completion: completion)
    }
}

extension MindSnackBarView {
    struct ViewModel {
        var messageText: String
        var buttonText: String
    }
}
