//
//  UIImage+SwiftTweaks.swift
//  SwiftTweaks
//
//  Created by Bryan Clark on 4/6/16.
//  Copyright © 2016 Khan Academy. All rights reserved.
//

import UIKit

internal extension UIImage {

	enum SwiftTweaksImage: String {
		case disclosureIndicator = "disclosure-indicator"
		case floatingPlusButton = "floating-plus-button"
		case floatingCloseButton = "floating-ui-close"
		case floatingReopenButton = "floating-ui-open-tweaks"
		case floatingMinimizedArrow = "floating-ui-minimized-arrow"
	}

	convenience init(swiftTweaksImage: SwiftTweaksImage) {
		self.init(inThisBundleNamed: swiftTweaksImage.rawValue)!
	}

    // Use different bundle
	private convenience init?(inThisBundleNamed imageName: String) {
		#if SWIFT_PACKAGE
		self.init(named: imageName, in: Bundle.module, compatibleWith: nil)
		#else
        let path = Bundle.main.bundlePath.appending("/SwiftTweaks.bundle")
        guard let bundle = Bundle(path: path) else {
            fatalError("Missing SwiftTweaks bundle.")
            return nil
        }
		self.init(named: imageName, in: bundle, compatibleWith: nil) // NOTE (bryan): Could've used any class in SwiftTweaks here.
		#endif
	}

	/// Returns the image, tinted to the given color.
	func imageTintedWithColor(_ color: UIColor) -> UIImage {
		let imageRect = CGRect(origin: CGPoint.zero, size: self.size)

		UIGraphicsBeginImageContextWithOptions(imageRect.size, false, 0.0) // Retina aware.

		draw(in: imageRect)
		color.set()
		UIRectFillUsingBlendMode(imageRect, .sourceIn)

		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()

		return image
	}
}
