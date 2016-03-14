//
//  SecondViewController.swift
//  SearchController
//
//  Created by Ahmed Khedr on 1/6/16.
//  Copyright © 2016 Ahmed Khedr. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var productNameLabel: UILabel!
    
    var product: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        productNameLabel.text = product
        title = product
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
