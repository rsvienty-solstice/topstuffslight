//
//  ViewController.h
//  topstuffslight
//
//  Created by Richard Svienty on 8/20/12.
//  Copyright (c) 2012 Richard Svienty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "topStuffsWebView.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    IBOutlet UIBarButtonItem * myStuffsButton;
    IBOutlet UITableView * myStuffsTable;
    IBOutlet UINavigationBar *myNavBar;
    
    UIView *myView;
    
    topStuffsWebView *myWebView;
    
    NSMutableArray *myListItems;
    NSMutableArray *myListViews;
}

-  (IBAction) handleMyStuffs;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, retain) IBOutlet UITextField *URLTextField;

@end

