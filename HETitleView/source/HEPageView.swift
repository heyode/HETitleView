//
//  HEPageView.swift
//  PageView
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 heyode. All rights reserved.
//

import UIKit
class HETitleViewConfig : NSObject{
    // 是否显示指示器
    open var showIndicator : Bool = true
    // 是否显示底部分割线
    open var showBottomLineView : Bool = true
    // 是否显示右侧有隐藏内容的标识
    open var showRightImageView : Bool = true
    // 指示器的宽度类型
    open var indicatorViewWidthType = HETitleViewIndicatorViewWidth.adaptivelyWidth
    // 指示器到底部分割线的距离
    open var indicatorViewBottomToBottomLineMargin : CGFloat = 8
    // 在文字内容宽度再加上额外的宽度（只在indicatorViewWidthType=.adaptivelyWidth生效）
    open var indicatorViewAdditionalWith : CGFloat  = 0
    // 指示器的固定宽度（只在indicatorViewWidthType=.fixedWidthin生效）
    open var indicatorViewWidth : CGFloat = 20
    // 指示器的高度
    open var indicatorViewHeight : CGFloat = 2
    // 指示器背景色
    open var indicatorViewBackgroudColor  : UIColor = UIColor.init(red: 22.0/255.0, green: 157.0/255.0, blue: 240.0/255.0, alpha: 1)
    // 每次点击指示器的滑动时间
    open var indicatorViewAnimation : Double = 0.25
    // 指示器圆角度数
    open var indicatorViewRadius : CGFloat = 0
    // 底部分割线的高度
    open var bottomLineViewHeight : CGFloat = 1
    // 底部分割线的背景色
    open var bottomLineViewBackgroudColor : UIColor = UIColor.init(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1)
    // title的字体
    open var titleFont = UIFont.systemFont(ofSize: 15)
    // title的颜色
    open var titleColor = UIColor.init(red: 30.0/255.0, green: 46/255.0, blue: 68/255.0, alpha:1)
    // title被选中时的颜色
    open var selectedTitleColor = UIColor.init(red: 22.0/255.0, green: 157.0/255.0, blue: 240.0/255.0, alpha: 1)
    // title除去文字，剩余的margin宽度
    open var titleAdditionalWith : CGFloat = 30
    // scrollView水平方向的左右内边距
    open var scrollViewHorizontalMargin : CGFloat = 20
    
}
enum HETitleViewIndicatorViewWidth {
    case fixedWidth
    case adaptivelyWidth
}

