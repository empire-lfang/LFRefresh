//
//  LFHeaderView.m
//  LFRefresh
//
//  Created by daoxiu on 2017/3/8.
//  Copyright © 2017年 aowokeji. All rights reserved.
//

#import "LFHeaderView.h"
#import "LFRefreshConst.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
typedef void(^LFRefreshHandel)();

@interface LFHeaderView ()

@property(nonatomic,strong)UILabel *textLab;
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,copy)LFRefreshHandel refreshHandel;
@property(nonatomic,assign)CGFloat dragHeight;
@property(nonatomic,assign)CGFloat dragThreshold;
@property(nonatomic,retain)NSDictionary *stateTextDic;
@end
@implementation LFHeaderView
static  const CGFloat TextFont = 12.0f;

-(void)setupUI{
    self.frame = CGRectMake(0, -LFRefreshHeaderHeight, kWidth, LFRefreshHeaderHeight);
    self.textLab = ({
        UILabel *labe       = [[UILabel alloc]init];
        labe.frame          = CGRectMake(0, 0,self.bounds.size.width , LFRefreshHeaderHeight);
        labe.textColor      = [UIColor orangeColor];
        labe.textAlignment  = NSTextAlignmentCenter;
        labe.font           = [UIFont systemFontOfSize:TextFont];
        [self addSubview:labe];
        labe;
    });
    self.iconImageView = ({
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(0, 0, 0, 0);
        imageView.image = [UIImage imageNamed:@""];
        [self addSubview:imageView];
        imageView;
    });
}
-(void)initData{
    self.stateTextDic = @{@"normalText" : @"下拉刷新",
                          @"pullingText" : @"释放更新",
                          @"loadingText" : @"加载中..."
                          };
    self.refreshState = LFRefreshStateNormal;
}

-(void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    if (self.dragHeight < 0||self.refreshState == LFRefreshStateLoading) {
        return;
    }
    if (self.scrollView.isDragging) {
        if (self.dragHeight>=self.dragThreshold) {
            self.refreshState = LFRefreshStatePulling;
        }else if (self.dragHeight<self.dragThreshold){
            self.refreshState = LFRefreshStateNormal;
        }
    }else{
        if (self.refreshState == LFRefreshStatePulling) {
            self.refreshState = LFRefreshStateLoading;
        }
    }
}
-(CGFloat)dragHeight{
    return (self.scrollView.contentOffset.y + self.edgeInsets.top)*-1.0;
}
-(CGFloat)dragThreshold{
    return LFRefreshHeaderHeight;
}
-(void)normalStateDid{
    [super normalStateDid];
    self.textLab.text = self.stateTextDic[@"normalText"];
}
-(void)pullingStateDid{
    self.textLab.text = self.stateTextDic[@"pullingText"];
}
-(void)loadingStateDid{
    self.textLab.text = self.stateTextDic[@"loadingText"];
    [UIView animateWithDuration:AnimationInterval animations:^{
        UIEdgeInsets inset = self.edgeInsets;
        inset.top          += LFRefreshHeaderHeight;
        self.scrollView.contentInset = inset;
    }];
    if (self.refreshHandel) {
        self.refreshHandel();
    }
}
-(void)endRefresh{
    self.refreshState = LFRefreshStateNormal;
}

@end
