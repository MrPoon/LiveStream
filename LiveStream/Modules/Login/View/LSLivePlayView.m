//
//  LSLivePlayView.m
//  LiveStream
//
//  Created by Panyangjun on 2017/3/30.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import "LSLivePlayView.h"

@interface LSLivePlayView()

@property(nonatomic, strong) NSString *liveUrl;

@property(nonatomic, strong) IJKFFMoviePlayerController *player;

@property(nonatomic, strong) UIButton *backButton;

@property(nonatomic, strong) UIButton *fullScreenButton;
@property(nonatomic, strong) UIButton *numberButton;
@property(nonatomic, strong) UIActivityIndicatorView  *indicator;

@end
@implementation LSLivePlayView


-(instancetype)initWithFrame:(CGRect)frame WithURLString:(NSString *)aUrlString
{
    self = [super initWithFrame:frame];
    if (self)
        {
        self.backgroundColor = [UIColor whiteColor];
        _liveUrl = aUrlString;
        [self setupView];
        [self _loadPlayer];
        }
    return self;
}
-(void)setupView
{
    [self addSubview:self.backButton];
    [self addSubview:self.fullScreenButton];
    [self addSubview:self.numberButton];
    @weakify(self);
    [self.backButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self);
        make.left.equalTo(self.mas_left);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
    }];
    [self.fullScreenButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
    }];
    
    [self.numberButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left).offset(5);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(44);
    }];
    
    [self addSubview:self.indicator];
    [self.indicator mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.center.equalTo(self);
        make.width.height.mas_equalTo(80);
    }];
    [self.indicator startAnimating];
    self.exitPlaySignal = [self.backButton rac_signalForControlEvents:UIControlEventTouchUpInside];
    self.fullScreenSignal = [self.fullScreenButton rac_signalForControlEvents:UIControlEventTouchUpInside];
}
- (UIButton*)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"player_backButton_icon_30x30_"] forState:UIControlStateNormal];
        [_backButton setImage:[UIImage imageNamed:@"player_backButton_pressIcon_30x30_"] forState:UIControlStateHighlighted];
    }
    return _backButton;
}

- (UIButton*)fullScreenButton {
    if (!_fullScreenButton) {
        _fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenButton setImage:[UIImage imageNamed:@"player_fullScreen_icon_30x30_"] forState:UIControlStateNormal];
        [_fullScreenButton setImage:[UIImage imageNamed:@"player_fullScreen_pressIcon_30x30_"] forState:UIControlStateHighlighted];
    }
    return _fullScreenButton;
}

-(UIButton *)numberButton{
    if (!_numberButton) {
        _numberButton = [[UIButton alloc] init];
        [_numberButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _numberButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_numberButton setImage:[UIImage imageNamed:@"audienceCount"] forState:UIControlStateNormal];
        [_numberButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
        [_numberButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    return _numberButton;
}

- (UIActivityIndicatorView *)indicator
{
    if (!_indicator) {
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _indicator.clipsToBounds = YES;
        _indicator.layer.cornerRadius = 6;
    }
    return _indicator;
}


- (void)_loadPlayer
{
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    IJKFFMoviePlayerController *moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:_liveUrl withOptions:options];
    moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    moviePlayer.view.backgroundColor = [UIColor blackColor];
    moviePlayer.shouldAutoplay    = NO;
    moviePlayer.shouldShowHudView = NO;
    self.player = moviePlayer;
    [self addSubview:moviePlayer.view];
    [moviePlayer.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [moviePlayer prepareToPlay];
    
    [self insertSubview:self.indicator aboveSubview:self.player.view];
    [self insertSubview:self.backButton aboveSubview:self.player.view];
    [self insertSubview:self.fullScreenButton aboveSubview:self.player.view];
    [self insertSubview:self.numberButton aboveSubview:self.player.view];
    // 设置监听
    [self initObserver];
}

//MARK: - notify method
- (void)initObserver
{
    // 监听是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:self.player];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.player];
}

- (void)removeObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)stateDidChange
{
    if ((self.player.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0)
        {
        if (!self.player.isPlaying)
            {
            [self.player play];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.indicator stopAnimating];
            });
            }else
                {
                if (self.indicator.isAnimating) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.indicator stopAnimating];
                    });
                }
                }
        }else if (self.player.loadState & IJKMPMovieLoadStateStalled) //网络不佳,自动暂停状态
            {
            [self.indicator startAnimating];
            }
}

- (void)didFinish
{
    if (self.player.loadState & IJKMPMovieLoadStateStalled) {
        [self.indicator startAnimating];
        return;
    }
//    [SkyHttpClient requestWithType:SkyHttpRequestTypeGet
//                         UrlString:_liveUrl
//                        Parameters:nil
//                      SuccessBlock:^(id responseObject) {
//                          NSLog(@"请求成功, 等待继续播放");
//                      } FailureBlock:^(NSError *error) {
//                          NSLog(@"请求失败, 直播结束, 关闭播放器");
//                          [weakSelf.player shutdown];
//                          [weakSelf.player.view removeFromSuperview];
//                          weakSelf.player = nil;
//                      }];
}

- (void)playerShutdown
{
    if (self.player) {
        [self.player shutdown];
        [self.player.view removeFromSuperview];
        self.player = nil;
    }
}
-(void)updateOnlineNumberWith:(NSString *)numberStr
{
    [self.numberButton setTitle:numberStr forState:UIControlStateNormal];
}

@end
