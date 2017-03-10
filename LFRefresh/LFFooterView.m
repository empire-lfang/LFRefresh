//
//  LFFooterView.m
//  LFRefresh
//
//  Created by daoxiu on 2017/3/9.
//  Copyright © 2017年 aowokeji. All rights reserved.
//

#import "LFFooterView.h"
#import "LFRefreshConst.h"
#define kWidth [UIScreen mainScreen].bounds.size.width

typedef void(^LFRefreshHandel)();
@interface LFFooterView ()

@property(nonatomic,strong)UILabel *textLab;
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,retain)NSDictionary *stateTextDic;
@property(nonatomic,copy)LFRefreshHandel refreshHandel;
@property(nonatomic,assign)CGFloat dragHeight;
@end
@implementation LFFooterView

-(void)setupUI{
    self.textLab = ({
        UILabel *labe       = [[UILabel alloc]init];
        labe.frame          = CGRectMake(0, 0,kWidth, LFRefreshHeaderHeight);
        labe.textColor      = [UIColor orangeColor];
        labe.text           = @"上拉查看更多";
        labe.textAlignment  = NSTextAlignmentCenter;
        labe.font           = [UIFont systemFontOfSize:12];
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
    self.stateTextDic = @{@"normalText" : @"上拉查看更多",
                          @"pullingText" : @"释放更新",
                          @"loadingText" : @"加载中..."
                          };
    self.refreshState = LFRefreshStateNormal;
}

-(void)refreshFrame{
    CGFloat height = MAX(self.scrollView.contentSize.height, self.frame.size.height);
    self.frame = CGRectMake(0, height, self.scrollView.bounds.size.width, LFRefreshFooterHeight);
}

-(CGFloat)dragHeight{
    CGFloat contentSize_Height = self.scrollView.contentSize.height;
    CGFloat scrollView_Height = self.scrollView.bounds.size.height;
    CGFloat contentOffset_Y = self.scrollView.contentOffset.y;
    CGFloat height = MAX(contentSize_Height, scrollView_Height);
    CGFloat dragH = contentOffset_Y +scrollView_Height - height - self.edgeInsets.bottom;
    return dragH;
}

-(void)normalStateDid{
    self.textLab.text = self.stateTextDic[@"normalText"];
    [UIView animateWithDuration:AnimationInterval animations:^{
        self.scrollView.contentInset = self.edgeInsets;
    }];
}
-(void)pullingStateDid{
    self.textLab.text = self.stateTextDic[@"pullingText"];
}
-(void)loadingStateDid{
    UIEdgeInsets insets = self.edgeInsets;
    insets.bottom += LFRefreshFooterHeight;
    self.scrollView.contentInset = insets;
    self.textLab.text = self.stateTextDic[@"loadingText"];
    if (self.refreshHandel) {
        self.refreshHandel();
    }
}
-(void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    if (self.dragHeight<=0) {
        return;
    }
    if (self.scrollView.isDragging) {
        if (self.dragHeight <= LFRefreshFooterHeight) {
            self.refreshState = LFRefreshStateNormal;
        }else{
            self.refreshState = LFRefreshStatePulling;
        }
    }else{
        if (self.refreshState == LFRefreshStatePulling) {
            self.refreshState = LFRefreshStateLoading;
        }
    }
}
-(void)scrollViewContentSizeDidChange:(NSDictionary *)change{
    [self refreshFrame];
}
-(void)endRefresh{
    self.refreshState = LFRefreshStateNormal;
}
@end
