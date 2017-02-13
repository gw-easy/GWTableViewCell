//
//  NTESCommonTableData.h
//  NIM
//
//  Created by chris on 15/6/26.
//  Copyright © 2015年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GWCommonTableData.h"
#define SepLineLeft 15 //分割线距左边距离

//section key
#define HeaderTitle  @"headerTitle"
#define FooterTitle  @"footerTitle"
#define HeaderHeight @"headerHeight"
#define FooterHeight @"footerHeight"
#define RowContent   @"row"

//row key
#define Title         @"title"
#define DetailTitle   @"detailTitle"
#define CellClass     @"cellClass"  //自定义cell类
#define CellAction    @"action"     //所在cell执行的方法
#define ExtraInfo     @"extraInfo"  //传值
#define RowHeight     @"rowHeight"
#define SepLeftEdge   @"leftEdge"
#define UserImage     @"userImage"  //头像
#define HideShowEdge  @"hideShowEdge"   //显示底部界线
//#define RightLabel    @"rightLabel" //右Label
//common key
#define Disable       @"disable"      //cell不可见
#define ShowAccessory @"accessory"    //cell显示>箭头
#define ForbidSelect  @"forbidSelect" //cell不响应select事件

@interface GWCommonTableSection : NSObject

@property (nonatomic,copy)   NSString *headerTitle;

@property (nonatomic,copy)   NSArray *rows;

@property (nonatomic,copy)   NSString *footerTitle;

@property (nonatomic,assign) CGFloat  headerHeight;

@property (nonatomic,assign) CGFloat  footerHeight;




- (instancetype) initWithDict:(NSDictionary *)dict;

+ (NSArray *)sectionsWithData:(NSArray *)data;

@end




@interface GWCommonTableRow : NSObject

@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) UIImage *userImage;

@property (nonatomic,copy  ) NSString *detailTitle;

@property (nonatomic,copy  ) NSString *cellClassName;

@property (nonatomic,copy  ) NSString *cellActionName;

@property (nonatomic,assign) CGFloat  uiRowHeight;

@property (nonatomic,assign) CGFloat  sepLeftEdge;

//@property (nonatomic, strong) UILabel *rightLabel;
@property (assign, nonatomic) BOOL    hideShowEdge;

@property (nonatomic,assign) BOOL     showAccessory;

@property (nonatomic,assign) BOOL     forbidSelect;

@property (nonatomic,strong) id extraInfo;

- (instancetype) initWithDict:(NSDictionary *)dict;

+ (NSArray *)rowsWithData:(NSArray *)data;

@end




