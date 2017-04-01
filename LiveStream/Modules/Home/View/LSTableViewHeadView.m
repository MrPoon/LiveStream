//
//  LSTableViewHeadView.m
//  LiveStream
//
//  Created by Panyangjun on 2017/3/29.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import "LSTableViewHeadView.h"

@interface LSTableViewHeadView ()
@property(nonatomic, strong) UIButton *titleButton;
@property(nonatomic, strong) UIButton *moreButton;
@end

@implementation LSTableViewHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
-(void)setupView
{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.titleButton];
    [self addSubview:self.moreButton];
    
    @weakify(self);
    [self.titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self);
        make.left.equalTo(self.mas_left).offset(15);
        make.width.mas_equalTo(100);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self);
        make.right.equalTo(self.mas_right);
        make.width.mas_equalTo(44);
        make.bottom.equalTo(self.mas_bottom);
    }];
}
-(UIButton *)titleButton{

    if (!_titleButton) {
        _titleButton = [[UIButton alloc] init];
        _titleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_titleButton setImage:[UIImage imageNamed:@"audienceCount"] forState:UIControlStateNormal];
        [_titleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
        [_titleButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    return _titleButton;
}
-(UIButton *)moreButton
{
    if (!_moreButton) {
        _moreButton = [[UIButton alloc] init];
        [_moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_moreButton setTitle:@"更多" forState:UIControlStateNormal];
    }
    return _moreButton;
}
-(void)setButtonImage:(NSString *)buttonImage
{
    _buttonImage = buttonImage;
     [_titleButton setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:buttonImage]]] forState:UIControlStateNormal];
}
-(void)setButtonTitle:(NSString *)buttonTitle
{
    _buttonTitle = buttonTitle;
    [_titleButton setTitle:buttonTitle forState:UIControlStateNormal];
}

@end
