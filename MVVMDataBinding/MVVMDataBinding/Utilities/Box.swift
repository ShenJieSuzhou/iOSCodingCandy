//
//  Box.swift
//  MVVMDataBinding
//
//  Created by shenjie on 2021/10/25.
//

import Foundation

final class Box<T> {
    // 声明一个别名
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T){
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
