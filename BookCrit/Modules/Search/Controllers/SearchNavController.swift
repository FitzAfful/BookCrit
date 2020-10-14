//
//  SearchNavController.swift
//  BookCrit
//
//  Created by Fitzgerald Afful on 14/10/2020.
//  Copyright © 2020 Glivion. All rights reserved.
//

import UIKit

class SearchNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func initializeFromStoryboard() -> SearchNavController {
        let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: SearchNavController.storyboardID)
        guard let myController = controller as? SearchNavController else { fatalError() }
        return myController
    }

}
