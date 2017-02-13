//
//  ViewController.m
//  tableView及cell的自定义
//
//  Created by 杨学浩 on 16/6/23.
//  Copyright © 2016年 杨学浩. All rights reserved.
//

#import "ViewController.h"
#import "GWCommonTableDelegate.h"
#import "GWCommonTableData.h"
@interface ViewController (){
    UITableView *tableView;
    NSArray *changData;
}
@property (nonatomic,strong) GWCommonTableDelegate *delegator;
@property (nonatomic, strong) NSArray *data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor greenColor];
    tableView.scrollEnabled = NO;
    [self reloadData];
    WS(weakSelf)
    self.delegator = [[GWCommonTableDelegate alloc] initWithTableData:^NSArray *{
        return weakSelf.data;
    }];
    tableView.delegate = self.delegator;
    tableView.dataSource = self.delegator;
   
    [self.view addSubview:tableView];

}

- (void)reloadData{
    changData = @[
                  @{
                      HeaderTitle:@"",
                      RowContent :@[
                              @{
                                  Title      :@"账号和安全",
                                  CellAction :@"onTouchImage",
//                                  RowHeight :@"70",
//                                  UserImage :@"",
                                  ShowAccessory:@(YES),
                                  },
                            ],
                      FooterTitle:@""
                      },
                              
                  @{
                      HeaderTitle:@"",
                      RowContent :@[
                              @{
                                  Title      :@"黑名单",
                                  CellAction :@"onTouchImage",
//                                  CellClass :@"XQDSelfEditImageCell",
//                                  RowHeight :@"70",
//                                  UserImage :@"",
                                  ShowAccessory:@(YES),
                                  },
                              @{
                                  Title      :@"推送管理",
//                                  DetailTitle:nameStr.length ? nameStr : @"",
//                                  CellClass :@"XQDSelfEditLabelCell",
                                  CellAction :@"onTouchNameStr",
                                  ShowAccessory:@(YES),
                                  },
                              @{
                                  Title      :@"清理缓存",
//                                  DetailTitle:signStr.length ? signStr : @"",
//                                  CellClass :@"XQDSelfEditLabelCell",
                                  CellAction :@"removeCache",
                                  ShowAccessory:@(YES),
                                  },
                              ],
                      FooterTitle:@""
                      },
                  @{
                      HeaderTitle:@"",
                      RowContent :@[
                              @{
                                  Title      :@"帮助和反馈",
                                  CellAction :@"onTouchImage",
                                 
                                  ShowAccessory:@(YES),
                                  },
                              @{
                                  Title      :@"关于说说TV",
                                  //                                  DetailTitle:nameStr.length ? nameStr : @"",
                                  //                                  CellClass :@"XQDSelfEditLabelCell",
                                  CellAction :@"onTouchNameStr",
                                  ShowAccessory:@(YES),
                                  },
                            ],
                      FooterTitle:@""
                      },
                  @{
                      HeaderTitle:@"",
                      RowContent :@[
                              @{
                                  Title      :@"退出登陆",
                                  CellAction :@"exitLogin",
                                  ExtraInfo    : @(0),
                                  },
                            ],
                      FooterTitle:@""
                      },

                  ];
   self.data = [GWCommonTableSection sectionsWithData:changData];

}

- (void)exitLogin{
    
}

- (void)removeCache{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
