//
//  IVTableViewCell.m
//  BSBDQJTestDemo
//
//  Created by XGJ on 16/5/31.
//  Copyright © 2016年 XGJ. All rights reserved.
//
#import "Masonry.h"
#import "IVTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface IVTableViewCell()
/**
 *  用户头像
 */
@property (nonatomic,strong) UIImageView *iconimg;

/**
 *  用户发布图片
 */
@property (nonatomic,strong) UIImageView *img;

/**
 *  用户名称
 */
@property (nonatomic,strong) UILabel *nametext;

/**
 *  用户标题
 */
@property (nonatomic,strong) UILabel *titletext;
@property (nonatomic,strong) UILabel *MP4;
@property (nonatomic,strong) UIImageView *PlayVideo;

@property (nonatomic,strong)DatasModel *data;
@property (nonatomic,assign)CGFloat height;
@end
@implementation IVTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (!_iconimg) {
            _iconimg = [UIImageView new];
            _iconimg.contentMode = UIViewContentModeCenter;
            _iconimg.layer.masksToBounds = YES;
            _iconimg.layer.borderColor = [UIColor orangeColor].CGColor;
            _iconimg.layer.borderWidth = 2;
            _iconimg.layer.cornerRadius = 15;
            [self.contentView addSubview:_iconimg];
        }
        if (!_nametext)
        {
            _nametext = [UILabel new];
            _nametext.backgroundColor = [UIColor clearColor];
            _nametext.font = [UIFont systemFontOfSize:14];
            _nametext.textAlignment = NSTextAlignmentLeft;
            [self.contentView addSubview:_nametext];
        }
        if (!_titletext){
            _titletext = [UILabel new];
            _titletext.backgroundColor = [UIColor clearColor];
            _titletext.font = [UIFont systemFontOfSize:14];
            _titletext.numberOfLines = 0;
            [self.contentView addSubview:_titletext];
            [_titletext mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(20);
                make.top.equalTo(_iconimg.mas_bottom).with.offset(10);
                make.right.mas_equalTo(-20);
                make.height.mas_equalTo(20);
            }];
        }
        if (!_img) {
            _img = [UIImageView new];
            _img.contentMode = UIViewContentModeCenter;
            _img.backgroundColor = [UIColor clearColor];
            [self.contentView addSubview:_img];
            UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeguanzhu:)];
            tgr.numberOfTapsRequired = 1;
            tgr.numberOfTouchesRequired = 1;
            [_img addGestureRecognizer:tgr];
        }
        
        if (!_PlayVideo) {
            _PlayVideo = [UIImageView new];
            _PlayVideo.contentMode = UIViewContentModeCenter;
            _PlayVideo.layer.masksToBounds = YES;
            _PlayVideo.layer.borderColor = [UIColor orangeColor].CGColor;
            _PlayVideo.layer.borderWidth = 2;
            _PlayVideo.layer.cornerRadius = 30;
            _PlayVideo.backgroundColor = [UIColor colorWithRed:0.365 green:0.259 blue:0.365 alpha:.4000];
            _PlayVideo.image = [UIImage imageNamed:@"play-voice-stop"];
            [_img addSubview:_PlayVideo];
        }
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self settingFrame:[self labelHeight:_titletext.text]];
}
//刷新from
- (void)settingFrame:(double)textheight
{
    [_iconimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        
    }];
    [_nametext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconimg.mas_right).with.offset(10);
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    [_titletext mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(textheight);
    }];
    [_PlayVideo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        
    }];
    _img.frame = CGRectMake(20, 50+textheight+10, self.bounds.size.width-40, _height);
    _img.contentMode = UIViewContentModeScaleAspectFit;
}
//获取数据
-(void)setbaisiqijieDatas:(DatasModel *)Datas{
    _data = Datas;
    [self Sdimage:self.iconimg url:[NSURL URLWithString:_data.profile_image]];
    _nametext.text = Datas.screen_name;
    _titletext.text = Datas.text;
    if (Datas.type ==JYJTopicTypeVideo) {
        _PlayVideo.hidden = NO;
    }
    else{
        _PlayVideo.hidden = YES;
    }
    [self heightImg:Datas];
    [self Sdimage:self.img url:[NSURL URLWithString:_data.cdn_img]];
}
//计算文字高度
-(CGFloat)labelHeight:(NSString *)str
{
    CGSize maxSize = CGSizeMake(self.bounds.size.width-40, MAXFLOAT);
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(0, 0, maxSize.width, 0);
    label.text = str;
    label.font = [UIFont systemFontOfSize:14];
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat textH = label.frame.size.height;
    return textH;
}
//计算图片高度
-(void)heightImg:(DatasModel *)Datas
{
    [Datas cellHeight];
    _height = Datas.pictureF.size.height;
}




//加载网络图片
-(void)Sdimage:(UIImageView *)imgs url:(NSURL *)url
{
    [imgs sd_setImageWithURL:url
                placeholderImage:nil
                         options:0
                        progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                            
                        }
                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                           imgs.image = image;
                       }];
}


-(void)closeguanzhu:(UITapGestureRecognizer *)send
{
    NSLog(@"%@",send);
    
}

@end
