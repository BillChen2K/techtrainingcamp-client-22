# NewsBoard
字节跳动客户端训练营小组项目（techtrainingcamp-client-22）：实现一个信息公告板。

<img src="https://billc.oss-cn-shanghai.aliyuncs.com/img/2020-11-25-C82eAb.png" alt="image-20201125170756548" style="zoom:33%;" />

## 完成功能
### 基础功能

- 实现了主页静态展示页面，支持 4 种格式的新闻展示。

### 进阶功能：

- 进阶功能 1 - 纯文本格式展示：已实现，公告展示的效果图如下：

  <img src="https://billc.oss-cn-shanghai.aliyuncs.com/img/2020-11-25-LESnW8.png" alt="image-20201125171046325" style="zoom:33%;" />

- 进阶功能 2 - 用户登录：已完成。可以在主页信息流的右上角点击进入用户个人中心页面，实现登录和登出。

  <img src="https://billc.oss-cn-shanghai.aliyuncs.com/img/2020-11-25-rAe0xV.png" alt="image-20201125171229842" style="zoom:33%;" />

  <img src="https://billc.oss-cn-shanghai.aliyuncs.com/img/2020-11-25-of7sk1.png" alt="image-20201125170840806" style="zoom:33%;" />

- 进阶功能 3 - 图文混排和 Markdown 格式展示：已实现，效果图如下：

  <img src="https://billc.oss-cn-shanghai.aliyuncs.com/img/2020-11-25-sBwwKO.png" alt="image-20201125171344330" style="zoom:33%;" />

在完成了以上要求功能的基础上，我们还实现了以下额外的功能：

- 使用原生 SwiftUI 和 Swift 开发，适配了 iPhone 和 iPad。所以同时还支持使用 MacCatalyst 直接在 macOS 11.0 及更高版本上运行：

![image-20201125173340403](https://billc.oss-cn-shanghai.aliyuncs.com/img/2020-11-25-ClORKn.png)

- 开发的过程中注意了颜色的两种配置，在 macOS 和 iOS 上均支持暗黑模式显示：

![image-20201125173436699](https://billc.oss-cn-shanghai.aliyuncs.com/img/2020-11-25-PDr9E2.png)

- 用户系统支持记住用户名和密码。如果在登录时勾选了 Remember，则用户下次启动应用程序时无需再登录，可以直接浏览公告。
- 错误信息的提示与处理：在遇到网络超时、服务器问题、凭据过期等情况时，APP 均会有相应提示指引用户做出操作。

## 技术实现



---

2020 年 11 月