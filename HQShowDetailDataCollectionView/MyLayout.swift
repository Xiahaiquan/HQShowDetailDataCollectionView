//
//  MyLayout.swift
//  HQShowDetailDataCollectionView
//
//  Created by HaiQuan on 2019/1/28.
//  Copyright © 2019 HaiQuan. All rights reserved.
//

import UIKit

/**
 * 这个类只简单定义了一个section的布局
 */
class MyLayout : UICollectionViewLayout {

    var index: Int!

    init(indexSlected: Int) {
        super.init()
        self.index = indexSlected
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 内容区域总大小，不是可见区域
    override var collectionViewContentSize: CGSize {
        let width = collectionView!.bounds.size.width - collectionView!.contentInset.left
            - collectionView!.contentInset.right
        let height = CGFloat((collectionView!.numberOfItems(inSection: 0) + 1) / 8)
            * (width * 3)
        return CGSize(width: width, height: height)
    }

    // 所有单元格位置属性
    override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
            var attributesArray = [UICollectionViewLayoutAttributes]()
            let cellCount = self.collectionView!.numberOfItems(inSection: 0)
            for i in 0..<cellCount {
                let indexPath =  IndexPath(item:i, section:0)
                let attributes =  self.layoutAttributesForItem(at: indexPath)
                attributesArray.append(attributes!)
            }
            return attributesArray
    }

    // 这个方法返回每个单元格的位置和大小
    override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
            //当前单元格布局属性
            let attribute =  UICollectionViewLayoutAttributes(forCellWith:indexPath)
            //单元格宽
            let cellWidth = (collectionViewContentSize.width / 2)
            //当前行数
            let line:Int =  indexPath.item / 2
            //当前行的Y坐标
            let lineOriginY =  (cellWidth * CGFloat(line))
            //右侧单元格X坐标
            let rightLargeX = collectionViewContentSize.width - cellWidth

            let row = indexPath.item % 8
            if row % 2 == 0 {
                attribute.frame = CGRect(x: 0, y: lineOriginY, width: cellWidth, height: cellWidth)
            }else {
                attribute.frame = CGRect(x: rightLargeX, y: lineOriginY, width: cellWidth, height: cellWidth)
            }

            var indexSelect = index
            if index % 2 == 0 {
                indexSelect = index + 1
            }
            if row > indexSelect! {
                attribute.frame.origin.y += Constant.detailHeight
            }

            return attribute
    }

}


