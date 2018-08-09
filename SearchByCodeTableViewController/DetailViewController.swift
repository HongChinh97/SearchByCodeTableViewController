//
//  DetailViewController.swift
//  SearchByCodeTableViewController
//
//  Created by admin on 8/3/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var dataObject: Hero?
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var textFieldCategory: UITextField!
    
    @IBOutlet weak var imagePhoto: UIImageView!
    
    @IBAction func button(_ sender: UIButton) {
        //        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let hero = dataObject {
            textField.text = hero.name
            textFieldCategory.text = hero.category
            imagePhoto.image = hero.image
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let name = textField.text else {return}
        guard let photo = imagePhoto.image else {return}
        guard let category = textFieldCategory.text else {return}
        dataObject = Hero(name: name, category: category, image: photo)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
