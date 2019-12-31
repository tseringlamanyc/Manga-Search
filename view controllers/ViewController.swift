//
//  ViewController.swift
//  Practice
//
//  Created by Tsering Lama on 12/24/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var narutoCV: UICollectionView!
    @IBOutlet weak var narutoSearch: UISearchBar!
    
    var audioPlayer = AVAudioPlayer()
       
       func playSound(file:String, ext:String) -> Void {
           do {
               let sound = Bundle.main.path(forResource: "opening", ofType: "mp3")
               audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
               audioPlayer.prepareToPlay()
               audioPlayer.play()
           } catch {
               fatalError()
           }
       }
    
    var ninjas = [Ninjas]() {
        didSet {
            DispatchQueue.main.async {
            self.narutoCV.reloadData()
            }
        }
    }
    
    var currentSearch = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        narutoCV.delegate = self
        narutoSearch.delegate = self 
        narutoCV.dataSource = self
        playSound(file: "opening", ext: "mp3")
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
        return CGSize(width: 336, height: 629)
    }
}

extension ViewController: UISearchBarDelegate {
    
}


