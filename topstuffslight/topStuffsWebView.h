//
//  topStuffsWebView.h
//  topstuffsnib
//
//  Created by Richard Svienty on 8/19/12.
//  Copyright (c) 2012 Richard Svienty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface topStuffsWebView : UIWebView <UIWebViewDelegate>
{
@public
  UITextField *URLTextField;
}
-  (void) loadJavascript;
-  (void) runJavascript;

@end