//
//  UIScrollView+LFRefresh.m
//  LFRefresh
//
//  Created by daoxiu on 2017/3/8.
//  Copyright © 2017年 aowokeji. All rights reserved.
//

#import "UIScrollView+LFRefresh.h"
#import "LFHeaderView.h"
#import "LFFooterView.h"
#import <objc/runtime.h>

@implementation UIScrollView (LFRefresh)
static char const * LFRefreshHeaderViewKey = "LFRefreshHeaderViewKey";
static char const * LFRefreshFooterViewKey = "LFRefreshFooterViewKey";

/**头部视图**/
-(void)setLf_headerView:(LFHeaderView *)lf_headerView{
    if (lf_headerView != self.lf_headerView) {
        [self.lf_headerView removeFromSuperview];
        [self addSubview:lf_headerView];
        objc_setAssociatedObject(self, LFRefreshHeaderViewKey,lf_headerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
-(LFHeaderView *)lf_headerView{
    return objc_getAssociatedObject(self,LFRefreshHeaderViewKey);
}
-(LFHeaderView *)addHeaderView:(LFHeaderView *)headerView handel:(void (^)())handel{
    [headerView setValue:self forKey:@"scrollView"];
    [headerView setValue:handel forKey:@"refreshHandel"];
    return headerView;
}
/**尾部视图**/
-(void)setLf_footerView:(LFFooterView *)lf_footerView{
    if (lf_footerView != self.lf_footerView) {
        [self.lf_footerView removeFromSuperview];
        [self addSubview:lf_footerView];
        objc_setAssociatedObject(self, LFRefreshFooterViewKey,lf_footerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
-(LFFooterView *)lf_footerView{
    return objc_getAssociatedObject(self,LFRefreshFooterViewKey);
}
-(LFFooterView *)addFooterView:(LFFooterView *)footerView handel:(void (^)())handel{
    [footerView setValue:self forKey:@"scrollView"];
    [footerView setValue:handel forKey:@"refreshHandel"];
    return footerView;
}

@end
