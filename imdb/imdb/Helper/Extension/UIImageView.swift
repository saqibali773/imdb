//
//  UIImageView.swift
//  museum
//
//  Created by Saqib Ali on 27/02/2022.
//

import Foundation
import AlamofireImage

extension UIImage {
    static var placeholderImage:UIImage {
        return UIImage(named: "MoviePlaceHolder")!
    }
}

extension UIImageView {
    func setImage(url: URL, placeHolderImage: UIImage?) {
        af.setImage(withURL: url, placeholderImage: placeHolderImage, filter: .none, progress: nil, progressQueue: .main, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: true){ (img:AFIDataResponse<UIImage>) in
        }
    }
}
