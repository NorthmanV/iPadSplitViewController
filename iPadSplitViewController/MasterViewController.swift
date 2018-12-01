//
//  MasterViewController.swift
//  iPadSplitViewController
//
//  Created by Ruslan Akberov on 01/12/2018.
//  Copyright © 2018 Ruslan Akberov. All rights reserved.
//

import UIKit

protocol CakeSelectionDelegate: class {
    func cakeSelected(_ cake: Cake)
}

class MasterViewController: UITableViewController {
    
    let cakes = [
        Cake(name: "New York Cheesecake", description: "This authentic creamy dessert will add a taste of New York to any dining table", image: UIImage(named: "new_york_cheesecake")!),
        Cake(name: "Chocolate Cake", description: "Master the chocolate cake with an airy, light sponge and rich buttercream filling. It's simple enough for an afternoon tea but special enough for a party too", image: UIImage(named: "chocolate_cake")!),
        Cake(name: "Brownie", description: "Dense and gooey, these storecupboard treats are made with cocoa rather than bars of chocolate", image: UIImage(named: "brownie")!),
        Cake(name: "Fruitcake", description: "Easy fruit cake uses storecupboard ingredients and is perfect for a quick winter pick-me-up", image: UIImage(named: "fruitcake")!),
        Cake(name: "Cupcake", description: "Perfect for a bake sale, kid's party or sweet afternoon snack, these iced cupcakes are the simplest sponges around and can be decorated as you like", image: UIImage(named: "cupcake")!)
    ]
    
    weak var delegate: CakeSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let navViewController = splitViewController?.viewControllers.last as? UINavigationController, let detailViewController = navViewController.viewControllers.first as? DetailViewController
            else { fatalError("Split view contoller is not loaded") }
        delegate = detailViewController
        detailViewController.cake = cakes.first
        detailViewController.navigationItem.leftItemsSupplementBackButton = true
        detailViewController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        splitViewController?.preferredDisplayMode = .allVisible
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cakes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = cakes[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.cakeSelected(cakes[indexPath.row])
        // only changes the behavior of the app on iPhone, causing the navigation controller to push the detail controller onto the stack when you select
        if let detailViewController = delegate as? DetailViewController,
            let detailNavigationController = detailViewController.navigationController {
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
        
    }
}
