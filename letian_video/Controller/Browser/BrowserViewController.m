//
//  BrowserViewController.m
//  letian_video
//
//  Created by 张 安乐 on 16/8/27.
//  Copyright © 2016年 com.letian.video_player. All rights reserved.
//

#import "BrowserViewController.h"



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
    self.navigationController.navigationBar.translucent = NO;
    [[self view]setBackgroundColor:[UIColor redColor]];
    
    
    NSInteger textHeight=44;
    NSInteger tabbarHeight=49;
    
    urlTextField = [[UITextField alloc] init];
    [urlTextField setDelegate:self];
    [urlTextField setReturnKeyType:UIReturnKeyGo];
     [urlTextField setAdjustsFontSizeToFitWidth:YES];
    [urlTextField setText:@""];
    [urlTextField setTextColor:[UIColor colorWithWhite:0 alpha:0.9]];
    [urlTextField setBackgroundColor:[UIColor whiteColor]];
    [urlTextField setAutocorrectionType:UITextAutocorrectionTypeDefault];
    [urlTextField setKeyboardType:UIKeyboardTypeURL];
    [urlTextField setFont:[UIFont systemFontOfSize:16]];
    [urlTextField setPlaceholder:@"标题"];
    [urlTextField.layer setMasksToBounds:YES];
    [urlTextField.layer setBorderWidth:0.5];
    [urlTextField setLeftView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, textHeight)]];
    [urlTextField setLeftViewMode:UITextFieldViewModeAlways];
    [urlTextField setClearButtonMode:UITextFieldViewModeAlways];
    [urlTextField.layer setBorderColor:[[UIColor colorWithWhite:0.5 alpha:0.3] CGColor]];
    
    //［urlField ］
    
    [[self view]addSubview:urlTextField];
    
    videoWebView = [[UIWebView alloc]  initWithFrame:CGRectMake(0, textHeight, self.view.frame.size.width, self.view.frame.size.height-textHeight-tabbarHeight)];
    [videoWebView setScalesPageToFit:YES];
    [videoWebView setDelegate:self];
    [videoWebView setOpaque:NO];
    
    [[self view]addSubview:videoWebView];
    
    //    [videoWebView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.and.right.mas_equalTo(0);
    //        make.width.equalTo(self.view);
    //            make.height.mas_equalTo(self.view.frame.size.height-40);
    //        make.top.equalTo(urlField.mas_bottom);
    //        make.bottom.equalTo(self.view);
    //    }];
    
    
    activityIndicatorView = [[UIActivityIndicatorView alloc]
                             initWithFrame : CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)] ;
    [activityIndicatorView setCenter: self.view.center] ;
    [activityIndicatorView setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleWhite] ;
    [self.view addSubview : activityIndicatorView] ;
    [self buttonPress:nil];
    
    
    
    [urlTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    BOOL flag = NO;
    [self buttonPress:textField];
    return flag;
}
- (IBAction)buttonPress:(id) sender
{
    [urlTextField resignFirstResponder];
    if(urlTextField.text.length>0){
        NSString *url =@"";
        if([urlTextField.text rangeOfString:@"://"].length>0){
            url=urlTextField.text;
        }else{
            url=[@"http://" stringByAppendingString:urlTextField.text];
        }
        urlTextField.text =url;
        [self loadWebPageWithString:url];
    }
    
}
- (void)loadWebPageWithString:(NSString*)urlString
{
    
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [videoWebView loadRequest:request];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [activityIndicatorView startAnimating] ;
    //[urlTextField setText:[webView superclass]]
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicatorView stopAnimating];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"" message:[error localizedDescription]  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alterview show];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
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
