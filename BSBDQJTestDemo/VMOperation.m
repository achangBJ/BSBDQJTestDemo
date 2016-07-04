//
//  VMOperation.m
//  BSBDQJTestDemo
//
//  Created by XGJ on 16/5/31.
//  Copyright © 2016年 XGJ. All rights reserved.
//

#import "VMOperation.h"
#import "TFHpple.h"
#import "TFHppleElement.h"
#import "XPathQuery.h"
#import "DatasModel.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "VideoViewController.h"
#import <AVFoundation/AVFoundation.h>


#define IS_IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
#define SYSTEM_VERSION_EQUAL_TO(v)                                             \
([[[UIDevice currentDevice] systemVersion] compare:v                         \
options:NSNumericSearch] ==       \
NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)                                         \
([[[UIDevice currentDevice] systemVersion] compare:v                         \
options:NSNumericSearch] ==       \
NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)                             \
([[[UIDevice currentDevice] systemVersion] compare:v                         \
options:NSNumericSearch] !=       \
NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                                            \
([[[UIDevice currentDevice] systemVersion] compare:v                         \
options:NSNumericSearch] ==       \
NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)                                \
([[[UIDevice currentDevice] systemVersion] compare:v                         \
options:NSNumericSearch] !=       \

typedef void (^HttpSuccess)(NSDictionary *json);

typedef void (^HttpFailure)(NSError *error);
@interface VMOperation ()
{
    AVPlayer *player;
    UIView *_caleview;
    UIView *BGviews;
}
@property (nonatomic,strong)UIScrollView *ScorrllView;

@property (nonatomic,strong)NSString *maxtime;

@end
@implementation VMOperation
{
    CGFloat _cellHeight;
}
-(void)GetDatas:(NSString *)indexs
{
    int pageint = [indexs intValue] +1;
    NSNumber *page =[[NSNumber alloc]initWithInt:pageint];
    NSDictionary *dic;
    if (pageint>2) {
        dic= @{@"a":@"list",
               @"c":@"data",
               @"type":@"1",
               @"page":page,
               @"maxtime":self.maxtime};
    }else{
        dic= @{@"a":@"list",
               @"c":@"data",
               @"type":@"1",
               @"page":page};
    }
    
    [self postWithURL:@"http://api.budejie.com/api/api_open.php"
               params:dic
              success:^(NSDictionary *json)
                {
                    self.maxtime = json[@"info"][@"maxtime"];
                    if ([json[@"list"] count]) {
                     NSMutableArray *array   = [DatasModel mj_objectArrayWithKeyValuesArray:json[@"list"]];
                     self.returnBlock(array);
                    }
                }
              failure:^(NSError *error) {
        
              }];
}


/**
 *  网络请求
 *
 *  @param url
 *  @param params
 *  @param success
 *  @param failure  
 */
-(void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpSuccess)success failure:(HttpFailure)failure;

{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.requestSerializer = [AFHTTPRequestSerializer serializer];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    manger.requestSerializer.timeoutInterval = 20;
    manger.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [manger POST:url
      parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if (success)
             {
                NSData *data = responseObject;
                NSString *jsondata =  [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                NSData *JSONData = [jsondata dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
                success(dic);
             }
         }
        failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
            if (error)
            {
                failure(error);
            }
        }];
    
}
-(void)push:(UIViewController *)VC data:(DatasModel *)models
{
 
    if (models.type ==JYJTopicTypeVideo) {
        VideoViewController *vcs = [[VideoViewController alloc]init];
        vcs.URLString = models.videouri;
        [VC.navigationController pushViewController:vcs animated:YES];
    }else if(models.type ==JYJTopicTypePicture)
    {
        ViewController *vcs = [[ViewController alloc]init];
        [vcs getModel:models];
        [VC.navigationController pushViewController:vcs animated:YES];
    }
 
}

+ (UIView *)getMainView {
    if (SYSTEM_VERSION_LESS_THAN(@"8.0")) {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        if (!window)
            window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        return [window subviews].lastObject;
    } else {
        UIWindow *window =[[UIApplication sharedApplication] keyWindow];
        if (window == nil)
            window = [[[UIApplication sharedApplication] delegate] window];//#14
        return window;
    }
}

@end
