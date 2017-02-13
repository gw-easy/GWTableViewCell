//
//  GWTextFildTableViewCell.h
//  CamHi
//
//  Created by gw on 2016/12/5.
//  Copyright © 2016年 Hichip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GWTextFildTableViewCell : UITableViewCell
@property (nonatomic, copy) void(^textBlock)(NSString*);
@property (nonatomic, strong) UITextField *nameText;
@end
