//
//  BrowserViewController.m
//  letian_video
//
//  Created by 张 安乐 on 16/8/27.
//  Copyright © 2016年 com.letian.video_player. All rights reserved.
//

#import "BrowserViewController.h"
#import <WebKit/WebKit.h>

@interface BrowserViewController ()
@property(strong,nonatomic)WKWebView* videoWebView;
@property(strong,nonatomic)UISearchBar* urlSearchBar;
@property(strong,nonatomic)UIActivityIndicatorView* activityIndicatorView;

@end

@implementation BrowserViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self view]setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}





-(void)initView{
    self.navigationController.navigationBarHidden = true;
    self.navigationController.navigationBar.translucent = NO;
    
    
    
    NSInteger textHeight=44;
    NSInteger tabbarHeight=49;
    
    self.urlSearchBar = [[UISearchBar alloc] init];
    [[self urlSearchBar ] setDelegate:self];
    [[self urlSearchBar ] setReturnKeyType:UIReturnKeyGo];
    [[self urlSearchBar ] setText:@"www.baidu.com"];
    [[self urlSearchBar ] setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [[self urlSearchBar ] setAutocorrectionType:UITextAutocorrectionTypeNo];
    [[self urlSearchBar ] setBackgroundColor:[UIColor whiteColor]];
    [[self urlSearchBar ] setKeyboardType:UIKeyboardTypeURL];
    [[self urlSearchBar ] setPlaceholder:@"请输入你要访问的网址"];
    [[self urlSearchBar ].layer setMasksToBounds:YES];
    [[self urlSearchBar ].layer setBorderWidth:0.5];
    [[self urlSearchBar ].layer setBorderColor:[[UIColor colorWithWhite:0.5 alpha:0.3] CGColor]];
    
    
    // 添加蒙版
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    aView.backgroundColor = [UIColor clearColor];
    aView.alpha = 0.1;
    [self.view addSubview:aView];
    aView.tag = 10;
    
    //［urlField ］
    
    [[self view]addSubview:[self urlSearchBar ]];
    
    self.videoWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, textHeight, self.view.frame.size.width, self.view.frame.size.height-textHeight-tabbarHeight)];
    [[self videoWebView ] setNavigationDelegate:self];
    [[self videoWebView ] setOpaque:NO];
    [[self videoWebView] setAllowsBackForwardNavigationGestures:YES];
    
    
    
    
    [[self urlSearchBar ] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(20);
    }];
    
    [[self view]addSubview:[self videoWebView ]];
    
    [[self videoWebView ] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.width.equalTo(self.view);
        make.top.equalTo([self urlSearchBar ].mas_bottom);
        make.bottom.equalTo(self.view).offset(-44);
    }];
    
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc]
                                  initWithFrame : CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)] ;
    [[self activityIndicatorView ] setCenter: self.view.center] ;
    [[self activityIndicatorView ] setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleWhite] ;
    [self.view addSubview : [self activityIndicatorView ]] ;
    
    [self loadFirstPage];
}

#pragma mark - searchBar代理方法
// 添加Cancel：

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    UIView *aView = [self.view viewWithTag:10];
    // 移除蒙版
    [aView removeFromSuperview];
}
/// 点击搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    
    UIView *aView = [self.view viewWithTag:10];
    [aView removeFromSuperview];
    [self loadFirstPage];
}

-(void )loadFirstPage{
    // 创建url
    NSURL *url = nil;
    NSString *urlStr = [[self urlSearchBar] text];
    
    // 如果file://则为打开bundle本地文件，http则为网站，否则只是一般搜索关键字
    if([urlStr hasPrefix:@"file://"]){
        NSRange range = [urlStr rangeOfString:@"file://"];
        NSString *fileName = [urlStr substringFromIndex:range.length];
        url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        // 如果是模拟器加载电脑上的文件，则用下面的代码
        //        url = [NSURL fileURLWithPath:fileName];
    }else if(urlStr.length>0){
        if ([urlStr hasPrefix:@"http://"]) {
            url=[NSURL URLWithString:urlStr];
        } else {
            urlStr=[NSString stringWithFormat:@"http://www.baidu.com/s?wd=%@",urlStr];
        }
        urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        url=[NSURL URLWithString:urlStr];
    }
    [self loadWebPageWithUrl:url];
}


- (void)loadWebPageWithUrl:(NSURL*)url
{
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [[self videoWebView ] loadRequest:request];
}



/// 接收到服务器跳转请求之后调用 (服务器端redirect)，不一定调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"didReceiveServerRedirectForProvisionalNavigation");
    //NSLog(@"%@",navigation);
}

/// 1 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSLog(@"decidePolicyForNavigationAction");
    NSString *urlString = [[navigationAction.request URL] absoluteString];
    
    urlString = [urlString stringByRemovingPercentEncoding];
    //    NSLog(@"urlString=%@",urlString);
    // 用://截取字符串
    NSArray *urlComps = [urlString componentsSeparatedByString:@"://"];
    if ([urlComps count]) {
        // 获取协议头
        NSString *protocolHead = [urlComps objectAtIndex:0];
        NSLog(@"protocolHead=%@",protocolHead);
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}




/// 2 页面开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"%s", __FUNCTION__);
    //NSLog(@"%@",navigation);
    [[self activityIndicatorView]  startAnimating] ;
}

/// 3 在收到服务器的响应头，根据response相关信息，决定是否跳转。decisionHandler必须调用，来决定是否跳转，参数WKNavigationActionPolicyCancel取消跳转，WKNavigationActionPolicyAllow允许跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSLog(@"%s", __FUNCTION__);
    // 允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //NSLog(@"%@",webView);
}

/// 4 开始获取到网页内容时返回
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"%s", __FUNCTION__);
    //NSLog(@"%@",navigation);
}
/// 5 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"%s", __FUNCTION__);
    //NSLog(@"%@",navigation);
    [[self activityIndicatorView] stopAnimating];
}
/// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"%s", __FUNCTION__);
    //NSLog(@"%@",navigation);
    [[self activityIndicatorView]  stopAnimating];
}


/// message: 收到的脚本信息.
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"%s", __FUNCTION__);
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
