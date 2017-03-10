//
//  LFRefreshComponentView.m
//  LFRefresh
//
//  Created by daoxiu on 2017/3/9.
//  Copyright © 2017年 aowokeji. All rights reserved.
//

#import "LFRefreshComponentView.h"
#import "LFRefreshConst.h"
@implementation LFRefreshComponentView
-(instancetype)init{
    if (self = [super init]) {
        [self setupUI];
        [self initData];
    }
    return self;
}
#pragma mark - 自定义UI
-(void)setupUI{}
#pragma mark - 初始化数据
-(void)initData{}
-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (!newSuperview ||![newSuperview isKindOfClass:[UIScrollView class]]) return;
    [self removeObserver];
    if(newSuperview) {
        _scrollView = (UIScrollView*)newSuperview;
        _scrollView.alwaysBounceVertical = YES;
        _edgeInsets = _scrollView.contentInset;
        [self addObserver];
    }
}
#pragma mark - 添加观察者
-(void)addObserver{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:LFObservezKeyPathOfContentOffset options:options context:nil];
    [self.scrollView addObserver:self forKeyPath:LFObservezKeyPathOfContentSize options:options context:nil];
}
#pragma mark - 删除观察者
-(void)removeObserver{
    [self.superview removeObserver:self forKeyPath:LFObservezKeyPathOfContentOffset];
    [self.superview removeObserver:self forKeyPath:LFObservezKeyPathOfContentSize];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    // 遇到这些情况就直接返回
    if (!self.userInteractionEnabled) return;
    // 这个就算看不见也需要处理
    if ([keyPath isEqualToString:LFObservezKeyPathOfContentSize]) {
        [self scrollViewContentSizeDidChange:change];
    }
    // 看不见
    if (self.hidden) return;
    if ([keyPath isEqualToString:LFObservezKeyPathOfContentOffset]) {
        [self scrollViewContentOffsetDidChange:change];
    }
}
-(void)setRefreshState:(LFRefreshState)refreshState{
    _refreshState = refreshState;
    switch (_refreshState) {
        case LFRefreshStateNormal:{
            [self normalStateDid];
            break;
        }
        case LFRefreshStatePulling:
            [self pullingStateDid];
            break;
        case LFRefreshStateLoading:{
            [self loadingStateDid];
            break;
        }
        default:
            break;
    }
}
-(void)normalStateDid{
    [UIView animateWithDuration:AnimationInterval animations:^{
        self.scrollView.contentInset = self.edgeInsets;
    }];
}
-(void)pullingStateDid{}
-(void)loadingStateDid{}
-(void)scrollViewContentSizeDidChange:(NSDictionary*)change{}
-(void)scrollViewContentOffsetDidChange:(NSDictionary*)change{}
-(void)endRefresh{}
-(void)dealloc{
    [self removeObserver];
}
@end
