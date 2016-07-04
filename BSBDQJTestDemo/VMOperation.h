//
//  VMOperation.h
//  BSBDQJTestDemo
//
//  Created by XGJ on 16/5/31.
//  Copyright © 2016年 XGJ. All rights reserved.
//

#import "VModelClass.h"
#import "ViewController.h"

@interface VMOperation : VModelClass
/**
 *  请求数据
 *
 *  @param indexs 请求页面
 */
-(void)GetDatas:(NSString *)indexs;
/**
 *  跳转
 *
 *  @param VC     当前VC
 *  @param models 数据源
 */
-(void)push:(UIViewController *)VC data:(DatasModel *)models;
+ (UIView *)getMainView;
@end
