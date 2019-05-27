//
//  ViewController.swift
//  MEWDemoProject
//
//  Created by Oleg Petrunko on 5/14/19.
//  Copyright © 2019 Oleg Petrunko. All rights reserved.
//

import UIKit
import Mew

final class MainViewController: UIViewController, Instantiatable {
    var environment: EnvironmentMock

    typealias Input = Void
    typealias Environment = EnvironmentMock

    @IBOutlet weak var containerView: ContainerView!
    @IBOutlet weak var containerView2: ContainerView!

    var headerContainer: ContainerView.Container<HeaederViewController, MainViewController>?
    var productContainer: ContainerView.Container<ProductViewController, MainViewController>?

    init(with input: Input, environment: Environment) {
        self.environment = environment
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        environment.getHeaderInfo {
//            let VC = HeaederViewController(with: HeaederViewController.Input(elements: $0), environment: environment)
//            containerView.addArrangedViewController(VC, parentViewController: self)
            headerContainer = containerView.makeContainer(for: HeaederViewController.self,
                                                          parentViewController: self,
                                                          with: HeaederViewController.Input(elements: $0))
        }

        environment.getContentInfo {
            productContainer = containerView2.makeContainer(for: ProductViewController.self,
                                                            parentViewController: self,
                                                            with: ProductViewController.Input(model: $0))
            productContainer?.output {
                switch $0 {
                case .tapped(let model):
                    self.headerContainer?.input(HeaederViewController.Input(elements: [model]))
                }
            }
        }
    }
}

protocol EnvironmentMock {
    func getHeaderInfo(completion: ([HomeViewModel]) -> Void)
    func getContentInfo(completion: ([HomeViewModel]) -> Void)
}

extension _Environment {
    func getHeaderInfo(completion: ([HomeViewModel]) -> Void) {
        completion(HomeViewModel.genericModels)
    }

    func getContentInfo(completion: ([HomeViewModel]) -> Void) {
        completion(HomeViewModel.genericModels2)
    }
}
