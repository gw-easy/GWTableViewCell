//
//  GWMidLabelTableViewCell.m
//  CamHi
//
//  Created by gw on 2016/12/3.
//  Copyright © 2016年 Hichip. All rights reserved.
//

#import "GWMidLabelTableViewCell.h"
#import "GWCommonTableData.h"
#import "UIView+GW.h"
#import "UIColor+HexString.h"

@interface GWMidLabelTableViewCell ()

@property(nonatomic,strong) UILabel *midLabel;

@end
@implementation GWMidLabelTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _midLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _midLabel.size = CGSizeMake(SCREENWIDTH, 20);
        [self addSubview:_midLabel];
    }
    return self;
}


- (void)refreshData:(GWCommonTableRow *)rowData tableView:(UITableView *)tableView{
//    self.midLabel.text       = rowData.title;
    NSMutableDictionary *attributesdic = [NSMutableDictionary dictionary];
    attributesdic[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#ff8903"];
    //    attributesdic[NSUnderlineStyleAttributeName] = @YES;
    attributesdic[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:rowData.title attributes:attributesdic];
    self.midLabel.attributedText = attString;
    self.midLabel.textAlignment = NSTextAlignmentCenter;
//    self.detailTextLabel.text = rowData.detailTitle;
//    NSString *actionName      = rowData.cellActionName;
//    [self.switcher setOn:[rowData.extraInfo boolValue] animated:NO];
//    [self.switcher removeTarget:self.viewController action:NULL forControlEvents:UIControlEventValueChanged];
//    if (actionName.length) {
//        SEL sel = NSSelectorFromString(actionName);
//        [self.switcher addTarget:tableView.viewController action:sel forControlEvents:UIControlEventValueChanged];
//    }
}



#define SwitcherRight 15
- (void)layoutSubviews{
    [super layoutSubviews];
    self.midLabel.left   = self.left;
    self.midLabel.height = 20;
    self.midLabel.centerY = self.height * .5f;
}

@end
