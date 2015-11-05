//
//  ViewController.swift
//  无限循环播放图片
//
//  Created by 王志盼 on 15/11/4.
//  Copyright © 2015年 王志盼. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    weak var displayingView: ZYImageDisplayingView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        let displayingView = ZYImageDisplayingView()
        self.view.addSubview(displayingView)
        self.displayingView = displayingView
        self.displayingView.frame = CGRectMake(50, 100, 300, 130)
    }
    
}

