//
//  ImageLiteral.swift
//  Remember-iOS
//
//  Created by SHIN YOON AH on 2021/11/13.
//

import UIKit

public enum ImageLiterals {

    public static var btnPhoto: UIImage { .load(name: "btnPhoto")}
    public static var btnShare: UIImage { .load(name: "btnShare") }
    public static var icbtComment: UIImage { .load(name: "icon_messagecircle_unseleted") }
    public static var icbtCommentList: UIImage { .load(name: "icbtCommentList") }
    public static var icbtDropdown: UIImage { .load(name: "icbtDropdown") }
    public static var icbtLike: UIImage { .load(name: "icbtLike") }
    public static var icbtLikeHeart: UIImage { .load(name: "icbtLikeHeart") }
    public static var icbtRightChervon: UIImage { .load(name: "icbtRightChervon") }
    public static var iconBack: UIImage { .load(name: "iconBack") }
    public static var iconMessagecircleSeleted: UIImage { .load(name: "iconMessagecircleSeleted") }
    public static var iconMessagecircleUnseleted: UIImage { .load(name: "iconMessagecircleUnseleted") }
    public static var iconMoreHorizontal: UIImage { .load(name: "iconMoreHorizontal") }
    public static var iconMoreVertical: UIImage { .load(name: "iconMoreVertical") }
    public static var iconNameCardSelected: UIImage { .load(name: "iconNameCardSelected") }
    public static var iconNameCardUnselected: UIImage { .load(name: "iconNameCardUnselected") }
    public static var iconUserSelected: UIImage { .load(name: "iconUserSelected") }
    public static var iconUserUnseleted: UIImage { .load(name: "iconUserUnseleted") }
    public static var icUser: UIImage { .load(name: "icUser") }
    public static var nicknameregisterActive: UIImage { .load(name: "nicknameregister_active") }
    public static var nicknameregisterInactive: UIImage { .load(name: "nicknameregister_inactive") }
    public static var surfaceAd: UIImage { .load(name: "surface_ad") }
    public static var imgAd: UIImage { .load(name: "img_ad")}
    public static var buttonCell: UIImage { .load(name: "buttonCell")}
    public static var menuIcon: UIImage { .load(name: "menu")}
    public static var bellIcon: UIImage { .load(name: "bell")}
    public static var searchIcon: UIImage { .load(name: "zoom-out")}
    public static var messageSelected: UIImage { .load(name: "message-circle")}
    public static var writeIcon: UIImage { .load(name: "icbt_write")}
    
}

extension UIImage {
    fileprivate static func load(name: String) -> UIImage {
        guard let image = UIImage(named: name, in: nil, compatibleWith: nil) else {
            assert(false, "\(name) 이미지 로드 실패")
            return UIImage()
        }
        image.accessibilityIdentifier = name
        return image
    }
    
    internal func resize(to length: CGFloat) -> UIImage {
        let newSize = CGSize(width: length, height: length)
        let image = UIGraphicsImageRenderer(size: newSize).image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }
            
        return image
    }
}
