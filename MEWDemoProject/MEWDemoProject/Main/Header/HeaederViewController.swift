//
//  HeaederViewController.swift
//  MEWDemoProject
//
//  Created by Oleg Petrunko on 5/17/19.
//  Copyright © 2019 Oleg Petrunko. All rights reserved.
//

import Foundation
import Mew

final class HeaederViewController: UIViewController, Instantiatable {

    private enum GUI {
        static let numberOfCell = 5
    }

    typealias Environment = EnvironmentMock
    var environment: EnvironmentMock

    struct Model {
        var elements: [HomeViewModel]
    }

    struct Input {
        var elements: [HomeViewModel]
    }

    var model: [HomeViewModel]? {
        didSet { collectionView.reloadData() }
    }

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet { CollectionViewCell<SlideViewController>.register(to: collectionView) }
    }

    @IBOutlet weak var pageControl: UIPageControl!

    init(with input: Input, environment: Environment) {
        self.environment = environment
        self.model = input.elements
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.currentPage = 0
        pageControl.numberOfPages = model?.count ?? 0
    }
}

extension HeaederViewController: Injectable {
    func input(_ input: HeaederViewController.Input) {
        model?.append(input.elements[0])
        pageControl.numberOfPages = model?.count ?? 0
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension HeaederViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let inpute = SlideViewController.Input.init(homeHeaderViewModel: model![indexPath.row])
        return CollectionViewCell<SlideViewController>.dequeued(from: collectionView,
                                                                for: indexPath,
                                                                input: inpute,
                                                                parentViewController: self)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

extension HeaederViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 200)
    }
}
