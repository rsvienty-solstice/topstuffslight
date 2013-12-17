//
//  myStuffsListItem.h
//  topstuffslight
//
//  Created by Richard Svienty on 8/27/12.
//  Copyright (c) 2012 Richard Svienty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface myStuffsListItem : NSObject
{
    IBOutlet UISlider *_slider;
    IBOutlet UIButton *_button;
}

@property (strong, nonatomic) UITableViewCell *_cell;
@property (strong, nonatomic) UIView * _detailedView;

-  (IBAction) handleSlider;
-  (IBAction) handleButton;

@end
