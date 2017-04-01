//
//  LSTableViewCell.m
//  LiveStream
//
//  Created by Panyangjun on 2017/3/29.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import "LSTableViewCell.h"
#import "LSCollectionViewCell.h"
#import "LSTableViewHeadView.h"
#import "LSLiveViewController.h"
static NSString *headReuseIdentifier = @"headReuseIdentifier";
static NSString *CollectionViewCell = @"LSCollectionViewCell";

@interface LSTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic, strong) UICollectionView *collectionView;
@end

@implementation LSTableViewCell

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
    }
    return self;
}

-(void)setupView
{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.collectionView];
    @weakify(self);
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
}
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 5;
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        layout.headerReferenceSize = CGSizeMake(kScreen_Width, 40);
        //每个section距离上方和下方20，左方和右方10
        layout.collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollEnabled = NO;
        [_collectionView registerClass:[LSCollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCell];
        [_collectionView registerClass:[LSTableViewHeadView class]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                       withReuseIdentifier:headReuseIdentifier];
    }
    return _collectionView;
}

-(void)setCategoryModel:(LSCategoryModel *)categoryModel
{
    _categoryModel = categoryModel;
    self.dataSource = categoryModel.list;
    [self.collectionView reloadData];
}


#pragma mark -collectionView Delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LSCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[LSCollectionViewCell alloc] init];
    }
    LSLiveModel *liveModel = [self.dataSource objectAtIndex:indexPath.item];
    cell.liveModel = liveModel;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreen_Width - 30)/2, ((kScreen_Width-30)/2) * 3 / 5 + 20);
}

- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        LSTableViewHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headReuseIdentifier forIndexPath:indexPath];
        headView.buttonTitle = self.categoryModel.name;
        headView.buttonImage = self.categoryModel.icon_red;
        reusableview = headView;
    }
    return reusableview;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LSLiveViewController *liveView = [[LSLiveViewController alloc] init];
    liveView.liveModel = [self.dataSource objectAtIndex:indexPath.item];
    [[self viewController].navigationController pushViewController:liveView animated:YES];
}
- (UIViewController *)viewController {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
