//
//  ViewController.m
//  BSBDQJTestDemo
//
//  Created by XGJ on 16/5/31.
//  Copyright © 2016年 XGJ. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImageView+WebCache.h"

#import "DatasModel.h"
@interface ViewController ()
{
    AVPlayer *player;
}
@property (nonatomic,strong)DatasModel *model;
@property (nonatomic,strong)UIScrollView *ScorrllView;


@property(nonatomic,strong)UIView*viewContainer;//最底层的视图，把所有的播放视图都放在它的上面

@property(nonatomic,strong)UIView*viewPlay;//播放视图

@property(nonatomic,strong)UIView*viewBack;//返回视图

@property(nonatomic,strong)UIButton*buttonPlay;//播放按钮

@property(nonatomic,strong)UIProgressView*progress;//缓存进度

@property(nonatomic,strong)UISlider*slider;//播放进度

@property(nonatomic,strong)UILabel*labelTime;//视频的时间

//@property(nonatomic,strong)AVPlayer*player;//播放器对象

@property(nonatomic,strong)AVPlayerItem*playerItem;// item

@property(nonatomic,assign)CGFloat totalMovieDuration;//当前视频的总时长
@end

@implementation ViewController
//-(void)viewDidLoad
//{
//    [super viewDidLoad];
//    //创建播放器层
//    if(_model ==nil){
//        
//    }else{
//    
//    AVPlayerLayer*playerLayer=[AVPlayerLayer playerLayerWithPlayer:self.player];
//    
//    playerLayer.frame=CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height-100);
//    
//    playerLayer.videoGravity=AVLayerVideoGravityResize;
//    
//    [self.view.layer addSublayer:playerLayer];
//    
//    
//    self.viewContainer= [[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height-100)];
//    
//    self.viewContainer.backgroundColor= [UIColor clearColor];
//    
//    [self.view addSubview:self.viewContainer];
//    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handlePresent:)];
//    
//    [self.viewContainer addGestureRecognizer:tap];
//    
//    
//    //创建播放视图和播放返回视图
//    
//    self.viewPlay= [[UIView alloc]initWithFrame:CGRectMake(0,self.view.bounds.size.height-60,self.view.bounds.size.width,50)];
//    
//    self.viewPlay.backgroundColor= [UIColor clearColor];
//    
//    [self.viewContainer addSubview:self.viewPlay];
//    
//    self.viewBack= [[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,50)];
//    
//    self.viewPlay.backgroundColor= [UIColor clearColor];
//    
//    [self.viewContainer addSubview:self.viewPlay];
//    
//    //播放暂停按钮事件
//    
//    self.buttonPlay= [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    self.buttonPlay.frame=CGRectMake(10,0,40,40);
//    
//    [self.buttonPlay setBackgroundImage:[UIImage imageNamed:@"iconfont-bofang"]forState:UIControlStateNormal];//暂停
//    
//    [self.buttonPlay setBackgroundImage:[UIImage imageNamed:@"iconfont-bofang1"]forState:UIControlStateSelected];//播放
//    
//    self.buttonPlay.layer.masksToBounds=YES;
//    
//    self.buttonPlay.layer.cornerRadius=20;
//    
//    self.buttonPlay.selected=YES;//默认为播放
//    
//    [self.viewPlay addSubview:self.buttonPlay];
//    
////    [self.buttonPlay addTarget:self action:@selector(handlePlay:)forControlEvents:UIControlEventTouchUpInside];
//    
//    //进度条按钮
//    
//    self.progress= [[UIProgressView alloc]initWithFrame:CGRectMake(82,20,self.view.bounds.size.width-200,10)];
//    
//    self.progress.progress=0;
//    
//    self.progress.progressTintColor= [UIColor colorWithRed:1.000 green:0.599 blue:0.345 alpha:1.000];
//    
//    [self.viewPlay addSubview:self.progress];
//    
//    // slider滑条事件
//    
//    self.slider= [[UISlider alloc]initWithFrame:CGRectMake(80,16,self.view.bounds.size.width-200,10)];
//    
//    self.slider.minimumValue=0;
//    
//    self.slider.maximumValue=0;
//    
//    self.slider.maximumTrackTintColor= [UIColor clearColor];
//    
//    [self.slider setThumbImage:[UIImage imageNamed:@"iconfont-yuan"]forState:UIControlStateNormal];
//    
//    [self.viewPlay addSubview:self.slider];
//    
////    [self.slider addTarget:self action:@selector(handleSlider:)forControlEvents:UIControlEventValueChanged];
//    
//    // labelTime显示
//    
//    self.labelTime= [[UILabel alloc]initWithFrame:CGRectMake(640,5,60,30)];
//    
//    self.labelTime.textColor= [UIColor whiteColor];
//    
//    self.labelTime.text=@"Time";
//    
//    [self.viewPlay addSubview:self.labelTime];
//    
//    }
//
//}
//-(void)handlePresent:(UITapGestureRecognizer *)gest
//{
//    [_player play];
//}
//
//#pragma mark -懒加载，创建播放器对象
//
//- (AVPlayer*)player{
//    
//    if(!_player) {
//        
//        _player=[AVPlayer playerWithPlayerItem:self.playerItem];
//        
//        //添加定时器，更新slider的进度
//        
////        [self refreshSliderPlan];
//        
//        //给AVPlayerItem添加播放完成通知
//        
////        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
//        
//    }
//    
//    return _player;
//    
//}
//
//#pragma mark -懒加载，创建AVPlayerItem对象
//
//- (AVPlayerItem*)playerItem
//
//{
//    
//    if(!_playerItem) {
//        
//        NSURL*url=[NSURL URLWithString:_model.videouri];
//        
//        self.playerItem= [AVPlayerItem playerItemWithURL:url];
//        
//        //观察playerItem的状态变化
//        
//        [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
//        
//        //加载缓存
//        
//        [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
//        
//    }
//    
//    return _playerItem;
//    
//}
//
//
///**
// 
// *通过KVO监控播放器状态
// 
// *
// 
// *  @param keyPath监控属性
// 
// *  @param object监视器
// 
// *  @param change状态改变
// 
// *  @param context上下文
// 
// */
//
//- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context{
//    
//    AVPlayerItem*playerItem = object;
//    
//    /**
//     
//     *     AVPlayerItemStatusUnknown,播放源未知
//     
//     *     AVPlayerItemStatusReadyToPlay,播放源准备好
//     
//     *     AVPlayerItemStatusFailed播放源失败
//     
//     */
//    
//    if([keyPath isEqualToString:@"status"]) {
//        
//        AVPlayerStatus status= [[change objectForKey:@"new"]intValue];
//        
//        if(status ==AVPlayerStatusReadyToPlay){
//            
//            NSLog(@"正在播放...，视频总长度:%.2f",CMTimeGetSeconds(playerItem.duration));
//            
//            //计算视频总时间
//            
//            CMTime totalTime = playerItem.duration;
//            
//            self.totalMovieDuration= (CGFloat)totalTime.value/ totalTime.timescale;
//            
//            //给slider赋值
//            
//            self.slider.maximumValue=self.totalMovieDuration+1;
//            
//            //设置按钮状态为播放
//            
//            self.buttonPlay.selected=YES;
//            
//            //转化时间的格式
//            
//            NSDate*d = [NSDate dateWithTimeIntervalSince1970:self.totalMovieDuration];
//            
//            NSDateFormatter*formatter = [[NSDateFormatter alloc]init];
//            
//            if(self.totalMovieDuration/3600>=1) {
//                
//                [formatter setDateFormat:@"HH:mm:ss"];
//                
//            }else{
//                
//                [formatter setDateFormat:@"mm:ss"];
//                
//            }
//            
//            NSString*showtimeNew = [formatter stringFromDate:d];
//            
//            //给labelTime赋值
//            
//            self.labelTime.text= showtimeNew;
//            
//        }
//        
//    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
//        
//        NSArray*array = playerItem.loadedTimeRanges;
//        
//        NSLog(@"array = %@", array);
//        
//        //本次缓冲时间范围
//        
//        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];
//        
//        float startSeconds =CMTimeGetSeconds(timeRange.start);
//        
//        float durationSeconds =CMTimeGetSeconds(timeRange.duration);
//        
//        //缓冲总长度
//        
//        NSTimeInterval totalBuffer = startSeconds + durationSeconds;
//        
//        NSLog(@"共缓冲：%.2f",totalBuffer);
//        
//        //更新进度条
//        
//        [self.progress setProgress:totalBuffer *1.0/self.totalMovieDuration];
//        
//    }
//    
//}
#pragma mark
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor brownColor]];
    [customLab setText:@"详情"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.titleView = customLab;
    self.view.backgroundColor = [UIColor blackColor];
    
    //    [self tableView];

    NSLog(@"%@",_model.videouri);
    if (_model.type==JYJTopicTypeVideo) {
        UIView *views = [UIView new];
        views.backgroundColor = [UIColor greenColor];
        views.frame = CGRectMake(0, 84, self.view.bounds.size.width, 230);
        [self.view addSubview:views];
        
        
        UIButton *btn = [UIButton new];
        
        [btn setImage:[UIImage imageNamed:@"play-voice-stop"] forState:UIControlStateNormal];
        btn.tag = 1001;
        [btn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(stops:) forControlEvents:UIControlEventTouchDown];
        btn.frame = CGRectMake(20, 200, 30, 30);
        [views addSubview:btn];
        
        
        
        
        
        
        
        NSURL *sourceMovieURL = [NSURL URLWithString:_model.videouri];
        AVAsset *movieAsset    = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
        player = [AVPlayer playerWithPlayerItem:playerItem];
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
        playerLayer.frame = CGRectMake(0, 0, views.frame.size.width, 200);
        //    [self.view addSubview:player];
        [views.layer addSublayer:playerLayer];
//        [player play];
        
        
        
        
        
    }else if (_model.type==JYJTopicTypePicture){
        _ScorrllView = [UIScrollView new];
        
        _ScorrllView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        _ScorrllView.backgroundColor = [UIColor clearColor];
        // 是否支持滑动最顶端
        _ScorrllView.scrollsToTop = YES;
//        _ScorrllView.delegate = self;
        // 设置内容大小
        _ScorrllView.contentSize = CGSizeMake(self.view.bounds.size.width, 460*10);
        // 是否反弹
        _ScorrllView.bounces = NO;
        // 是否分页
        //        scrollView.pagingEnabled = YES;
        // 是否滚动
        //        scrollView.scrollEnabled = NO;
        _ScorrllView.showsHorizontalScrollIndicator = NO;
        // 设置indicator风格
        _ScorrllView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        // 设置内容的边缘和Indicators边缘
//        _ScorrllView.contentInset = UIEdgeInsetsMake(0, 50, 50, 0);
        //    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        // 提示用户,Indicators flash
        [_ScorrllView flashScrollIndicators];
        // 是否同时运动,lock
        _ScorrllView.directionalLockEnabled = YES;
        [self.view addSubview:_ScorrllView];
        UIImageView *img = [UIImageView new];
        img.frame = self.view.frame;
        img.backgroundColor = [UIColor clearColor];
        [_ScorrllView addSubview:img];
        NSLog(@"%@",_model.cdn_img);

        [img sd_setImageWithURL:[NSURL URLWithString:_model.cdn_img]
                          placeholderImage:nil
                                   options:0
                                  progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                     
                                  } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                    
//                                      img.image = image;
                                      // 开启图形上下文
                                      UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0.0);
                                      // 将下载完的image对象绘制到图形上下文
                                      CGFloat width = self.view.bounds.size.width;
                                      CGFloat height = width * image.size.height / image.size.width;
                                      [image drawInRect:CGRectMake(0, 0, width, height)];
                                      //获得图片
                                      img.image = image;
                                      // 结束图形上下文
                                      UIGraphicsEndImageContext();
                                      int yhei = 0;
                                      if (self.view.bounds.size.height-64>height)
                                      {
                                          yhei =(self.view.bounds.size.height-64-height)/2;
                                      }
                                      img.frame = CGRectMake(0,yhei, width, height);
                                      _ScorrllView.contentSize = CGSizeMake(0, height);                                      
                                  }];
    }
  

    
}
-(void)stops:(UIButton *)send{
    NSLog(@"%@",@"停止");
    NSLog(@"%f",player.rate);
    if (send.tag ==1002) {
        [player pause];
        send.tag =1001;
       
    }else{
        send.tag =1002;

        [player play];
    
    }
}
-(void)getModel:(DatasModel *)model
{
    _model = model;
}
//
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
