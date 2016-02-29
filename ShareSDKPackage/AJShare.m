//
//  AJShare.m
//  ShareSDKPackage
//
//  Created by 钟宝健 on 16/1/22.
//  Copyright © 2016年 钟宝健. All rights reserved.
//

#import "AJShare.h"
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "WeiboSDK.h"

#import <MOBFoundation/MOBFoundation.h>
#import <ShareSDKExtension/SSEShareHelper.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>

#import "ThirdPartLoginUser.h"
#import "AJShareConfig.h"


@implementation AJShare

#pragma mark - <初始化>

static AJShare *_instance;
+(AJShare *)shareInstance
{
    if (_instance == nil) {
        _instance = [[self alloc] init];
    }
    
    return _instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSDK];
    }
    return self;
}

- (void)initSDK
{
    [ShareSDK registerApp:APP_KEY_SHARE_SDK
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            ]
                 onImport:^(SSDKPlatformType platformType) {
                     
                     switch (platformType)
                     {
                         case SSDKPlatformTypeWechat:
                             [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
                             break;
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class]
                                        tencentOAuthClass:[TencentOAuth class]];
                             break;
                         case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                             break;
                         default:
                             break;
                     }
                     
                 }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              
              switch (platformType)
              {
                  case SSDKPlatformTypeSinaWeibo:
                      //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                      [appInfo SSDKSetupSinaWeiboByAppKey:APP_KEY_SINA_WEIBO
                                                appSecret:APP_SECRET_SINA_WEIBO
                                              redirectUri:SINA_CALL_BACK_URL
                                                 authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeWechat:
                      [appInfo SSDKSetupWeChatByAppId:APP_KEY_WECHAT
                                            appSecret:APP_SECRET_WECHAT];
                      break;
                  case SSDKPlatformTypeQQ:
                      [appInfo SSDKSetupQQByAppId:APP_KEY_QQ
                                           appKey:APP_SECRET_QQ
                                         authType:SSDKAuthTypeBoth];
                      break;
                  default:
                      break;
              }
          }];
}

#pragma mark - <业务逻辑>

#pragma mark 默认分享UI

- (void)shareWithTitle:(NSString *)title content:(NSString *)content url:(NSString *)url imageName:(NSString *)imageName sender:(id)sender relust:(ShareResult)result
{
    [self shareWithTitle:title content:content url:url image:[UIImage imageNamed:imageName] sender:sender relust:result];
}

- (void)shareWithTitle:(NSString *)title content:(NSString *)content url:(NSString *)url imageUrl:(NSString *)imageUrl sender:(id)sender relust:(ShareResult)result
{
    [self shareWithTitle:title content:content url:url image:imageUrl sender:sender relust:result];
}

- (void)shareWithTitle:(NSString *)title content:(NSString *)content url:(NSString *)url image:(id)image sender:(id)sender relust:(ShareResult)result
{
    // 1. 分享平台
    NSMutableArray *activePlatforms = [NSMutableArray arrayWithArray:[ShareSDK activePlatforms]];
    
    // 2. 分享
    [self shareWithPlatformArray:activePlatforms title:title content:content url:url image:image sender:sender relust:result];
}

- (void)shareWithPlatformArray:(NSArray *)platformArray title:(NSString *)title content:(NSString *)content url:(NSString *)url imageUrl:(NSString *)imageUrl sender:(id)sender relust:(ShareResult)result
{
    [self shareWithPlatformArray:platformArray title:title content:content url:url image:imageUrl sender:sender relust:result];
}

- (void)shareWithPlatformArray:(NSArray *)platformArray title:(NSString *)title content:(NSString *)content url:(NSString *)url imageName:(NSString *)imageName sender:(id)sender relust:(ShareResult)result
{
    [self shareWithPlatformArray:platformArray title:title content:content url:url image:[UIImage imageNamed:imageName] sender:sender relust:result];
}

- (void)shareWithPlatformArray:(NSArray *)platformArray title:(NSString *)title content:(NSString *)content url:(NSString *)url image:(id)image sender:(id)sender relust:(ShareResult)result
{
    // 1. 分享内容
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:content
                                     images:@[image]
                                        url:[NSURL URLWithString:url]
                                      title:title
                                       type:SSDKContentTypeAuto];
    
    // 新浪分享需要特别处理，链接必须加到内容尾部
    [shareParams SSDKSetupSinaWeiboShareParamsByText:[NSString stringWithFormat:@"%@\n%@", content, url]
                                               title:title
                                               image:image
                                                 url:nil
                                            latitude:0
                                           longitude:0
                                            objectID:nil
                                                type:SSDKContentTypeAuto];
    
    // 3. 分享
    [ShareSDK showShareActionSheet:sender
                             items:platformArray
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   [self handleResultWithStata:state err:error callback:result];
               }];
}

