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
    
    NSString *fullChaoyang = [NSString stringWithFormat:@"%ld人在看", cellModel.number];
    NSRange range = [fullChaoyang rangeOfString:[NSString stringWithFormat:@"%ld", cellModel.number]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:fullChaoyang];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range: range];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    self.numberLabel.attributedText = attr;
    NSString *string = [self getBinaryFromIntegar:255];
    NSLog(@"%@",string);
}

-(NSString *)getBinaryFromIntegar:(NSInteger)integar
{
    NSString *Binary = @"1";
    while (integar / 2) {
        integar = integar / 2;
        Binary = [Binary stringByAppendingString:[NSString stringWithFormat:@"%ld",integar % 2]];
    }
    return Binary;
    
}


//指针变量1—> 指向堆中的对象1
//指针变量2（copy)->指向堆中的对象1
//1.此时操作指针变量2（实际对象1），不进行指针变量2重新赋值，此时的操作会同步到外部的对象1
//比如说（对象1是一个model，此时只操作model的属性修改）
//2.此时进行指针变量2重新赋值操作，就相当于指向了一个新的对象，此时操作指针2，不会影响到对象1的内容。
//比如说（对象1是一个NSString,此时重新初始化一个新的字符串，赋值操作）
//当遇到情形2的时候，并且需要函数内部的修改操作同步到外部，可以采用把参数以（双指针的形式传递）
//函数的形参是实参copy出来的一份。
//双指针的原理就是，但形参copy实参的时候，此时参数是一个双指针的值。
//NSString *string;
//[self stringWithString:&string];
//-(NSString *)stringWithString:(NSString **)string1 {
    //形参是一个新的指针变量string1，是从实参指针变量string copy出来的一份。
    //此时两个指针变量指向的内容（指针变量string的地址）相同，
    //使用*string1取出内容（指针变量string的地址）进行任何操作，都会同步到实参上，因为此时操作的是地址
    //*strong1 = @"hello word";
    //return *string1;
//}
@end
