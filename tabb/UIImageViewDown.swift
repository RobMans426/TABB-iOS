//
//  UIImageViewDown.swift
//  tabb
//
//  Created by LeeDongMin on 2015. 11. 12..
//  Copyright © 2015년 LeeDongMin. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if let imageData = data as NSData? {
                    self.image = UIImage(data: imageData)
                }
            }
        }
    }
}