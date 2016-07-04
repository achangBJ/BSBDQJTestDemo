//
//  DatasModel.m
//  BSBDQJTestDemo
//
//  Created by XGJ on 16/5/31.
//  Copyright © 2016年 XGJ. All rights reserved.
//

#import "DatasModel.h"

@implementation DatasModel
{
    CGFloat _cellHeight;
}
/** tabBar的高度 */
CGFloat const JYJTabBarH = 49;

/** navigationBar的高度 */
CGFloat const JYJNavigationBarH = 64;

/** tabBar + navigationBar 的高度 */
CGFloat const JYJTabBarAddNavBarH = JYJTabBarH + JYJNavigationBarH;

/** 首页标题的高度 */
CGFloat const JYJTitilesViewH = 35;

/** 精华-cell-间距 */
CGFloat const JYJTopicCellMargin = 10;
/** 精华-cell-文字内容的Y值 */
CGFloat const JYJTopicCellTextY = 55;
/** 精华-cell-底部工具条的高度 */
CGFloat const JYJTopicCellBottomBarH = 00;

/** 精华-cell-图片帖子的最大高度 */
CGFloat const JYJTopicCellPictureMaxH = 1000;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
CGFloat const JYJTopicCellPictureBreakH = 250;

/** XMGUser模型-性别属性值 */
NSString * const JYJGUserSexMale = @"m";
NSString * const JYJGUserSexFemale = @"f";

/** 精华-cell-最热评论标题的高度 */
CGFloat const JYJTopicCellTopCmtTitleH = 00;


/** tabBar被选中的通知名字 */
NSString * const JYJTabBarDidSelectNotification = @"JYJTabBarDidSelectNotification";
/** tabBar被选中的通知 - 被选中的控制器的index key */
NSString * const JYJSelectedControllerIndexKey = @"JYJSelectedControllerIndexKey";
/** tabBar被选中的通知 - 被选中的控制器 key */
NSString * const JYJSelectedControllerKey = @"JYJSelectedControllerKey";

/** 标签-间距 */
CGFloat const JYJTagMargin = 5;
/** 标签-高度 */
CGFloat const JYJTagH = 25;




- (CGFloat)cellHeight {
    
    if (!_cellHeight) {
        
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake(JYJScreenW - 2 * JYJTopicCellMargin, MAXFLOAT);
        
        UILabel *label = [UILabel new];
        label.frame = CGRectMake(0, 0, maxSize.width, 0);
        label.text = self.text;
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines = 0;
        [label sizeToFit];
        CGFloat textH = label.frame.size.height;
        
        //cell的高度
        _cellHeight = JYJTopicCellTextY + textH + JYJTopicCellMargin;
        
        // 根据段子的类型来计算cell的高度
        if (self.type == JYJTopicTypePicture) { // 图片帖子
            if (self.width != 0 && self.height != 0) {
                // 图片显示出来的宽度
                CGFloat pictureW = maxSize.width;
                // 显示显示出来的高度
                CGFloat pictureH = pictureW * [self.height floatValue] / [self.width floatValue];
                
                if (pictureH >= JYJTopicCellPictureMaxH) {
                    pictureH = JYJTopicCellPictureBreakH;
                    self.bigPicture = YES; // 大图
                }
                // 计算图片控件的frame
                CGFloat pictureX = JYJTopicCellMargin;
                CGFloat pictureY = JYJTopicCellTextY + textH + JYJTopicCellMargin;
                _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
                _cellHeight += pictureH + JYJTopicCellMargin;
            }
        } else if (self.type == JYJTopicTypeVoice) { // 声音帖子
            CGFloat voiceX = JYJTopicCellMargin;
            CGFloat voiceY = JYJTopicCellTextY + textH + JYJTopicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * [self.height floatValue] / [self.width floatValue];
            _pictureF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            _cellHeight += voiceH + JYJTopicCellMargin;
        } else if (self.type == JYJTopicTypeVideo) { // 视频帖子
            CGFloat videoX = JYJTopicCellMargin;
            CGFloat videoY = JYJTopicCellTextY + textH + JYJTopicCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * [self.height floatValue] / [self.width floatValue];
            _pictureF = CGRectMake(videoX, videoY, videoW, videoH);
            
            _cellHeight += videoH + JYJTopicCellMargin;
        }
        // 底部工具条的高度
        _cellHeight += JYJTopicCellBottomBarH + JYJTopicCellMargin;
        
    }
    return _cellHeight;
}

@end
