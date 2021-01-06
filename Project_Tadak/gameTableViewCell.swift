//
//  gameTableViewCell.swift
//  Project_Tadak
//
//  Created by 신효근 on 2020/11/01.
//  Copyright © 2020 Tadak_Team. All rights reserved.
//

import UIKit
import Firebase

class gameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var gameButton: UIButton!
    var mainTitleString = ""
    var dataSource : String = ""
    var ref:DatabaseReference!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ref = Database.database().reference()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
//    @IBAction func gameButtonPressed(_ sender: UIButton) {
//        let postRef : DatabaseQuery! = ref.child("game").child(mainTitleString).child(gameLabel.text!)
//        postRef.observeSingleEvent(of: DataEventType.value) { (snapshot, key) in
//            let children : NSEnumerator = snapshot.children
//            for (child) in children {
//                let childSnapShot = child as? DataSnapshot
//                let childPost : NSString = (childSnapShot?.value as? NSString)!
//                print(childPost)
//            }
//            DispatchQueue.main.async {
//                
//            }
//        }
//    }
}
