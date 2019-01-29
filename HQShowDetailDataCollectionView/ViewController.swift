//
//  ViewController.swift
//  HQShowDetailDataCollectionView
//
//  Created by HaiQuan on 2019/1/28.
//  Copyright © 2019 HaiQuan. All rights reserved.
//

import UIKit

struct Constant {
    
    static let detailHeight: CGFloat = 120
    static let detailSpace: CGFloat = 10
    static let cellIdentifier = "cellIdentifier"
    
}

class ViewController: UIViewController {
    
    var summaryLayout:UICollectionViewFlowLayout!
    var customLayout: MyLayout!
    
    var collectionView:UICollectionView!
    
    let detailView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化Collection View
        initCollectionView()
    }
    
    private func initCollectionView() {
        
        //初始化flow布局
        summaryLayout = UICollectionViewFlowLayout()
        summaryLayout.minimumLineSpacing = 0
        summaryLayout.minimumInteritemSpacing = 0
        
        let itemWidth = self.view.frame.width / 2
        summaryLayout.itemSize = CGSize(width: itemWidth, height: itemWidth )
        
        //初始化Collection View
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: summaryLayout)
        
        //Collection View代理设置
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constant.cellIdentifier)
        
        //将Collection View添加到主视图中
        view.addSubview(collectionView)
    }
    
    //切换布局样式
    func changeLayout(_ index: IndexPath) {
        
        self.collectionView.collectionViewLayout.invalidateLayout()
        customLayout = MyLayout.init(indexSlected: index.row)
        
        //交替切换新布局
        let newLayout = collectionView.collectionViewLayout
            .isKind(of: MyLayout.self) ? summaryLayout : customLayout
        
        collectionView.setCollectionViewLayout(newLayout!, animated: false)
        
    }
    
    
}
// MARK: - Collection View数据源协议相关方法
extension ViewController: UICollectionViewDataSource {
    
    //获取每个分区里单元格数量
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    //返回每个单元格视图
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //获取重用的单元格
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            Constant.cellIdentifier, for: indexPath)
        cell.contentView.backgroundColor = UIColor.randomColor
        return cell
    }
}
// MARK: - Collection View样式布局协议相关方法
extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.subviews.contains(detailView) {
            UIView.animate(withDuration: 0.5) {
                self.detailView.removeFromSuperview()
            }
        }else {
            
            let selectCell = collectionView.cellForItem(at: indexPath)
            guard let cell = selectCell else {
                return
            }
            
            let rectInCollectionView = collectionView.convert(cell.frame, to: collectionView)
            detailView.frame = CGRect.init(x: 0, y: rectInCollectionView.maxY + Constant.detailSpace, width: self.view.frame.width, height: Constant.detailHeight - (Constant.detailSpace * 2))
            detailView.backgroundColor = UIColor.randomColor
            self.collectionView.addSubview(self.detailView)
        }
        
        changeLayout(indexPath)
    }
}

extension UIColor {
    
    class var randomColor: UIColor {
        return UIColor(red: CGFloat(arc4random()%256)/255.0, green: CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 0.4)
    }
}
