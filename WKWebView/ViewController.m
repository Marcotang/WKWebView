//
//  ViewController.m
//  WKWebView
//
//  Created by general on 4/1/2018.
//  Copyright © 2018 clear. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController () <WKNavigationDelegate,WKUIDelegate>

@property(strong, nonatomic) IBOutlet WKWebView *webview;

@end

@implementation ViewController
@synthesize webview;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self postDataToWebView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//------------------------------------------------------------------
// MARK: Post Data To WKWebView
//------------------------------------------------------------------
- (void)postDataToWebView{
    
    // Setup the URL & login info
    NSString* loginUrl = @"https://your_website_domain/login.php";
    NSString* sessionID = @"73967";
    NSString* studentName = @"my_name";
    NSString* studentID = @"my_id";
    
    NSURL *url = [NSURL URLWithString:loginUrl];
    NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL:url];
    
    // POST the username password
    [requestObj setHTTPMethod:@"POST"];
    NSString *postString = [NSString stringWithFormat:@"studentName=%@&studentid=%@&sessionid=%@", studentName, studentID, sessionID];
    NSData *data = [postString dataUsingEncoding: NSUTF8StringEncoding];
    [requestObj setHTTPBody:data];
    
    // Load the request
    self.webview.UIDelegate = self;
    self.webview.navigationDelegate = self;
    self.webview.configuration.preferences.javaScriptEnabled=YES;
    self.webview.configuration.preferences.javaScriptCanOpenWindowsAutomatically=NO;
    
    [self.webview loadRequest:requestObj];
    
}


// --------------------------------------------------------------------
// MARK: WKWebView UI Delegate
// --------------------------------------------------------------------
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    decisionHandler(WKNavigationActionPolicyAllow);
    
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Site_Name" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}


- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Site_Name" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        completionHandler(NO);
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        completionHandler(YES);
    }];
    
    [controller addAction:action1];
    [controller addAction:action2];
    [self presentViewController:controller animated:YES completion:nil];
    
}


@end
