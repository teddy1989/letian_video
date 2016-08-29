//
//  RootTabBarController.m
//  letian_video
//
//  Created by 张 安乐 on 16/8/27.
//  Copyright © 2016年 com.letian.video_player. All rights reserved.
//

#import "RootTabBarController.h"
#import "BrowserViewController.h"
#import "FileManagerViewController.h"


@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpAllChildViewController];
}


- (void)setUpAllChildViewController{
    // 1.添加第一个控制器
    BrowserViewController *oneVC = [[BrowserViewController alloc]init];
    
    [self setUpOneChildViewController:oneVC normalImage:[[UIImage imageNamed:@"Home"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectImage:[[UIImage imageNamed:@"HomeActive"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  title:@"首页"];
    // 2.添加第2个控制器
    FileManagerViewController *twoVC = [[FileManagerViewController alloc]init];
    [self setUpOneChildViewController:twoVC normalImage:[[UIImage imageNamed:@"Video"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  selectImage:[[UIImage imageNamed:@"VideoActive"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]   title:@"下载管理"];
//    // 3.添加第3个控制器
//    CYXThreeViewController *threeVC = [[CYXThreeViewController alloc]init];
//    [self setUpOneChildViewController:threeVC image:[UIImage imageNamed:@"qw"] title:@"博文"];
//    // 4.添加第4个控制器
//    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"CYXFourViewController" bundle:nil];
//    CYXFourViewController *fourVC = [storyBoard instantiateInitialViewController];
//    // CYXFourViewController *fourVC = [[CYXFourViewController alloc]init];
//    [self setUpOneChildViewController:fourVC image:[UIImage imageNamed:@"user"] title:@"设置"];
}

- (void)setUpOneChildViewController:(UIViewController *)viewController normalImage:(UIImage *)normalImage selectImage:(UIImage *)selectImage title:(NSString *)title{
    UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:viewController];

    navC.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:normalImage selectedImage:selectImage];
[   navC.navigationBar setBackgroundColor:AppMainColor];
    //viewController.navigationItem.title = title;
    [self addChildViewController:navC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
