//
//  STHomeHeadView.h
//  ST
//
//  Created by 周鑫 on 2018/9/28.
//  Copyright © 2018年 TJ. All rights reserved.
//

#import "STBasicView.h"

NS_ASSUME_NONNULL_BEGIN

@class STHomeHeadView,STBannerModel,STHomeCategoryBtnModel;
@protocol  STHomeHeadViewDelegate <NSObject>
@optional
- (void)homeHeadView:(STHomeHeadView *)homeHeadView didSelectBannerAtIndex:(NSInteger )index;
- (void)homeHeadView:(STHomeHeadView *)homeHeadView didSelectCategoryBtnAtIndex:(NSInteger)index;
- (void)homeHeadView:(STHomeHeadView *)homeHeadView didSelectedMoreBtn:(UIButton *)moreBtn;
@required
@end
@interface STHomeHeadView : UICollectionReusableView

- (void)setBanner:(NSArray<STBannerModel *> *)bannerModels;
- (void)setCategoryBtn:(NSArray<STHomeCategoryBtnModel *> *)categoryBtnModels;
@property (nonatomic,weak) id<STHomeHeadViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
