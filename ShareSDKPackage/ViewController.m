//
//  ViewController.m
//  ShareSDKPackage
//
//  Created by 钟宝健 on 16/1/22.
//  Copyright © 2016年 钟宝健. All rights reserved.
//

#import "ViewController.h"
#import "AJShare.h"
#import "ThirdPartLoginUser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - <分享部分>

- (IBAction)allShareBtnClick:(UIButton *)sender
{
    // 全平台分享
    NSString *titleStr = @"兼职猫,喵了个咪!";
    NSString *contentStr = @"这是分享内容测试，测试内容，测试~";
    NSString *imgName = @"default_share_pic";
    NSString *url = @"http://www.jianzhimao.com";
    NSString *imgUrl = @"http://oss.aliyuncs.com/jianzhimao/jzmao/qiye/1702487/1449231769684_logo.jpg";
    
//    [[AJShare shareInstance] shareWithTitle:titleStr content:contentStr url:url imageName:imgName sender:sender relust:^(BOOL success, NSError *error) {
//        if (success) {
//            NSLog(@"分享成功");
//        }
//    }];
    
    [[AJShare shareInstance] shareWithTitle:titleStr content:contentStr url:url imageUrl:imgUrl sender:sender relust:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"分享成功");
        }
    }];
}


- (IBAction)sinaShareBtnClick:(UIButton *)sender
{
    // 新浪分享
    NSString *titleStr = @"兼职猫,喵了个咪!";
    NSString *contentStr = @"这是分享内容测试，测试内容，测试~";
    NSString *imgName = @"default_share_pic";
    NSString *url = @"http://www.jianzhimao.com";
    NSString *imgUrl = @"http://oss.aliyuncs.com/jianzhimao/jzmao/qiye/1702487/1449231769684_logo.jpg";
    
    [[AJShare shareInstance] shareWithType:AJShareTypeSinaWeibo title:titleStr content:contentStr url:url imageName:imgName sender:sender relust:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"分享成功");
        }
    }];
    
//    [[AJShare shareInstance] shareWithType:AJShareTypeSinaWeibo title:titleStr content:contentStr url:url imageUrl:imgUrl sender:sender relust:^(BOOL success, NSError *error) {
//        if (success) {
//            NSLog(@"分享成功");
//        }
//    }];
}
- (IBAction)qqShareBtnClick:(id)sender
{
    // QQ分享
    NSString *titleStr = @"兼职猫,喵了个咪!";
    NSString *contentStr = @"这是分享内容测试，测试内容，测试~";
    NSString *imgName = @"default_share_pic";
    NSString *url = @"http://www.jianzhimao.com";
    NSString *imgUrl = @"http://oss.aliyuncs.com/jianzhimao/jzmao/qiye/1702487/1449231769684_logo.jpg";
    
    [[AJShare shareInstance] shareWithType:AJShareTypeQQ title:titleStr content:contentStr url:url imageName:imgName sender:sender relust:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"分享成功");
        }
    }];
}
- (IBAction)qzoneShareBtnClick:(id)sender
{
    // QQ空间分享
    NSString *titleStr = @"兼职猫,喵了个咪!";
    NSString *contentStr = @"这是分享内容测试，测试内容，测试~";
    NSString *imgName = @"default_share_pic";
    NSString *url = @"http://www.jianzhimao.com";
    NSString *imgUrl = @"http://oss.aliyuncs.com/jianzhimao/jzmao/qiye/1702487/1449231769684_logo.jpg";
    
    [[AJShare shareInstance] shareWithType:AJShareTypeQZone title:titleStr content:contentStr url:url imageName:imgName sender:sender relust:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"分享成功");
        }
    }];
}
- (IBAction)wechatShareBtnClick:(UIButton *)sender
{
    // 微信分享
    NSString *titleStr = @"兼职猫,喵了个咪!";
    NSString *contentStr = @"这是分享内容测试，测试内容，测试~";
    NSString *imgName = @"default_share_pic";
    NSString *url = @"http://www.jianzhimao.com";
    NSString *imgUrl = @"http://oss.aliyuncs.com/jianzhimao/jzmao/qiye/1702487/1449231769684_logo.jpg";
    
    [[AJShare shareInstance] shareWithType:AJShareTypeWeChatFriends title:titleStr content:contentStr url:url imageName:imgName sender:sender relust:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"分享成功");
        }
    }];
}
- (IBAction)wechatFriendsShareBtnClick:(UIButton *)sender
{
    // 朋友圈分享
    NSString *titleStr = @"兼职猫,喵了个咪!";
    NSString *contentStr = @"这是分享内容测试，测试内容，测试~";
    NSString *imgName = @"default_share_pic";
    NSString *url = @"http://www.jianzhimao.com";
    NSString *imgUrl = @"http://oss.aliyuncs.com/jianzhimao/jzmao/qiye/1702487/1449231769684_logo.jpg";
    
    [[AJShare shareInstance] shareWithType:AJShareTypeWeChatTimeLine title:titleStr content:contentStr url:url imageName:imgName sender:sender relust:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"分享成功");
        }
    }];
}
- (IBAction)wechatFavShareBtnClick:(id)sender
{
    // 微信收藏
    NSString *titleStr = @"兼职猫,喵了个咪!";
    NSString *contentStr = @"这是分享内容测试，测试内容，测试~";
    NSString *imgName = @"default_share_pic";
    NSString *url = @"http://www.jianzhimao.com";
    NSString *imgUrl = @"http://oss.aliyuncs.com/jianzhimao/jzmao/qiye/1702487/1449231769684_logo.jpg";
    
    [[AJShare shareInstance] shareWithType:AJShareTypeWeChatFav title:titleStr content:contentStr url:url imageName:imgName sender:sender relust:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"分享成功");
        }
    }];
}

