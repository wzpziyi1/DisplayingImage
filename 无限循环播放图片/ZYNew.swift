//
//  ZYNew.swift
//  无限循环播放图片
//
//  Created by 王志盼 on 15/11/4.
//  Copyright © 2015年 王志盼. All rights reserved.
//

class ZYNew: NSObject {
    var icon: String!
    var title: String!
    
    init(dict: Dictionary<String, String>) {
        super.init()
        self.icon = dict["icon"]
        self.title = dict["title"]
    }
    
    class func getNews() -> Array<ZYNew>
    {
        let path = NSBundle.mainBundle().pathForResource("newses.plist", ofType: nil)
        let originArray: NSArray? = NSArray(contentsOfFile: path!)
        var news = Array<ZYNew>()
        originArray?.enumerateObjectsUsingBlock({ (obj: AnyObject, index: Int, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
            let tmp = ZYNew(dict: obj as! Dictionary<String, String>)
            news.append(tmp)
        })
        return news
    }
}
