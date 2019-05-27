//
//  HomeHeaderViewModel.swift
//  MEWDemoProject
//
//  Created by Oleg Petrunko on 5/24/19.
//  Copyright © 2019 Oleg Petrunko. All rights reserved.
//

import UIKit

struct HomeViewModel {
    let image: UIImage
    let titile: String
}

extension HomeViewModel {
    static var genericModels: [HomeViewModel] {
        let images = [UIImage(named: "photo_1")!, UIImage(named: "photo_2")!, UIImage(named: "photo_3")!]
        let titles = ["Some text", "Interesting text", "Boring text"]

        var models: [HomeViewModel] = []
        for i in 0..<images.count {
            models.append(HomeViewModel(image: images[i], titile: titles[i]))
        }

        return models
    }

    static var genericModels2: [HomeViewModel] {
        let images = [UIImage(named: "photo_4")!, UIImage(named: "photo_5")!, UIImage(named: "photo_6")!]
        let titles = ["Best pruduct", "So-so product", "Bad product"]

        var models: [HomeViewModel] = []
        for i in 0..<images.count {
            models.append(HomeViewModel(image: images[i], titile: titles[i]))
        }

        return models
    }
}
