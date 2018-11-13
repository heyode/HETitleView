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
## 效果图
![image](https://github.com/heyode/HETitleView/blob/master/demo.gif)
