//
//  NTESCommonTableDelegate.m
//  NIM
//
//  Created by chris on 15/6/29.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import "GWCommonTableDelegate.h"
#import "GWCommonTableData.h"
#import "GWCommonTableViewCell.h"
#import "UIView+GW.h"
#import "NSString+NTES.h"
#import "UIColor+HexString.h"
#define SepViewTag 10001
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

static NSString *DefaultTableCell = @"UITableViewCell";

@interface GWCommonTableDelegate()

@property (nonatomic,copy) NSArray *(^NTESDataReceiver)(void);

@end

@implementation GWCommonTableDelegate

- (instancetype) initWithTableData:(NSArray *(^)(void))data{
    self = [super init];
    if (self) {
        _NTESDataReceiver = data;
        _defaultSeparatorLeftEdge = SepLineLeft;

    }
    return self;
}

- (NSArray *)data{
    return self.NTESDataReceiver();
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GWCommonTableSection *tableSection = self.data[section];
    return tableSection.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GWCommonTableSection *tableSection = self.data[indexPath.section];
    GWCommonTableRow     *tableRow     = tableSection.rows[indexPath.row];
    NSString *identity = tableRow.cellClassName.length ? tableRow.cellClassName : DefaultTableCell;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell == nil) {
        Class clazz = NSClassFromString(identity);
        cell = [[clazz alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identity];
        if (tableRow.hideShowEdge == NO) {
            UIView *sep = [[UIView alloc] initWithFrame:CGRectZero];
            sep.tag = SepViewTag;
            sep.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
            sep.backgroundColor = [UIColor lightGrayColor];
            [cell addSubview:sep];
        }
    }
    
    if (![cell respondsToSelector:@selector(refreshData:tableView:)]) {
        UITableViewCell *defaultCell = (UITableViewCell *)cell;
        [self refreshData:tableRow cell:defaultCell];
    }else{
        [(id<GWCommonTableViewCell>)cell refreshData:tableRow tableView:tableView];
    }
    cell.accessoryType = tableRow.showAccessory ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;

    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    GWCommonTableSection *tableSection = self.data[indexPath.section];
    GWCommonTableRow     *tableRow     = tableSection.rows[indexPath.row];
    return tableRow.uiRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    GWCommonTableSection *tableSection = self.data[indexPath.section];
    GWCommonTableRow     *tableRow     = tableSection.rows[indexPath.row];
    if (!tableRow.forbidSelect) {
        UIViewController *vc = tableView.viewController;
        NSString *actionName = tableRow.cellActionName;
        if (actionName.length) {
            SEL sel = NSSelectorFromString(actionName);
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            SuppressPerformSelectorLeakWarning([vc performSelector:sel withObject:cell]);
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //这里的cell已经有了正确的bounds
    //不在cellForRow的地方设置分割线是因为在ios7下，0.5像素的view利用autoResizeMask调整布局有问题，会导致显示不出来，ios6,ios8均正常。
    //具体问题类似http://stackoverflow.com/questions/30663733/add-a-0-5-point-height-subview-to-uinavigationbar-not-show-in-ios7
    //这个回调里调整分割线的位置
    GWCommonTableSection *tableSection = self.data[indexPath.section];
    GWCommonTableRow     *tableRow     = tableSection.rows[indexPath.row];
    if (tableRow.hideShowEdge == NO) {
        UIView *sep = [cell viewWithTag:SepViewTag];
        CGFloat sepHeight = .5f;
        CGFloat sepWidth;
        if (tableRow.sepLeftEdge) {
            sepWidth  = cell.width - tableRow.sepLeftEdge;
        }else{
            if (indexPath.row == tableSection.rows.count - 1) {
                //最后一行
                sep.hidden = YES;
            }else{
                sepWidth = cell.width - self.defaultSeparatorLeftEdge;
            }
        }
        sepWidth  = sepWidth > 0 ? sepWidth : 0;
        sep.frame = CGRectMake(cell.width - sepWidth, cell.height - sepHeight, sepWidth ,sepHeight);
    }  
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    GWCommonTableSection *tableSection = self.data[section];
    return tableSection.headerTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    GWCommonTableSection *tableSection = self.data[section];
    return tableSection.headerHeight?tableSection.headerHeight:[tableSection.headerTitle stringSizeWithFont:[UIFont systemFontOfSize:13.f]].height;


}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    GWCommonTableSection *tableSection = self.data[section];
    return tableSection.footerTitle;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    GWCommonTableSection *tableSection = self.data[section];
    if (tableSection.headerTitle.length) {
        return nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    GWCommonTableSection *tableSection = self.data[section];
    if (tableSection.footerTitle.length) {
        return nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    return view;
}

#pragma mark - Private
- (void)refreshData:(GWCommonTableRow *)rowData cell:(UITableViewCell *)cell{
    cell.textLabel.text = rowData.title;
    cell.detailTextLabel.text = rowData.detailTitle;
    cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#333333"];
//    cell.detailTextLabel.frame = CGRectMake(cell.textLabel.left, cell.textLabel.top, WIDTH/2, 20);
}



@end
