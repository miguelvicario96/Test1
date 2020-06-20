//
//  LoadingView.swift
//  Test1
//
//  Created by Miguel Vicario on 19/06/20.
//  Copyright © 2020 Scotiabank. All rights reserved.
//

import UIKit

public class LoadingView: UIView {
    
    //MARK: - IBOutlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var activityAlertView: UIActivityIndicatorView!
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
