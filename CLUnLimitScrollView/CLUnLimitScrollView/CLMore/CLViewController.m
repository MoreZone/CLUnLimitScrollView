//
//  CLViewController.m
//  CLUnLimitScrollView
//
//  Created by More on 16/5/20.
//  Copyright © 2016年 More. All rights reserved.
//

#import "CLViewController.h"
#define Height [UIScreen mainScreen].bounds.size.height;
#define Width   [UIScreen mainScreen].bounds.size.width
#define countArray  self.dataArray.count
@interface CLViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *SC;
@property (weak, nonatomic) IBOutlet UIPageControl *Page;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;


/** 数组*/
@property(nonatomic,strong)NSArray  *dataArray;

/** 名称*/
@property(nonatomic,strong)NSArray  *titleArray;

/**  时间*/
@property(nonatomic,weak)NSTimer  *timer;
@end


@implementation CLViewController

#pragma make-----UI
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray =@[@"10_1",@"10_2",@"10_3",@"10_4",@"10_5",@"10_6"];
    _titleArray =@[@"第一张图片",@"第二张图片",@"第三张图片",@"第四张图片",@"第五张图片",@"第六张图片"];
    
    [self MakeUI];
    [self setupTimer];

}
-(void)setupTimer
{
    self.timer =[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(refresha) userInfo:nil repeats:YES];
}
-(void)MakeUI
{
    self.SC.delegate =self;
    self.SC.pagingEnabled =YES;
    self.Page.numberOfPages =self.dataArray.count;
    
    if (_titleArray.count>0) {
        self.nameLab.text =self.titleArray.firstObject;
    }else{
        self.nameLab.text =@"图片名称";
    }
    
    UIImageView *first =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width, CGRectGetMaxY(self.SC.frame))];
    first.image =[UIImage imageNamed:@"10_6"];
    [self.SC addSubview: first];
    for (NSInteger i =0; i<self.dataArray.count; i++) {
        UIImageView *imageV =[[UIImageView alloc]initWithFrame:CGRectMake(Width*(i+1), 0, Width, CGRectGetMaxY(self.SC.frame))];
        imageV.image =[UIImage imageNamed:[NSString stringWithFormat:@"10_%ld",(long)i+1]]
        ;
        [self.SC addSubview: imageV];
        
    }
    self.SC.contentSize =CGSizeMake(Width*(self.dataArray.count+2), 0);
    UIImageView *last =[[UIImageView alloc]initWithFrame:CGRectMake(Width*(self.dataArray.count+1), 0, Width, CGRectGetMaxY(self.SC.frame))];
    last.image =[UIImage imageNamed:@"10_1"];
    [self.SC addSubview: last];
    [_SC setContentOffset:CGPointMake(Width, 0)];
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sc:)];
    [_SC addGestureRecognizer:tap];
    
}
#pragma mark ---- 点击事件
-(void)sc:(UIScrollView*)sc{
    
    NSInteger index =self.SC.contentOffset.x/Width;
    
    NSLog(@"%ld",(long)index);
}


-(void)refresha
{
    NSInteger index =_SC.contentOffset.x/Width ;
    if (index<=countArray) {
        CGFloat x =_SC.contentOffset.x+Width;
        [_SC setContentOffset:CGPointMake(x, 0) animated:YES];
        if (index<self.titleArray.count) {
            self.nameLab.text =self.titleArray[index];
        }else{
            self.nameLab.text =@"第一张图片";
        }
    }else{
        
        [_SC setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    self.Page.currentPage =index;
    
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [_timer invalidate];
    
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setupTimer];
}


#pragma mark --- delete
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index =scrollView.contentOffset.x/Width-1;
    
    if (index==self.dataArray.count) {
        index =0;
    }else if (index==-1){
        index =self.dataArray.count-1;
    }
    self.Page.currentPage =index;
    self.nameLab.text =self.titleArray[index];
    
    NSLog(@"%ld",(long)index);
    if (scrollView.contentOffset.x ==Width*(self.dataArray.count+1)) {
        [scrollView setContentOffset:CGPointMake(Width, 0)];
        
    }else if (scrollView.contentOffset.x ==0){
        [scrollView setContentOffset:CGPointMake(Width*(_dataArray.count+1), 0)];
    }
    
    
}
//setContentOffset 改变时候会吊用
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index =scrollView.contentOffset.x/Width-1;
    if (index==self.dataArray.count) {
        index =0;
    }else if (index==-1){
        index =self.dataArray.count-1;
    }
    self.Page.currentPage =index;
    
   
    if (scrollView.contentOffset.x ==Width*(self.dataArray.count+1)) {
        [scrollView setContentOffset:CGPointMake(Width, 0)];
        
    }else if (scrollView.contentOffset.x ==0){
        [scrollView setContentOffset:CGPointMake(Width*(_dataArray.count+1), 0)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
