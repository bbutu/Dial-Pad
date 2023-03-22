//
//  ContactsTableViewCellModel.swift
//  Dial Pad
//
//  Created by Beka Buturishvili on 13.12.22.
//

import Foundation
import UIKit

struct ContactsTableCollectionViewCellModel {
    var fullName: String
    var phoneNumber: String
    var imageData: UIImage = UIImage(systemName: "person.fill") ?? UIImage()
}
