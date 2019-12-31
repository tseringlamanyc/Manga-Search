//
//  ViewController.swift
//  Practice
//
//  Created by Tsering Lama on 12/24/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var narutoCV: UICollectionView!

    var ninjas = [Ninjas]() {
        didSet {
            narutoCV.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        narutoCV.dataSource = self
    }
    
    func loadData() {
        NarutoAPI.getNinjas { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let ninjas):
                self?.ninjas = ninjas
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ninjas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "narutoCell", for: indexPath) as? NinjasCell else {
            fatalError()
        }
        let narutoCard = ninjas[indexPath.row]
        
        
        return cell
    }
    
    
}

