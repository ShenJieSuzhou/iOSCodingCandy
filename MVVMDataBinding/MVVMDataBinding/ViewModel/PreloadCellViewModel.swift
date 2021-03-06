//
//  PreloadCellViewModel.swift
//  PreloadDemo
//
//  Created by shenjie on 2021/4/2.
//

import UIKit
import Foundation

let baseURL = "https://robohash.org/"

//protocol PreloadCellViewModelDelegate: NSObject {
//    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
//    func onFetchFailed(with reason: String)
//}

class PreloadCellViewModel: NSObject {
    var loadingQueue = OperationQueue()
    var loadingOperations = [IndexPath : DataLoadOperation]()
    
//    weak var delegate: PreloadCellViewModelDelegate?
    
    var images: Box<[ImageModel]> = Box([])
    private var isFetchInProcess = false
    private var total = 0
    private var currentPage = 0
    
    var totalCount: Int {
        return total
    }
    
    var currentCount: Int {
        return images.value.count
    }
        
    func imageModel(at index: Int) -> ImageModel {
        return images.value[index]
    }
    
    public func loadImage(at index: Int) -> DataLoadOperation? {
        if (0..<images.value.count).contains(index) {
            return DataLoadOperation(images.value[index])
        }
        return .none
    }
    
    func fetchImages() {
        guard !isFetchInProcess else {
            return
        }

        isFetchInProcess = true
        // 延时 2s 模拟网络环境
        print("+++++++++++ 模拟网络数据请求 +++++++++++")
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 2) {
            print("+++++++++++ 模拟网络数据请求返回成功 +++++++++++")
            DispatchQueue.main.async {
                self.total = 1000
                self.currentPage += 1
                self.isFetchInProcess = false
                // 初始化 30个 图片
                let imagesData = (1...30).map {
                    ImageModel(url: baseURL+"\($0).png", order: $0)
                }
                self.images.value.append(contentsOf: imagesData)

//                if self.currentPage > 1 {
//                    let newIndexPaths = self.calculateIndexPathsToReload(from: imagesData)
//
//                } else {
//
//                }
            }
        }
    }
    
    
//    // 计算可视 indexPath 数组
//    private func calculateIndexPathsToReload(from newImages: [ImageModel]) -> [IndexPath] {
//        let startIndex = images.value.count - newImages.count
//        let endIndex = startIndex + newImages.count - 1
//
//        return (startIndex...endIndex).map { i in
//            return IndexPath(row: i, section: 0)
//        }
//    }
}
