//
//  SelectionViewController.swift
//  Project_Tadak
//
//  Created by Min_MacBook Pro on 2020/05/21.
//  Copyright © 2020 Tadak_Team. All rights reserved.
//

import UIKit

class SelectionViewController: UIViewController {
    var nameArr : [String] = []
    
    @IBOutlet weak var gameTableView: UITableView!
    @IBOutlet weak var mainTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseSetUp()
    }
    
    func baseSetUp() -> Void {
        self.gameTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        mainTitle.text = GameList.name
        gameTableView.delegate = self
        gameTableView.dataSource = self
        self.gameTableView.register(UINib(nibName: "gameTableViewCell", bundle: nil), forCellReuseIdentifier: "gameCell")
        gameTableView.rowHeight = 100
        navigationController?.isNavigationBarHidden = true
    }
}


extension SelectionViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GameList.body.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.gameTableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! gameTableViewCell
        cell.gameLabel.text = GameList.body[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        GameContents.getContentsAndThen(indexPathRow: indexPath.row) {
            self.performSegue(withIdentifier: "goToGamePage", sender: nil)
        }
    }
}
