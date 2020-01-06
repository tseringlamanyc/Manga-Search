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
            let sound = Bundle.main.path(forResource: "ting", ofType: "mp3")
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
    
    var currentManga = "11" {
        didSet {
            mangaAPI.getMangas(mangaNum: Int(currentManga) ?? 11) { (result) in
                switch result {
                case .failure(let appError):
                    print("\(appError)")
                case .success(let mangas):
                    DispatchQueue.main.async {
                        self.ninjas = mangas
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData(userNum: Int(currentManga)!)
        narutoSearch.delegate = self
        narutoCV.delegate = self
        narutoCV.dataSource = self
        title = "Tap on the picture to show more info"
        //playSound(file: "opening", ext: "mp3")
    }
    
    func loadData(userNum: Int) {
        mangaAPI.getMangas(mangaNum: userNum) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let ninjas):
                self?.ninjas = ninjas
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let safariVC = segue.destination as? UrlViewController, let indexpath = narutoCV.indexPathsForSelectedItems!.first else {
            fatalError()
        }
        playSound(file: "ting", ext: "mp3")
        safariVC.ninjas2 = ninjas[indexpath.row]
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
        cell.ninjasName.text = "\(narutoCard.name) - \(narutoCard.role)"
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
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentManga = searchBar.text!
    }
}




