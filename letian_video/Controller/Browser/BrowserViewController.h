//
//  BrowserViewController.h
//  letian_video
//
//  Created by 张 安乐 on 16/8/27.
//  Copyright © 2016年 com.letian.video_player. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface BrowserViewController: UIViewController <UISearchBarDelegate, WKNavigationDelegate>;
- (IBAction)buttonPress:(id) sender;
- (void)loadWebPageWithUrl:(NSURL*)url;
@end
