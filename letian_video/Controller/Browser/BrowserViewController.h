//
//  BrowserViewController.h
//  letian_video
//
//  Created by 张 安乐 on 16/8/27.
//  Copyright © 2016年 com.letian.video_player. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowserViewController: UIViewController<UIWebViewDelegate>{
    IBOutlet UIWebView *videoWebView;
    IBOutlet UITextField *urlTextField;
    UIActivityIndicatorView *activityIndicatorView;
}
- (IBAction)buttonPress:(id) sender;
- (void)loadWebPageWithString:(NSString*)urlString;
@end
