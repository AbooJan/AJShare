//
//  ThirdPartLoginUser.m
//  ShareSDKPackage
//
//  Created by 钟宝健 on 16/1/23.
//  Copyright © 2016年 钟宝健. All rights reserved.
//

#import "ThirdPartLoginUser.h"
#import <ShareSDK/ShareSDK.h>

@implementation ThirdPartLoginUser
/**
 *  重写更新信息方法，目的将社交平台的部分信息同步到用户信息中。
 *
 *  @param data 社交用户信息数据
 */
- (void)updateInfo:(SSDKUser *)data
{
    self.avatar = data.icon;
    self.nickname = data.nickname;
    
    SSDKCredential *credential = data.credential;
    if (credential) {
        self.uid = credential.uid;
        self.token = credential.token;
        self.available = credential.available;
    }
    
    NSLog(@"登录回调");
}
@end
