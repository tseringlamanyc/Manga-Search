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
            DispatchQueue.main.async {
                self.narutoCV.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        narutoCV.delegate = self
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
        cell.narutoImage.image = nil
        cell.ninjasName.text = narutoCard.name
        let imageURL = narutoCard.imageURL
        
        cell.narutoImage.getImage(with: imageURL) { (result) in
            switch result {
            case .failure( _):
                DispatchQueue.main.async {
                cell.narutoImage.image = UIImage(named: "person.fill")
                }
            case .success(let image1):
                DispatchQueue.main.async {
                    cell.narutoImage.image = image1
                }
            }
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width), height: 336)
    }
}


