//
//  LSHomeViewCell.m
//  LiveStream
//
//  Created by Panyangjun on 2017/3/2.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import "LSHomeViewCell.h"

#define AVATAR_WIDTH 40

@implementation LSHomeViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)setupView{
    @weakify(self);
    [self addSubview:self.avatarView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.addressButton];
    [self addSubview:self.numberLabel];
    [self addSubview:self.preImageView];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self).offset(5);
        make.left.equalTo(self.mas_left).offset(10);
        make.width.height.mas_equalTo(AVATAR_WIDTH);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self).offset(5);
        make.left.equalTo(self.avatarView.mas_right).offset(10);
    }];
    [self.startView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.titleLabel.mas_right).offset(20);
        make.top.equalTo(self);
        make.width.height.mas_equalTo(AVATAR_WIDTH);
    }];
    [self.addressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(134);
    }];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.addressButton.mas_right).offset(20);
        make.centerY.equalTo(self.avatarView.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    [self.preImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.avatarView.mas_bottom).offset(5);
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-5);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
}
-(UIImageView *)avatarView
{
    if (!_avatarView) {
        _avatarView = [[UIImageView alloc] init];
        _avatarView.contentMode = UIViewContentModeScaleAspectFit;
        _avatarView.layer.cornerRadius = AVATAR_WIDTH / 2;
        _avatarView.layer.masksToBounds = YES;
    }
    return _avatarView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}
-(UIButton *)addressButton{
    if (!_addressButton) {
        _addressButton = [[UIButton alloc] init];
        _addressButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_addressButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _addressButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_addressButton setImage:[UIImage imageNamed:@"home_location_8x8"] forState:UIControlStateNormal];
    }
    return _addressButton;
}
-(UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.textAlignment = NSTextAlignmentRight;
        _numberLabel.font = [UIFont systemFontOfSize:16];
    }
    return _numberLabel;
}
-(UIImageView *)preImageView
{
    if (!_preImageView) {
        _preImageView = [[UIImageView alloc] init];
        _preImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _preImageView;
}
-(void)setCellModel:(LSHomeViewCellModel *)cellModel
{
    _cellModel = cellModel;
    
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:cellModel.avatar] placeholderImage:[UIImage imageNamed:@"placeholder_head"]];
    self.titleLabel.text = cellModel.title;
    // 如果没有地址, 给个默认的地
    [self.addressButton setTitle:cellModel.address forState:UIControlStateNormal];
    [self.preImageView sd_setImageWithURL:[NSURL URLWithString:cellModel.content] placeholderImage:[UIImage imageNamed:@"profile_user_414x414"]];
    self.startView.image  = cellModel.startImage;
    self.startView.hidden = !cellModel.startleveal;
    
    // 设置当前观众数量
    NSString *fullChaoyang = [NSString stringWithFormat:@"%ld人在看", cellModel.number];
    NSRange range = [fullChaoyang rangeOfString:[NSString stringWithFormat:@"%ld", cellModel.number]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:fullChaoyang];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range: range];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    self.numberLabel.attributedText = attr;
}


@end
