//
//  UrlViewController.swift
//  Practice
//
//  Created by Tsering Lama on 1/2/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit
import SafariServices

class UrlViewController: UIViewController {
    
    var ninjas2: Ninjas!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func showWebsite(_ sender: UIButton) {
        guard let url = URL(string: ninjas2.url) else {
                return
            }
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
            safariVC.delegate = self
        }
    }

extension UrlViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
