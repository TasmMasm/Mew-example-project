//
//  ProductViewController.swift
//  MEWDemoProject
//
//  Created by Oleg Petrunko on 5/27/19.
//  Copyright © 2019 Oleg Petrunko. All rights reserved.
//

import UIKit
import Mew

class ProductViewController: UIViewController, Instantiatable, Interactable {
    // MARK: Interactable
    func output(_ handler: ((ProductViewController.Output) -> Void)?) {
        self.handler = handler
    }

    enum Output {
        case tapped(HomeViewModel)
    }

    var handler: ((Output) -> Void)?

    // MARK: Instantiatable
    typealias Environment = EnvironmentMock
    var environment: ProductViewController.Environment

    struct Input {
        let model: [HomeViewModel]
    }

    var model: [HomeViewModel]

    @IBOutlet weak var tableView: UITableView!

    required init(with input: ProductViewController.Input, environment: ProductViewController.Environment) {
        self.model = input.model
        self.environment = environment
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewCell<ProductTableViewCell>.register(to: tableView)
    }
}

extension ProductViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return TableViewCell<ProductTableViewCell>.dequeued(from: tableView,
                                                            for: indexPath,
                                                            input: ProductTableViewCell.Input(model: model[indexPath.row]),
                                                            parentViewController: self)
    }
}

extension ProductViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handler?(.tapped(model[indexPath.row]))
    }
}
