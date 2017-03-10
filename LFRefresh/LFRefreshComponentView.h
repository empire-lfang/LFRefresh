//
//  LFRefreshComponentView.h
//  LFRefresh
//
//  Created by daoxiu on 2017/3/9.
//  Copyright © 2017年 aowokeji. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LFRefreshHandel)();
typedef NS_ENUM(NSInteger,LFRefreshState){
    //正常状态
    LFRefreshStateNormal = 1,
    //拉拽状态
    LFRefreshStatePulling= 2,
    //加载状态
    LFRefreshStateLoading= 3
};
@interface LFRefreshComponentView : UIView
/**刷新状态**/
@property(nonatomic,assign)LFRefreshState refreshState;
@property(nonatomic,strong)UIScrollView *scrollView;
//记录scollView原始的contentInsets
@property(nonatomic,assign)UIEdgeInsets edgeInsets;
//更新UI
-(void)setupUI;
//设置数据
-(void)initData;
//停止更新和加载
-(void)endRefresh;
//scrollView的监听
-(void)scrollViewContentSizeDidChange:(NSDictionary*)change;
-(void)scrollViewContentOffsetDidChange:(NSDictionary*)change;
-(void)normalStateDid;
-(void)pullingStateDid;
-(void)loadingStateDid;

@end
