//
//  AssessmentViewController.swift
//  Covid-19
//
//  Created by Sanif Himani on 2020-04-22.
//  Copyright © 2020 Sanif Himani. All rights reserved.
//

import UIKit

class AssessmentViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let preventiveMeasuresImages: [UIImage] = [UIImage(imageLiteralResourceName: "prevention-1"), UIImage(imageLiteralResourceName: "prevention-2"), UIImage(imageLiteralResourceName: "prevention-3"), UIImage(imageLiteralResourceName: "prevention-4")]
    let preventiveMeasures: [String: String] = ["Stay Home": "Stay home as much as you can.", "Keep Distance": "Keep a safe distance from other.", "Wash Hands": "Wash hands properly and often.", "Cover": "User a mask or cover your cough."]
    
    // reference - https://bit.ly/3eQEARI
    @IBAction func callHelpButton(_ sender: Any) {
        guard let url = URL(string: "tel://\(Constants.helplineNumber)") else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return preventiveMeasures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PreventionCollectionViewCell", for: indexPath) as! PreventionCollectionViewCell
        collectionView.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        cell.preventionImage.image = preventiveMeasuresImages[indexPath.row]
        let index = preventiveMeasures.index(preventiveMeasures.startIndex, offsetBy: indexPath.row)
        cell.preventionTitle.text = preventiveMeasures.keys[index]
        cell.preventionContent.text = preventiveMeasures.values[index]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
