iOSSampleCode
==============
iOSSampleCode项目是一些iOS的小示例。


Installation
==============
下载运行iOSSampleCode.xcodeproj即可。


Documentation
==============
项目包含的示例：

* 处理Button的frame超出父视图bounds范围下超出部分无法响应点击
* 使用TextKit来展示exclusionPaths的使用
* 使用百度地图SDK来实现大量数据点聚合下的展示
  * 使用四叉树进行坐标数据的存储
  * 地图层级进行缩放时，将地图进行动态分割，每个区域使用平均坐标进行展示
* 模拟Apple App Store tableView内嵌collectionView，注意的几个点：
  * tableViewCell重用时不会自动reload重用的collectionView的数据
  * 保存滑动过的collectionView的位置，以便再次出现在界面时进行恢复
* 使用NSURLProtocol来加速webView Hybrid加载，既把html等静态资源打包到bundle，进行网页浏览时返回静态数据，依然可以实现需要进行网络请求的进行网络请求
  * 注意子类NSURLProtocol时，需避免拿到请求处理权后陷入无限循环递归，可以通过给request设置key来解决
  * 拿到请求处理权后如需进行网络请求，使用NSURLSession进行处理，示例注释也展示了USURLConnection的方法


Requirements
==============
部署目标iOS 7+。




