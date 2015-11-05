//
//  ZYImageDisplayingView.swift
//  无限循环播放图片
//
//  Created by 王志盼 on 15/11/4.
//  Copyright © 2015年 王志盼. All rights reserved.
//

import UIKit

class ZYImageDisplayingView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK:- 常量
    private let identifier = "ZYNewCell"
    
    //MARK:- 存储属性
    override var frame: CGRect{
        didSet{
            if (self.collectionView != nil) {
                self.collectionView?.removeFromSuperview()
            }
            
            if (frame.width == 0.0 && frame.height == 0.0 && frame.origin.x == 0.0 && frame.origin.y == 0.0) {
                return
            }
            
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = frame.size
            layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
            layout.minimumLineSpacing = 0
            let collectionView = UICollectionView(frame: CGRectMake(0, 0, frame.width, frame.height), collectionViewLayout: layout)
            collectionView.registerClass(ZYNewCell.self, forCellWithReuseIdentifier: identifier)
            collectionView.showsHorizontalScrollIndicator = false
            self.addSubview(collectionView)
            self.collectionView = collectionView
            
            self.collectionView!.delegate = self
            self.collectionView!.dataSource = self
            self.collectionView!.backgroundColor = UIColor.whiteColor()
            self.collectionView!.pagingEnabled = true
            
            self.collectionView!.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: ZYImageGroups / 2), atScrollPosition: UICollectionViewScrollPosition.None, animated: false)
            
            self.bringSubviewToFront(pageControl)
            self.addTimer()
        }
    }
    
    var news = ZYNew.getNews()
    
    var timer: NSTimer?
    
    //MARK:- 计算属性
    
    
    //MARK:- UI控件
    weak var collectionView: UICollectionView?
    weak var pageControl: UIPageControl!
    
    //MARK:- 初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commitInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commitInit()
        
    }
    
    private func commitInit(){
        self.backgroundColor = UIColor.yellowColor()
        var pageControl = UIPageControl()
        pageControl.numberOfPages = self.news.count
        pageControl.pageIndicatorTintColor = UIColor.redColor()
        pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
        self.addSubview(pageControl)
        self.pageControl = pageControl
        
        
    }
    
    //MARK:- UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return ZYImageGroups
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.news.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell:ZYNewCell? = collectionView.dequeueReusableCellWithReuseIdentifier(self.identifier, forIndexPath: indexPath) as? ZYNewCell
        if (cell == nil) {
            cell = ZYNewCell()
        }
//        print(self.news[indexPath.row])
        cell?.new = self.news[indexPath.row]
        return cell!
    }
    
    
    //MARK:- UIScrollViewDelegate
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.removeTimer()
    }
    
    //当scrollView减速完毕时调用，最好是在这个时候添加定时器
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.addTimer()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let size = scrollView.contentOffset
//        print(size)
        self.pageControl.currentPage = Int(size.x / (self.collectionView?.frame.width)! + 0.5) % self.news.count
    }
    
    //MARK:- 定时器处理
    func addTimer()
    {
        self.removeTimer()
        self.timer = NSTimer(timeInterval: 2, target: self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(self.timer!, forMode: NSRunLoopCommonModes)
    }
    
    func removeTimer()
    {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func updateTimer()
    {
        let currentIndexPath = self.resetIndexPath()
        
        var section = currentIndexPath.section
        var row = currentIndexPath.row + 1
        
        
        if (row == self.news.count) {
            row = 0
            section++
        }
        self.collectionView?.scrollToItemAtIndexPath(NSIndexPath(forItem: row, inSection: section), atScrollPosition: UICollectionViewScrollPosition.None, animated: true)
    }
    
    func resetIndexPath() -> NSIndexPath
    {
        let currentIndexPath = self.collectionView?.indexPathsForVisibleItems().first
        
        self.collectionView?.scrollToItemAtIndexPath(NSIndexPath(forItem: (currentIndexPath?.row)!, inSection: ZYImageGroups / 2), atScrollPosition: UICollectionViewScrollPosition.None, animated: false)
        return NSIndexPath(forItem: (currentIndexPath?.row)!, inSection: ZYImageGroups / 2)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.pageControl.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 8)
        self.pageControl.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 20)
        self.pageControl.autoSetDimensionsToSize(CGSizeMake(100, 20))
    }
}
