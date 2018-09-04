//
//  ViewController.swift
//  HETitleView
//
//  Created by apple on 2018/9/4.
//  Copyright © 2018年 heyode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let config = HETitleViewConfig()
        let titles = ["全部","外科","内科","生殖科","耳鼻喉科","内科","眼科","口腔科"]
        let titleView = HETitleView.init(frame: CGRect.init(x: 0, y: 80, width: UIScreen.main.bounds.size.width, height: 59), titles:titles ,titleViewConfig:config)
        view.addSubview(titleView)
        titleView.titleViewClickCallBack = { selectIndex in
            NSLog("点击了:%@", titles[selectIndex])
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

