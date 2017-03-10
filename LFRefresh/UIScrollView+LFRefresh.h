//
//  UIScrollView+LFRefresh.h
//  LFRefresh
//
//  Created by daoxiu on 2017/3/8.
//  Copyright © 2017年 aowokeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LFHeaderView;
@class LFFooterView;
@interface UIScrollView (LFRefresh)
@property(nonatomic,strong)LFHeaderView *lf_headerView;
@property(nonatomic,strong)LFFooterView *lf_footerView;
-(LFHeaderView*)addHeaderView:(LFHeaderView*)headerView handel:(void(^)())handel;
-(LFFooterView*)addFooterView:(LFFooterView*)footerView handel:(void(^)())handel;
@end
