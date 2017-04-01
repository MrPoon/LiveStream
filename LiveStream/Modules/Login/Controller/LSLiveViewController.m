//
//  LSLiveViewController.m
//  LiveStream
//
//  Created by Panyangjun on 2017/3/29.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import "LSLiveViewController.h"
#import "LSLivePlayView.h"
#import "LSLiveTabPageView.h"
#import "TYTabButtonPagerController.h"
#import "LSChatRoomViewController.h"
@interface LSLiveViewController ()<TYPagerControllerDataSource>
@property(nonatomic, strong) LSLivePlayView *playView;
@property(nonatomic, strong) TYTabButtonPagerController *pagerController;
@property(nonatomic, strong) UIButton *attentionButton;
@property(nonatomic, strong) NSArray *tabPageTitle;
@end

@implementation LSLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self.view addSubview:self.playView];
    [self addPagerController];
}

-(LSLivePlayView *)playView
{
    if (!_playView) {
        NSString *LiveStreamUrl = [NSString stringWithFormat:LIVESTREAMURL,self.liveModel.uid];
        _playView = [[LSLivePlayView alloc] initWithFrame:CGRectMake(0, 20, kScreen_Width, kScreen_Width * 9 / 16) WithURLString:LiveStreamUrl];
        [_playView updateOnlineNumberWith:self.liveModel.view];
        @weakify(self);
        [_playView.exitPlaySignal subscribeNext:^(id x) {
            @strongify(self);
            if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
                 self.attentionButton.hidden = NO;
                 [self forceOrientation:UIInterfaceOrientationPortrait];
            } else {
                 [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        [_playView.fullScreenSignal subscribeNext:^(id x) {
            @strongify(self);
            self.attentionButton.hidden = YES;
            [self forceOrientation:UIInterfaceOrientationLandscapeRight];
        }];
    }
    return _playView;
}
//MARK: - 添加视图
- (void)addPagerController
{
    _pagerController = [[TYTabButtonPagerController alloc]init];
    _pagerController.dataSource  = self;
    _pagerController.barStyle    = TYPagerBarStyleProgressBounceView;
    [self addChildViewController:_pagerController];
    [self.view addSubview:_pagerController.view];
    @weakify(self);
    [_pagerController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view);
        make.top.equalTo(self.playView.mas_bottom);
        make.right.equalTo(self.view.mas_right).offset(-80);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    [self configureTabButtonPager];
    [self.view addSubview:self.attentionButton];
}

- (void)configureTabButtonPager
{
    self.pagerController.normalTextColor   = HexRGB(0x9f9f9f);
    self.pagerController.selectedTextColor =
    self.pagerController.progressColor     = HexRGB(0xf25c5d);
    self.pagerController.normalTextFont    =
    self.pagerController.selectedTextFont  = [UIFont systemFontOfSize:14];
    self.pagerController.cellWidth         = (kScreen_Width - 80) / 3;
}
-(UIButton *)attentionButton
{
    if (!_attentionButton) {
        _attentionButton = [[UIButton alloc] init];
        _attentionButton.backgroundColor = [UIColor redColor];
        [_attentionButton setTitle:@"关注" forState:UIControlStateNormal];
        [_attentionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_attentionButton setImage:[UIImage imageNamed:@"tabbar_follow_default"] forState:UIControlStateNormal];
        _attentionButton.frame = CGRectMake(kScreen_Width - 80, CGRectGetMaxY(self.playView.frame), 80, 36);
    }
    return _attentionButton;
}
-(NSArray *)tabPageTitle
{
    if (!_tabPageTitle) {
        _tabPageTitle = @[@"chat",@"order",@"user"];
    }
    return _tabPageTitle;
}
#pragma mark -TYPagerControllerDataSource
- (NSInteger)numberOfControllersInPagerController
{
    return self.tabPageTitle.count;
}

- (NSString *)pagerController:(TYPagerController *)pagerController titleForIndex:(NSInteger)index
{
    return [self.tabPageTitle objectAtIndex:index];
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index
{
    if (index == 0) {
        LSChatRoomViewController *chatRoomVC = [[LSChatRoomViewController alloc] init];
        return chatRoomVC;
    }
    return [[UIViewController alloc] init];
}

//手动设置方向
- (void)forceOrientation: (UIInterfaceOrientation)orientation {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget: [UIDevice currentDevice]];
        int val = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

#pragma mark 屏幕旋转监听
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    //coordinator 记录屏幕旋转时的信息（时间）
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    NSTimeInterval time = [coordinator transitionDuration];
    @weakify(self);
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        //执行动画
        @strongify(self);
        if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
            [UIView animateWithDuration:time animations:^{
                self.playView.frame = self.view.bounds;
            }];
        } else {
            [UIView animateWithDuration:time animations:^{
                self.playView.frame = CGRectMake(0, 20, kScreen_Width, kScreen_Width * 9 / 16);
            } completion:^(BOOL finished) {
            }];
        }
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

//融云继承步骤
//1、初始化
//2、获取token
//3、连接融云服务器


@end
