//
//  DatasModel.h
//  BSBDQJTestDemo
//
//  Created by XGJ on 16/5/31.
//  Copyright © 2016年 XGJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define JYJScreenH [UIScreen mainScreen].bounds.size.height
#define JYJScreenW [UIScreen mainScreen].bounds.size.width
typedef NS_ENUM(NSUInteger, TopicType) {
    /** 全部 */
    JYJTopicTypeAll = 1,
    /** 图片 */
    JYJTopicTypePicture = 10,
    /** 段子 */
    JYJTopicTypeWord = 29,
    /** 声音 */
    JYJTopicTypeVoice = 31,
    /** 视频 */
    JYJTopicTypeVideo = 41
};

@interface DatasModel : NSObject

@property (nonatomic, assign) NSInteger cache_version;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *is_gif;

@property (nonatomic, copy) NSString *voicetime;

@property (nonatomic, copy) NSString *image2;

@property (nonatomic, copy) NSString *voicelength;

@property (nonatomic, strong) NSArray *top_cmt;

@property (nonatomic, assign) NSInteger playfcount;

@property (nonatomic, copy) NSString *repost;

@property (nonatomic, copy) NSString *bimageuri;

@property (nonatomic, copy) NSString *image1;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSString *theme_type;

@property (nonatomic, copy) NSString *hate;

@property (nonatomic, copy) NSString *image0;

@property (nonatomic, copy) NSString *comment;

@property (nonatomic, copy) NSString *passtime;

@property (nonatomic, copy) NSString *ding;

@property (nonatomic, assign)TopicType type;

@property (nonatomic, assign) NSInteger playcount;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *cdn_img;

@property (nonatomic, copy) NSString *theme_name;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, copy) NSString *favourite;

@property (nonatomic, strong) NSArray *themes;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *height;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *videotime;

@property (nonatomic, copy) NSString *bookmark;

@property (nonatomic, copy) NSString *cai;

@property (nonatomic, copy) NSString *screen_name;

@property (nonatomic, copy) NSString *profile_image;

@property (nonatomic, copy) NSString *love;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *theme_id;

@property (nonatomic, copy) NSString *original_pid;

@property (nonatomic, assign) NSInteger t;

@property (nonatomic, copy) NSString *image_small;

@property (nonatomic, copy) NSString *weixin_url;

@property (nonatomic, copy) NSString *voiceuri;

@property (nonatomic, copy) NSString *videouri;

@property (nonatomic, copy) NSString *width;




/****** 额外的辅助属性 ******/

/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;
/** 图片控件的frame */
@property (nonatomic, assign, readonly) CGRect pictureF;

/** 图片是否太大 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;
/** 图片的下载进度 */
@property (nonatomic, assign) CGFloat pictureProgress;

/** 声音控件的frame */
@property (nonatomic, assign, readonly) CGRect voiceF;
/** 视频控件的frame */
@property (nonatomic, assign, readonly) CGRect videoF;
- (CGFloat)cellHeight;


@end
