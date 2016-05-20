//
//  CLViewController.h
//  CLUnLimitScrollView
//
//  Created by More on 16/5/20.
//  Copyright © 2016年 More. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLViewController : UIViewController

/**  名称*/
@property(nonatomic,copy)NSString * C_name;

-(void)sc:(UIScrollView*)sc index:(NSInteger)index;


@end
