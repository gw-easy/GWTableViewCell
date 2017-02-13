//
//  NTESColorButtonCell.h
//  NIM
//
//  Created by chris on 15/3/11.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWCommonTableViewCell.h"

typedef NS_ENUM(NSInteger, ColorButtonCellStyle){
    ColorButtonCellStyleRed = 0,
    ColorButtonCellStyleBlue,
};

@class GWColorButton;

@interface GWColorButtonCell : UITableViewCell<GWCommonTableViewCell>

@property (nonatomic,strong) GWColorButton *button;

@end



@interface GWColorButton : UIButton

@property (nonatomic,assign) ColorButtonCellStyle style;

@end