//
//  ImageColorExtractor.swift
//  Recipe App
//
//  Created by reed kuivila on 11/9/23.
//

import SwiftUI
import CoreImage

/// This file is to implement a dynamic background color in MealDetailView
/// I extract the main/dominant/average color from the image
/// I use that to give the view a custom background color to match the color of the dessert
extension UIImage {
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull as Any])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}


/// Extract the average color from the image - allows the background on MealDetailView to be dynamic depending on the dominant color in the meal's image
///
/// - Parameters:
///   - imageURL: the image of the meal, strMealThumb in the JSON data
///   - completion: A closure that will be called with a Color object on success or nil on failure.
func extractDominantColor(from imageURL: String, completion: @escaping (Color) -> Void) {
    guard let url = URL(string: imageURL) else {
        // Return a default transparent color if the URL is invalid
        completion(Color.clear)
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, _, error in
        if let data = data, let uiImage = UIImage(data: data) {
            if let averageColor = uiImage.averageColor {
                DispatchQueue.main.async {
                    completion(Color(averageColor))
                }
            } else {
                // Return a default transparent color if extraction fails
                DispatchQueue.main.async {
                    completion(Color.clear)
                }
            }
        } else {
            // Return a default transparent color if there's an error or if data is nil
            DispatchQueue.main.async {
                completion(Color.clear)
            }
        }
    }.resume()
}
