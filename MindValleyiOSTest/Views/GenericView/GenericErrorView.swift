////
//  MindValleyiOSTest
//
//	GenericErrorView.swift written using Swift 4.0
//
//  Created by Johnstone Ananda on 06/01/2020.
//  Copyright © 2020 MindValley. All rights reserved.
//

import UIKit

class GenericErrorView: UIView {
    
    @IBOutlet private var genericView: UIView!
    @IBOutlet private weak var retryButton: UIButton!
    @IBOutlet private weak var errorMessageLabel: UILabel!
    var retryAction: (() -> Void)?
    var errorMessage: String = "" {
        didSet {
            errorMessageLabel.text = errorMessage
        }
    }
    
    var retryButtonImage: UIImage? {
        didSet {
            retryButton.setImage(retryButtonImage, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        Bundle.main.loadNibNamed(ViewIds.genericIdentifier.rawValue, owner: self, options: nil)
        genericView.frame = self.bounds
        genericView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(genericView)
        errorMessageLabel.font = UIFont.MindFont.semiBold.font(20)
    }
    
    @IBAction private func retryButtonAction(_ sender: Any) {
        retryAction?()
    }
}
