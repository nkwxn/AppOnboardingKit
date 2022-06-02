//
//  Slide.swift
//  
//
//  Created by Nicholas on 31/05/22.
//

import Foundation
import UIKit

public struct Slide {
    public let image: UIImage?
    public let title: String
    
    public init(image: UIImage?, title: String) {
        self.image = image
        self.title = title
    }
}
