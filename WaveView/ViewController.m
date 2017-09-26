//
//  ViewController.m
//  WaveView
//
//  Created by zhangqq on 2017/9/26.
//  Copyright © 2017年 张强. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(180, 250, 50, 50);
    bgView.backgroundColor = [UIColor greenColor];
    bgView.layer.cornerRadius = 25;
    [self.view addSubview:bgView];
    [self addAnimateForView:bgView withRect:CGRectMake(0, 0, 50, 50)];
    
}

-(void)addAnimateForView:(UIView *)view withRect:(CGRect)rect{
    CALayer *layer = [CALayer layer];//创建一个layer，最后用来添加到view的图层上展示动画用
    NSInteger repeatCount = 3;//设置重复次数3次
    NSInteger keepTiming = 3;// 设置每段动画持续时间3秒
    
    for (NSInteger i = 0; i< repeatCount; i++) {//每次执行，创建相关动画
        // 每个动画对应一个图层。3个动画，需要有3个图层
        CALayer *animateLayer = [CALayer layer];
        animateLayer.borderColor = [UIColor greenColor].CGColor;
        animateLayer.borderWidth = 3.5;
        animateLayer.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
        animateLayer.cornerRadius = rect.size.height/2;
        //到此。每一个图层的大小，形状。颜色设置完毕。
        // 设置图层的scale 使用CABasicAnimation
        CABasicAnimation *basicAni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        basicAni.fromValue = @1.0f;
        basicAni.toValue = @2.4f;
        
        //设置图层的透明度，使用关键帧动画
        CAKeyframeAnimation *keyani = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        keyani.values = @[@1, @0.9, @0.8, @0.7, @0.6, @0.5, @0.4, @0.3, @0.2, @0.1, @0];
        keyani.keyTimes = @[@0, @0.1, @0.2, @0.3, @0.4, @0.5, @0.6, @0.7, @0.8, @0.9, @1];
        
        //我们要让一个动画同时执行scale 和 opacity的变化，需要将他们都加入到layer的动画组
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.fillMode = kCAFillModeBackwards;
        group.duration = keepTiming;
        group.repeatCount = HUGE;
        group.beginTime = CACurrentMediaTime() + (double)i * keepTiming / (double)repeatCount;
        
        group.animations = @[keyani,basicAni];
        [animateLayer addAnimation:group forKey:@"plus"];
        [layer addSublayer:animateLayer];
    }
    [view.layer addSublayer:layer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
