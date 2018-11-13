# HETitleView
- 高度自定义的，简单的，可以滑动的TitleView（类似今日头条，网易新闻头部分类标签）
- 可使用HETitleViewConfig对样式做自定义的配置，详见HETitleViewConfig。

## 使用
### 创建视图
```Swift
        let config = HETitleViewConfig()
        
        let titles = ["全部","外科","内科","生殖科","耳鼻喉科","内科","眼科","口腔科"]
        
        let titleView = HETitleView.init(frame: CGRect.init(x: 0, y: 80, width: UIScreen.main.bounds.size.width, height: 59),
                                         titles:titles,
                                         titleViewConfig:config)
```
### 点击事件
```Swift
        titleView.titleViewClickCallBack = { selectIndex in
           titleLab.text = titles[selectIndex]
        }
```
### 可自定义的参数
```Swift
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
```
## 效果图
![image](https://github.com/heyode/HETitleView/blob/master/demo.gif)
