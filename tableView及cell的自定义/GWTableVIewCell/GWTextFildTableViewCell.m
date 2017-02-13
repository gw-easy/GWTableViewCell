//
//  GWTextFildTableViewCell.m
//  CamHi
//
//  Created by gw on 2016/12/5.
//  Copyright © 2016年 Hichip. All rights reserved.
//

#import "GWTextFildTableViewCell.h"
#import "GWCommonTableData.h"
#import "UIView+GW.h"
@interface GWTextFildTableViewCell()<UITextFieldDelegate>


@end
@implementation GWTextFildTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self addSubview:self.nameText];
    }
    return self;
}

- (UITextField *)nameText{
    if (!_nameText) {
        _nameText = [[UITextField alloc] initWithFrame:CGRectMake(GWHeight(30), 0, SCREENWIDTH-GWHeight(30), self.contentView.height)];
        _nameText.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_nameText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _nameText;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    
    NSString * temp = textField.text;
    
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:0 error:nil];
    
    NSString *noEmojiStr = [regularExpression stringByReplacingMatchesInString:textField.text options:0 range:NSMakeRange(0, textField.text.length) withTemplate:@""];
    
    
    
    if (![noEmojiStr isEqualToString:textField.text]) {
        
        textField.text = noEmojiStr;
        
    }
    
    
    if (textField.markedTextRange ==nil)
        
    {
        while(1)
        {
            if ([temp lengthOfBytesUsingEncoding:NSUTF8StringEncoding] <= 32) {
                break;
            }
            else
            {
                temp = [temp substringToIndex:temp.length-1];
            }
        }
        textField.text=temp;
    }
}



- (void)refreshData:(GWCommonTableRow *)rowData tableView:(UITableView *)tableView{
    self.nameText.text       = rowData.title;

}



#define SwitcherRight 15
- (void)layoutSubviews{
    [super layoutSubviews];

    self.nameText.centerY = self.height * .5f;
}


@end
