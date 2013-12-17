//
//  ViewController.m
//  topstuffslight
//
//  Created by Richard Svienty on 8/20/12.
//  Copyright (c) 2012 Richard Svienty. All rights reserved.
//

#import "ViewController.h"
#import "myStuffsListItem.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Set up our list items
    myListItems = [[NSMutableArray alloc] initWithCapacity:5];
    for (int x=0;x<5;x++)
    {
        myStuffsListItem *tempItem = [[myStuffsListItem alloc] init];

        UITableViewCell *temp =
        [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"TOPS"];
        
        tempItem._cell = temp;
        
        NSArray *nibListViews;
        
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
            nibListViews = [[NSBundle mainBundle] loadNibNamed:@"View" owner:tempItem options:nil];
        else
            nibListViews = [[NSBundle mainBundle] loadNibNamed:@"View" owner:tempItem options:nil];
                
        [temp.contentView addSubview:[nibListViews objectAtIndex: 0]];
        tempItem._detailedView = [nibListViews objectAtIndex: 0];

        [myListItems addObject:tempItem];
    }
    
    // Set up out main view.
    NSArray *nibViews;
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        nibViews = [[NSBundle mainBundle] loadNibNamed:@"MyListOStuffsIpad" owner:self options:nil];
    else
        nibViews = [[NSBundle mainBundle] loadNibNamed:@"MyListOStuffsIphone" owner:self options:nil];
    
    myView = [nibViews objectAtIndex: 0];
    myView.hidden = YES;
    
    myView.frame = CGRectMake(0.0,myNavBar.frame.size.height+20,statusBarFrame.size.width,300.0);
    
    myStuffsTable.delegate = self;
    myStuffsTable.dataSource = self;
    myStuffsTable.rowHeight = 80;
    
    [self.view addSubview:myView];
    
    // Setup Webview
    myWebView = [[topStuffsWebView alloc] initWithFrame:CGRectMake(0.0,myNavBar.frame.size.height+20,statusBarFrame.size.width,400.0)];
    
    myWebView.hidden = NO;
    // TODO set other properties like rotate/resize
    myWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    myWebView.scalesPageToFit = YES;
    
    [self.view addSubview:myWebView];
    
    // [myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.svienty.com"]]];
    [myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://LOCALHOST:3000"]]];
    
    myWebView->URLTextField = self.URLTextField;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

-  (void) handleMyStuffs
{
    NSLog(@"ViewController::handleMyStuffs");
    

    
    if (myView != nil)
    {
        myView.hidden = (myView.hidden != YES);
        myWebView.hidden = (myWebView.hidden != YES);
        return;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"ViewController::didSelectRowAtIndexPath");
    myView.hidden = YES;
    myWebView.hidden = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    NSLog(@"ViewController::numberOfRowsInSection");
    return myListItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"ViewController::cellForRowAtIndexPath");
    
    // OLD return  [myListItems objectAtIndex:indexPath.row];
    myStuffsListItem * temp = [myListItems objectAtIndex:indexPath.row];
    return temp._cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"ViewController::textFieldShouldReturn");
    [myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:textField.text]]];
    [textField resignFirstResponder];
	return YES;
}


@end