#pragma mark 无UI分享
- (void)shareWithType:(AJShareType)shareType title:(NSString *)title content:(NSString *)content url:(NSString *)url imageName:(NSString *)imageName sender:(id)sender relust:(ShareResult)result
{
    [self shareWithType:shareType title:title content:content url:url image:[UIImage imageNamed:imageName] sender:sender relust:result];
}

- (void)shareWithType:(AJShareType)shareType title:(NSString *)title content:(NSString *)content url:(NSString *)url imageUrl:(NSString *)imageUrl sender:(id)sender relust:(ShareResult)result
{
    [self shareWithType:shareType title:title content:content url:url image:imageUrl sender:sender relust:result];
}

- (void)shareWithType:(AJShareType)shareType title:(NSString *)title content:(NSString *)content url:(NSString *)url image:(id)image sender:(id)sender relust:(ShareResult)result
{
    // 1. 分享内容
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:content
                                     images:@[image]
                                        url:[NSURL URLWithString:url]
                                      title:title
                                       type:SSDKContentTypeAuto];
    
    // 新浪分享需要特别处理，链接必须加到内容尾部
    [shareParams SSDKSetupSinaWeiboShareParamsByText:[NSString stringWithFormat:@"%@\n%@", content, url]
                                               title:title
                                               image:image
                                                 url:nil
                                            latitude:0
                                           longitude:0
                                            objectID:nil
                                                type:SSDKContentTypeAuto];
    
    //2. 进行分享
    if (shareType == AJShareTypeSinaWeibo) {
        // 显示编辑页面
        [ShareSDK showShareEditor:(SSDKPlatformType)shareType
               otherPlatformTypes:nil
                      shareParams:shareParams
              onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                  [self handleResultWithStata:state err:error callback:result];
              }];
        
    }else{
        
        [ShareSDK share:(SSDKPlatformType)shareType
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
             [self handleResultWithStata:state err:error callback:result];
         }];
    }
}

#pragma mark 分享回调处理
- (void)handleResultWithStata:(SSDKResponseState)state err:(NSError *)error callback:(ShareResult)result
{
    switch (state) {
            
        case SSDKResponseStateSuccess:
        {
            result(YES, nil);
            break;
        }
        case SSDKResponseStateFail:
        {
            result(NO, error);
            NSLog(@"分享失败：%ld : %@", [error code], [error description]);
            break;
        }
        case SSDKResponseStateCancel:
        {
            result(NO,error);
            NSLog(@"取消分享");
            break;
        }
            
        default:
            break;
    }
}

#pragma mark -
#pragma mark 第三方登录
- (void)loginWithType:(AJPlatformType)loginType result:(LoginResult)result
{
    [SSEThirdPartyLoginHelper setUserClass:[ThirdPartLoginUser class]];
    [SSEThirdPartyLoginHelper loginByPlatform:(SSDKPlatformType)loginType
                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
                                       
                                       //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
                                       associateHandler (user.uid, user, user);
                                       
                                       NSLog(@"绑定回调：%@", [user description]);
                                   }
                                onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
                                    
                                    if (state == SSDKResponseStateSuccess)
                                    {
                                        result(YES, user, nil);
                                    }
                                    else
                                    {
                                        result(NO,user,error);
                                        NSLog(@"登录失败: %ld - %@", [error code], [error description]);
                                    }
                                    
                                }];
}

- (void)logout:(SSEBaseUser *)user
{
    [SSEThirdPartyLoginHelper logout:user];
}

- (void)readUserInfoWithType:(AJPlatformType)platformType result:(ReadUserInfoResult)result
{
    [ShareSDK getUserInfo:(SSDKPlatformType)platformType onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess) {
            result(YES, user, nil);
        }else{
            result(NO, nil, error);
        }
    }];
}

- (void)cancelAuthorizeWithType:(AJPlatformType)platformType
{
    if ([ShareSDK hasAuthorized:(SSDKPlatformType)platformType]) {
        [ShareSDK cancelAuthorize:(SSDKPlatformType)platformType];
    }else{
        NSLog(@"没有授权");
    }
}

- (BOOL)checkLoginPlatform:(AJPlatformType)platformType
{
    BOOL isInstalled = [ShareSDK isClientInstalled:(SSDKPlatformType)platformType];
    
    return isInstalled;
}

@end
