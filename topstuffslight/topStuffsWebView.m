//
//  topStuffsWebView.m
//  topstuffsnib
//
//  Created by Richard Svienty on 8/19/12.
//  Copyright (c) 2012 Richard Svienty. All rights reserved.
//

#import "topStuffsWebView.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation topStuffsWebView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    self.delegate = self;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.scalesPageToFit = YES;
    return self;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    NSURL *requestURL;
        
    requestURL = [[NSURL alloc] initWithString:request.URL.absoluteString];
    NSString *urlString = requestURL.absoluteString;
    NSString *urlScheme = requestURL.scheme;
    
    // Check if JS is trying to Log
    if ((navigationType == UIWebViewNavigationTypeOther) && [urlScheme isEqualToString:@"jsLog"])
    {
        NSString *logText = [[urlString substringFromIndex:@"jsLog://".length]
                              stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
        NSLog(@"JSLog::%@", logText);
            
        return NO;
    }

    NSLog(@"topStuffsWebView::shouldStartLoadWithRequest\n");
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView;
{
    NSLog(@"topStuffsWebView::webViewDidStartLoad\n");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    NSLog(@"topStuffsWebView::webViewDidFinishLoad\n");
    
    // Now let's load some javascript routines into browser memory
    [self loadJavascript];
    
    // Now let's trigger some calls into the webview
    [self runJavascript];
    
    self->URLTextField.text = self.request.URL.absoluteString;
    
    // AudioServicesPlaySystemSound(1104);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
{
    NSLog(@"topStuffsWebView::didFailLoadWithError\n");
}

-  (void) loadJavascript;
{
    NSLog(@"topStuffsWebView::loadJavascript\n");
    
    // First read the JS data into a buffer
    NSString *stringURL = @"http://LOCALHOST:3000/jsprimer.js";
    NSURL  *url = [NSURL URLWithString:stringURL];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    if ( urlData )
    {
        NSLog(@"topStuffsWebView::JS Loaded\n");
        
        NSString* newStr = [[NSString alloc] initWithData:urlData
                                                 encoding:NSUTF8StringEncoding];
        
        [self stringByEvaluatingJavaScriptFromString:newStr];
    }
    else
    {
        NSLog(@"topStuffsWebView::JS not Loaded\n");
    }
    
}

-  (void) runJavascript;
{
    NSLog(@"topStuffsWebView::runJavascript\n");
    
    // Call the add onclick function
    NSString *javaOut = [self stringByEvaluatingJavaScriptFromString:@"addOnclick()"];
    NSLog(@"JSReturn::%@", javaOut);

    // Call the overlay function
    javaOut = [self stringByEvaluatingJavaScriptFromString:@"overlayImages()"];
    NSLog(@"JSReturn::%@", javaOut);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
