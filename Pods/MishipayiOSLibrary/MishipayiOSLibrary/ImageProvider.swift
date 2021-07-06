//
//  ImageProvider.swift
//  MishipayiOSLibrary
//
//  Created by Vivek Garg on 06/07/21.
//
import UIKit

public class ImageProvider {
    // convenient for specific image
    public static func backArrow() -> UIImage {
        return UIImage(named: "back_arrow", in: Bundle(for: self), with: nil) ?? UIImage()
    }
}
