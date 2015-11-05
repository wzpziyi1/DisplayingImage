//
//  ZYNewCell.swift
//  无限循环播放图片
//
//  Created by 王志盼 on 15/11/4.
//  Copyright © 2015年 王志盼. All rights reserved.
//

import UIKit

class ZYNewCell: UICollectionViewCell {
    
    //Mark:- 存储属性
    var new: ZYNew? {
        didSet{
//            print(new?.icon)
            self.imageView.image = UIImage(named: (new?.icon)!)
            self.titleLabel.text = new?.title
        }
    }
    //MARK:- 计算属性
    
    
    //MARK:- UI属性
    private weak var imageView: UIImageView!
    private weak var titleLabel: UILabel!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commitInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commitInit()
    }
    
    private func commitInit()
    {
        let imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        self.addSubview(imageView)
        self.imageView = imageView
        
        let titleLabel = UILabel()
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.whiteColor()
        self.addSubview(titleLabel)
        self.titleLabel = titleLabel
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero)
        self.titleLabel.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero, excludingEdge: ALEdge.Bottom)
        self.titleLabel.autoSetDimension(ALDimension.Height, toSize: 30)
    }
}
