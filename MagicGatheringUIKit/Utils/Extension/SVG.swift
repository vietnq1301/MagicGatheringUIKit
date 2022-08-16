//
//  SVG.swift
//  MagicGatheringUIKit
//
//  Created by Nguyễn Việt on 14/08/2022.
//

import UIKit
import Kingfisher
import PocketSVG

// Convert SVG images from Server to UIImage
struct SVGProcessor: ImageProcessor {
    
    // `identifier` should be the same for processors with the same properties/functionality
    // It will be used when storing and retrieving the image to/from cache.
    let identifier = "svgprocessor"
    var size: CGSize!
    init(size: CGSize) {
        self.size = size
    }
    
    // Convert input data/image to target image and return it.
    func process(item: ImageProcessItem, options: KingfisherParsedOptionsInfo) -> UIImage? {
        switch item {
        case .image(let image):
            return image
        case .data(let data):
            if let svgString = String(data: data, encoding: .utf8) {
                let path = SVGBezierPath.paths(fromSVGString: svgString)
                let layer = SVGLayer()
                layer.paths = path
                let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
                layer.frame = frame
                let img = self.snapshotImage(for: layer)
                return img
            }
            return nil
        }
    }
    
    // Get actual image
    func snapshotImage(for view: CALayer) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        view.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

// For SVG rendering only
extension UIImageView {
    
    /// Use this function for downloading SVG image from URL
    /// - Parameters:
    ///   - url: SVG image url
    ///   - processor: SVG Image Processor
    func svgImage(from url: URL?, processor: SVGProcessor) {
        guard let url = url else {
            self.image = nil
            return
        }
        
        KingfisherManager.shared.retrieveImage(with: url, options: [.processor(processor), .forceRefresh]) {  result in
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    self.image = value.image
                }
            case .failure(let error):
                print("Image download fail:\(error.localizedDescription)")
            }
        }
    }
}
