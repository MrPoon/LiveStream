//
//  LSCollectionViewCell.m
//  LiveStream
//
//  Created by Panyangjun on 2017/3/27.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import "LSCollectionViewCell.h"

@interface LSCollectionViewCell ()
@property(nonatomic, strong) UILabel *nameLable;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIButton *numberButton;
@property(nonatomic, strong) UIImageView *preImageView;
@end

@implementation LSCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
-(void)setupView{
    @weakify(self);
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.preImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.numberButton];
    [self addSubview:self.nameLable];
    
    [self.preImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(((kScreen_Width-30)/2) * 3 / 5);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.bottom.equalTo(self.preImageView.mas_bottom);
        make.left.equalTo(self.mas_left).offset(5);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(20);
    }];
    
    [self.numberButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.mas_right).offset(-5);
        make.top.equalTo(self.preImageView.mas_bottom);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(60);
    }];
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.preImageView.mas_bottom);
        make.left.equalTo(self.mas_left).offset(5);
        make.right.equalTo(self.numberButton.mas_left).offset(-5);
        make.height.mas_equalTo(30);
    }];
    
}
-(UILabel *)nameLable
{
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] init];
        _nameLable.font = [UIFont systemFontOfSize:14];
    }
    return _nameLable;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}
-(UIButton *)numberButton{
    if (!_numberButton) {
        _numberButton = [[UIButton alloc] init];
        [_numberButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _numberButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_numberButton setImage:[UIImage imageNamed:@"audienceCount"] forState:UIControlStateNormal];
        [_numberButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
        [_numberButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    return _numberButton;
}

-(UIImageView *)preImageView
{
    if (!_preImageView) {
        _preImageView = [[UIImageView alloc] init];
        _preImageView.contentMode = UIViewContentModeScaleAspectFill;
        _preImageView.clipsToBounds = YES;
    }
    return _preImageView;
}
-(void)setLiveModel:(LSLiveModel *)liveModel
{
    _liveModel = liveModel;
    self.titleLabel.text = liveModel.title;
    self.nameLable.text = liveModel.nick;
    // 如果没有地址, 给个默认的地
    [self.numberButton setTitle:liveModel.view forState:UIControlStateNormal];
    [self.preImageView sd_setImageWithURL:[NSURL URLWithString:liveModel.thumb] placeholderImage:[UIImage imageNamed:@""]];
}

@end
