//
//  UISearchTextField+Extension.swift
//  DungeonsAndDragons
//
//  Created by Nguyễn Thành Trung on 03/07/2021.
//

import UIKit
import Combine

//extension UISearchTextField {
//    var publisher: AnyPublisher<String?, Never> {
//        NotificationCenter.default
//            .publisher(for: UISearchTextField.textDidChangeNotification, object: self)
//            .compactMap { $0.object as? UISearchTextField? }
//            .map { $0?.text }
//            .eraseToAnyPublisher()
//    }
//}

extension UITextField {
    var publisher: AnyPublisher<String?, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UISearchTextField? }
            .map { $0?.text }
            .eraseToAnyPublisher()
    }
}
