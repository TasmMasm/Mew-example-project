//
//  ProductTableViewCell.swift
//  MEWDemoProject
//
//  Created by Oleg Petrunko on 5/27/19.
//  Copyright © 2019 Oleg Petrunko. All rights reserved.
//

import UIKit
import Mew

class ProductTableViewCell: UIViewController, Instantiatable, Injectable {
    struct Input {
        let model: HomeViewModel
    }
    var model: HomeViewModel

    typealias Environment = EnvironmentMock
    var environment: EnvironmentMock

    @IBOutlet weak var textLable: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    required init(with input: ProductTableViewCell.Input, environment: EnvironmentMock) {
        self.model = input.model
        self.environment = environment
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func input(_ input: ProductTableViewCell.Input) {
        self.model = input.model
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    func updateUI() {
        textLable.text = model.titile
        imageView.image = model.image
    }
}