class HETitleView: UIView {
    typealias titleViewBlock = (_ selectedIndex:Int)->Void
    // 点击title的回调
    open var titleViewClickCallBack : titleViewBlock?
    private var config = HETitleViewConfig()
    private let btnBaseTag = 400
    private var titlesArr:[String]?
    private var titleWidthsArr : [CGFloat]?
    private var preBtn = UIButton()
    private var totalTitleBtnWidth : CGFloat = 0.0
    private lazy var bottomLineView : UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: self.frame.size.height - config.bottomLineViewHeight, width: self.frame.width, height: config.bottomLineViewHeight))
        view.backgroundColor = config.bottomLineViewBackgroudColor
        return view
    }()
    private lazy var rightImageView: UIView = {
        let view = UIView(frame: CGRect(x:self.bounds.width - 18 - config.scrollViewHorizontalMargin , y: 0.5 * (self.frame.height - 50), width: 18, height: 50))
        let image = UIImageView.init(image: UIImage.init(named: "HEPageView.bundle/nav_mask"))
        image.frame = CGRect.init(x: 0, y: 12.5, width: 18, height: 24)
        
        view.backgroundColor = UIColor.clear
        view.addSubview(image)
        return view
    }()
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x:config.scrollViewHorizontalMargin, y: 0, width: self.bounds.width - 2 * config.scrollViewHorizontalMargin, height: self.bounds.height))
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
    }()
    private lazy var indicatorView :UIView = {
        var width : CGFloat  = 0.0
        if config.indicatorViewWidthType == .fixedWidth {
            width = config.indicatorViewWidth
        }else{
            if let  textW = titleWidthsArr?.first{
                width = textW + config.indicatorViewAdditionalWith
            }
        }
        
        let lineView = UIView.init(frame:CGRect.init(x: 0, y: self.frame.size.height - config.indicatorViewHeight - config.bottomLineViewHeight - config.indicatorViewBottomToBottomLineMargin, width: width, height: config.indicatorViewHeight))
        if config.indicatorViewRadius > 0{
            lineView.layer.cornerRadius = config.indicatorViewRadius
            lineView.layer.masksToBounds = true
        }
        lineView.backgroundColor = config.indicatorViewBackgroudColor
        return lineView
    }()
    
    init(frame: CGRect ,titles:[String]?,titleViewConfig:HETitleViewConfig) {
        titlesArr = titles
        config = titleViewConfig
        super.init(frame: frame)
        setSubView()
    }
    
    private func setSubView()  {
        addSubview(scrollView)
        setTitleBtns()
        if config.showIndicator {
            self.scrollView.addSubview(indicatorView)
        }
        if config.showIndicator{
            self.addSubview(bottomLineView)
        }
        if config.showRightImageView{
            self.addSubview(rightImageView)
        }
    }
    
    private func setTitleBtns()  {
        guard titlesArr != nil else {
            return
        }
        var btnX : CGFloat = 0
        titleWidthsArr = [CGFloat]()
        for (index,title) in titlesArr!.enumerated(){
            let titleButton = UIButton.init(type: .custom)
            
            let textW = title.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height:  self.bounds.height), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : config.titleFont ], context: nil).size.width
            
            titleWidthsArr?.append(textW)
            titleButton.tag = btnBaseTag + index
            titleButton.setTitle(title, for: UIControlState.normal)
            titleButton.setTitleColor(config.selectedTitleColor, for:.selected)
            titleButton.titleLabel?.font = config.titleFont
            titleButton.setTitleColor(config.titleColor, for: .normal)
            
            let btnW = textW + config.titleAdditionalWith
            totalTitleBtnWidth += btnW
            titleButton.frame  = CGRect.init(x:btnX, y: 0,  width: btnW,height: self.frame.size.height )
            btnX = titleButton.frame.origin.x + btnW
            scrollView.addSubview(titleButton)
            
            titleButton.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
            if(index == 0){
                titleButton.isSelected = true
                preBtn = titleButton
                btnClick(btn: titleButton)
            }
        }
        
        scrollView.contentSize = CGSize.init(width: totalTitleBtnWidth, height: self.scrollView.frame.height)
    }
    
    @objc private func btnClick(btn : UIButton){
        preBtn.isSelected = false
        btn.isSelected = !btn.isSelected
        if let callBack = titleViewClickCallBack{
            callBack(btn.tag - btnBaseTag)
        }
        if config.indicatorViewWidthType == .adaptivelyWidth {
            if let width = titleWidthsArr?[btn.tag - btnBaseTag] {
                indicatorView.frame.size.width  =  config.indicatorViewWidth + width
            }
        }
        setIndicatorViewCenter(btn: btn)
        setScrollViewConentOffset(btn: btn)
        preBtn = btn
    }
    
    private func setScrollViewConentOffset(btn:UIButton) {
        //  滚动的距离
        var margin = btn.frame.origin.x - 0.5 * scrollView.bounds.width
        if margin > scrollView.contentSize.width - scrollView.bounds.width{
            margin = scrollView.contentSize.width - scrollView.bounds.width
        }
        
        if margin > 0 {
            scrollView.setContentOffset(CGPoint(x: margin, y: 0), animated: true)
        }else{
            scrollView.setContentOffset(CGPoint(x: 0 , y: 0), animated: true)
        }
        
    }
    
    private func setIndicatorViewCenter(btn:UIButton){
        UIView.animate(withDuration: config.indicatorViewAnimation) {
            var center = btn.center;
            center.y = self.indicatorView.center.y
            self.indicatorView.center = center
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
