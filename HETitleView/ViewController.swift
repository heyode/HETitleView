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
        let titleLab = UILabel.init(frame: CGRect.init(x: (UIScreen.main.bounds.width - 300)/2, y: 200, width: 300, height: 30))
        titleLab.textAlignment = .center
        titleLab.text = "title"
        titleLab.textColor = UIColor.init(red: 22.0/255.0, green: 157.0/255.0, blue: 240.0/255.0, alpha: 1)
        view.addSubview(titleLab)
        
        let config = HETitleViewConfig()
        config.indicatorViewWidthType = .adaptivelyWidth 
        let titles = ["全部","外科","内科","生殖科","耳鼻喉科","内科","眼科","口腔科"]
        
        let titleView = HETitleView.init(frame: CGRect.init(x: 0, y: 80, width: UIScreen.main.bounds.size.width, height: 59),
                                         titles:titles,
                                         titleViewConfig:config)
        
        view.addSubview(titleView)
        
        
        titleView.titleViewClickCallBack = { selectIndex in
           titleLab.text = titles[selectIndex]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