#pragma mark - <登录授权部分>

- (IBAction)sinaWeiboLoginBtnClcik:(UIButton *)sender
{
    // 微博登录
    
    [[AJShare shareInstance] loginWithType:AJPlatformTypeSinaWeibo result:^(BOOL success, SSEBaseUser *user, NSError *error) {
       
        if (success) {
            NSLog(@"登录成功\n========");
            NSLog(@"%@", [user linkId]);
            NSLog(@"%@", [user socialUsers]);
            NSLog(@"========");
            
            ThirdPartLoginUser *thirdUser = (ThirdPartLoginUser *)user;
            NSLog(@"$$$$::%@", [thirdUser description]);
        }
        
    }];
    
}
- (IBAction)qqLoginBtnClick:(UIButton *)sender
{
    // QQ登录
    [[AJShare shareInstance] loginWithType:AJPlatformTypeQQ result:^(BOOL success, SSEBaseUser *user, NSError *error) {
        
        if (success) {
            NSLog(@"登录成功\n========");
            NSLog(@"%@", [user linkId]);
            NSLog(@"%@", [user socialUsers]);
            NSLog(@"========");
            
            ThirdPartLoginUser *thirdUser = (ThirdPartLoginUser *)user;
            NSLog(@"$$$$::%@", [thirdUser description]);
        }
        
    }];
}
- (IBAction)wechatLoginBtnClcik:(UIButton *)sender
{
    // 微信登录
    [[AJShare shareInstance] loginWithType:AJPlatformTypeWeChat result:^(BOOL success, SSEBaseUser *user, NSError *error) {
        
        if (success) {
            NSLog(@"登录成功\n========");
            NSLog(@"%@", [user linkId]);
            NSLog(@"%@", [user socialUsers]);
            NSLog(@"========");
            
            ThirdPartLoginUser *thirdUser = (ThirdPartLoginUser *)user;
            NSLog(@"$$$$::%@", [thirdUser description]);
        }
        
    }];
}

#pragma mark - <信息获取>
- (IBAction)sinaWeiboBtnClick:(UIButton *)sender
{
    [[AJShare shareInstance] readUserInfoWithType:AJPlatformTypeSinaWeibo result:^(BOOL success, SSDKUser *user, NSError *error) {
       
        if (success) {
            NSLog(@"获取信息成功");
            NSLog(@"==============");
            NSLog(@"%@", [user description]);
            NSLog(@"==============");
        }
        
    }];
}
- (IBAction)qqBtnCLick:(UIButton *)sender
{
    [[AJShare shareInstance] readUserInfoWithType:AJPlatformTypeQQ result:^(BOOL success, SSDKUser *user, NSError *error) {
        
        if (success) {
            NSLog(@"获取信息成功");
            NSLog(@"==============");
            NSLog(@"%@", [user description]);
            NSLog(@"==============");
        }
        
    }];
}
- (IBAction)wechatBtnClick:(UIButton *)sender
{
    [[AJShare shareInstance] readUserInfoWithType:AJPlatformTypeWeChat result:^(BOOL success, SSDKUser *user, NSError *error) {
        
        if (success) {
            NSLog(@"获取信息成功");
            NSLog(@"==============");
            NSLog(@"%@", [user description]);
            NSLog(@"==============");
        }
        
    }];
}



@end
