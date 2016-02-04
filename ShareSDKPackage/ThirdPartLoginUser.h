//
//  ThirdPartLoginUser.h
//  ShareSDKPackage
//
//  Created by 钟宝健 on 16/1/23.
//  Copyright © 2016年 钟宝健. All rights reserved.
//

#import <ShareSDKExtension/SSEBaseUser.h>

@interface ThirdPartLoginUser : SSEBaseUser
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *token;
/// 标识授权是否可用，YES 可用， NO 已过期
@property (nonatomic, assign) BOOL available;
@end
