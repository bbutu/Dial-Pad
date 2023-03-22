//
//  ViewController.swift
//  Dial Pad
//
//  Created by Beka Buturishvili on 02.12.22.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let vc1 = UINavigationController(rootViewController: FavouritesViewController())
        let vc2 = UINavigationController(rootViewController: RecentsViewController())
        let vc3 = UINavigationController(rootViewController: ContactsViewController())
        let vc4 = UINavigationController(rootViewController: KeypadViewController())
        let vc5 = UINavigationController(rootViewController: VoicemailViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "star.fill")
        vc1.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        vc1.tabBarItem.title = "Favorites"
        vc2.tabBarItem.image = UIImage(systemName: "clock.fill")
        vc2.tabBarItem.selectedImage = UIImage(systemName: "clock.fill")
        vc2.tabBarItem.title = "Recents"
        vc3.tabBarItem.image = UIImage(systemName: "person.circle.fill")
        vc3.tabBarItem.selectedImage = UIImage(systemName: "person.circle.fill")
        vc3.tabBarItem.title = "Contacts"
        vc4.tabBarItem.image = UIImage(systemName: "square.grid.3x3.fill")
        vc4.tabBarItem.selectedImage = UIImage(systemName: "square.grid.3x3.fill")
        vc4.tabBarItem.title = "Keypad"
        vc5.tabBarItem.image = UIImage(systemName: "person.wave.2.fill")
        vc5.tabBarItem.selectedImage = UIImage(systemName: "person.wave.2.fill")
        vc5.tabBarItem.title = "Voicemail"
        
        tabBar.backgroundColor = .systemBackground
        
        setViewControllers([vc1,vc2,vc3,vc4,vc5], animated: true)
    }


}

