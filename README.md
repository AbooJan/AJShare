# AJShare
ShareSDK集成，简单的封装

---
## 接口

```
/**
 *  全平台分享
 *
 *  @param title     分享标题
 *  @param content   分享内容
 *  @param url       分享URL
 *  @param imageName 分享图片名称，注意：图片必须要在Xcode左边目录里面，名称必须要传正确
 *  @param sender    分享触发View
 *  @param result    分享回调Block
 */
- (void)shareWithTitle:(NSString *)title content:(NSString *)content url:(NSString *)url imageName:(NSString *)imageName sender:(id)sender relust:(ShareResult)result;

/**
 *  全平台分享
 *
 *  @param title    分享标题
 *  @param content  分享内容
 *  @param url      分享URL
 *  @param imageUrl 分享图片链接
 *  @param sender   分享触发View
 *  @param result   分享回调Block
 */
- (void)shareWithTitle:(NSString *)title content:(NSString *)content url:(NSString *)url imageUrl:(NSString *)imageUrl sender:(id)sender relust:(ShareResult)result;


/**
 *  无UI目标平台分享
 *
 *  @param shareType 分享平台
 *  @param title     分享标题
 *  @param content   分享内容
 *  @param url       分享URL
 *  @param imageUrl  分享图片链接
 *  @param sender    分享触发View
 *  @param result    分享结果回调Block
 */
- (void)shareWithType:(AJShareType)shareType title:(NSString *)title content:(NSString *)content url:(NSString *)url imageUrl:(NSString *)imageUrl sender:(id)sender relust:(ShareResult)result;

/**
 *  无UI目标平台分享
 *
 *  @param shareType 分享平台
 *  @param title     分享标题
 *  @param content   分享内容
 *  @param url       分享URL
 *  @param imageName 分享图片名称，注意：图片必须要在Xcode左边目录里面，名称必须要传正确
 *  @param sender    分享触发View
 *  @param result    分享结果回调Block
 */
- (void)shareWithType:(AJShareType)shareType title:(NSString *)title content:(NSString *)content url:(NSString *)url imageName:(NSString *)imageName sender:(id)sender relust:(ShareResult)result;


/**
 *  第3方登录
 *
 *  @param loginType 登录平台
 *  @param result    回调结果
 */
- (void)loginWithType:(AJPlatformType)loginType result:(LoginResult)result;

/**
 *  退出登录
 *
 *  @param user 已登录用户
 */
- (void)logout:(SSEBaseUser *)user;

/**
 *  读取用户信息
 *
 *  @param platformType 平台类型
 *  @param result       回调结果Block
 */
- (void)readUserInfoWithType:(AJPlatformType)platformType result:(ReadUserInfoResult)result;

/**
 *  检查第三方登录客户端是否安装
 *
 *  @param platformType 登录平台
 *
 *  @return YES，安装；NO，没有安装
 */
- (BOOL)checkLoginPlatform:(AJPlatformType)platformType;
```