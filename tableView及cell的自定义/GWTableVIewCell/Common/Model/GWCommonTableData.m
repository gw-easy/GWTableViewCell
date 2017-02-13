//
//  NTESCommonTableData.m
//  NIM
//
//  Created by chris on 15/6/26.
//  Copyright © 2015年 Netease. All rights reserved.
//

#import "GWCommonTableData.h"

#define DefaultUIRowHeight  50.f
#define DefaultEepLeftEdge  20.f
#define DefaultUIHeaderHeight  44.f
#define DefaultUIFooterHeight  44.f

@implementation GWCommonTableSection

- (instancetype) initWithDict:(NSDictionary *)dict{
    if ([dict[Disable] boolValue]) {
        return nil;
    }
    self = [super init];
    if (self) {
        _headerTitle = dict[HeaderTitle];
        _footerTitle = dict[FooterTitle];
        _footerHeight = [dict[FooterHeight] floatValue];
        _headerHeight = [dict[HeaderHeight] floatValue];
        _headerHeight = _headerHeight ? _headerHeight : DefaultUIHeaderHeight;
        _footerHeight = _footerHeight ? _footerHeight : DefaultUIFooterHeight;
        _rows = [GWCommonTableRow rowsWithData:dict[RowContent]];
    }
    return self;
}

+ (NSArray *)sectionsWithData:(NSMutableArray *)data{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:data.count];
    for (NSDictionary *dict in data) {
        if ([dict isKindOfClass:[NSDictionary class]]) {
            GWCommonTableSection * section = [[GWCommonTableSection alloc] initWithDict:dict];
            if (section) {
                [array addObject:section];
            }
        }
    }
    return array;
}


@end



@implementation GWCommonTableRow

- (instancetype) initWithDict:(NSDictionary *)dict{
    if ([dict[Disable] boolValue]) {
        return nil;
    }
    self = [super init];
    if (self) {
        _title          = dict[Title];
        _detailTitle    = dict[DetailTitle];
        _cellClassName  = dict[CellClass];
        _cellActionName = dict[CellAction];
        _uiRowHeight    = dict[RowHeight] ? [dict[RowHeight] floatValue] : DefaultUIRowHeight;
        _extraInfo      = dict[ExtraInfo];
        _sepLeftEdge    = dict[SepLeftEdge] ? [dict[SepLeftEdge] floatValue] :DefaultEepLeftEdge;
        _showAccessory  = [dict[ShowAccessory] boolValue];
        _forbidSelect   = [dict[ForbidSelect] boolValue];
        _userImage      = dict[UserImage];
        _hideShowEdge   = [dict[HideShowEdge] boolValue];
//        _rightLabel     = dict[RightLabel];
    }
    return self;
}

+ (NSArray *)rowsWithData:(NSArray *)data{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:data.count];
    for (NSDictionary *dict in data) {
        if ([dict isKindOfClass:[NSDictionary class]]) {
            GWCommonTableRow * row = [[GWCommonTableRow alloc] initWithDict:dict];
            if (row) {
                [array addObject:row];
            }
        }
    }
    return array;
}


@end
