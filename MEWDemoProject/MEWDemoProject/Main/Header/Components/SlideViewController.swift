//
//  SlideViewController.swift
//  MEWDemoProject
//
//  Created by Oleg Petrunko on 5/24/19.
//  Copyright © 2019 Oleg Petrunko. All rights reserved.
//

import UIKit
import Mew

final class SlideViewController: UIViewController, Instantiatable, Injectable {

    struct Input {
        var homeHeaderViewModel: HomeViewModel
    }

    struct Model {
        var homeHeaderViewModel: HomeViewModel
    }

    let environment: EnvironmentMock
    var model: HomeViewModel? {
        didSet { updateUI() }
    }

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    init(with input: Input, environment: EnvironmentMock) {
        self.environment = environment
        self.model = input.homeHeaderViewModel
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func input(_ input: SlideViewController.Input) {
        self.model = input.homeHeaderViewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
}

private extension SlideViewController {
    func updateUI() {
        label.text = model?.titile
        imageView.image = model?.image
    }
}
