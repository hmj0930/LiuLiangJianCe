//
//  ViewController.m
//  LiuLiangJianCe
//
//  Created by MJ on 2017/4/1.
//  Copyright © 2017年 韩明静. All rights reserved.
//
// 写这个demo是因为在简书看了这篇文章http://www.jianshu.com/p/69f0b7f38cb6 但是简主使用的swift编写的，所以我就用oc重新写了一份 谢谢简主的思路

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong)UILabel *percentLabel;

@property(nonatomic,strong)UIButton *animationButton;

@property(nonatomic,strong)UITextField *inputTextField;

@property(nonatomic,strong)CAShapeLayer *progressLayer;

@property(nonatomic,strong)UIView *bgView;

@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic,assign)CGFloat progress;

@property(nonatomic,assign)CGFloat lastProgress;


@end

@implementation ViewController

-(NSTimer *)timer{
    
    if (_timer==nil) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:0.04 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }
    return _timer;
}

-(void)timerAction{
    
    if ([self.inputTextField.text floatValue]<=0||[self.inputTextField.text floatValue]>100) {
        
        [self.timer invalidate];
        self.timer=nil;
        
    }else{
        
        if (self.progress<=self.lastProgress) {
            
            self.lastProgress-=1;
            self.progressLayer.strokeEnd=self.lastProgress/100.0;
            CGFloat end=self.progressLayer.strokeEnd;
            self.percentLabel.text=[NSString stringWithFormat:@"%.1lf%@",end*100,@"%"];
            if (self.lastProgress==self.progress) {
                
                [self.timer invalidate];
                self.lastProgress=self.progress;
                self.timer=nil;
            }
            
            //            do {
            //                self.lastProgress-=1;
            //                self.progressLayer.strokeEnd=self.lastProgress/100.0;
            //                CGFloat end=self.progressLayer.strokeEnd;
            //                self.percentLabel.text=[NSString stringWithFormat:@"%.1lf%@",end*100,@"%"];
            //            } while (self.lastProgress>self.progress);
            //            [self.timer invalidate];
            //            self.lastProgress=self.progress;
            //            self.timer=nil;
            
        }else if (self.progress>self.lastProgress){
            
            self.lastProgress+=1;
            self.progressLayer.strokeEnd=self.lastProgress/100.0;
            CGFloat end=self.progressLayer.strokeEnd;
            self.percentLabel.text=[NSString stringWithFormat:@"%.1lf%@",end*100,@"%"];
            if (self.lastProgress==self.progress) {
                
                [self.timer invalidate];
                self.lastProgress=self.progress;
                self.timer=nil;
            }
            
            
            //            do {
            //                self.lastProgress+=1;
            //                self.progressLayer.strokeEnd=self.lastProgress/100.0;
            //                CGFloat end=self.progressLayer.strokeEnd;
            //                self.percentLabel.text=[NSString stringWithFormat:@"%.1lf%@",end*100,@"%"];
            //            } while (self.lastProgress<self.progress);
            //            [self.timer invalidate];
            //            self.timer=nil;
            //            self.lastProgress=self.progress;
        }
        
        
    }
}

-(UILabel *)percentLabel{
    
    if (_percentLabel==nil) {
        _percentLabel=[UILabel new];
        _percentLabel.textColor=[UIColor blueColor];
        _percentLabel.font=[UIFont systemFontOfSize:30];
        _percentLabel.textAlignment=NSTextAlignmentCenter;
        _percentLabel.text=@"0.0%";
    }
    return _percentLabel;
}

-(UITextField *)inputTextField{
    
    if (_inputTextField==nil) {
        _inputTextField=[UITextField new];
        _inputTextField.placeholder=@"范围0-100";
        _inputTextField.keyboardType=UIKeyboardTypeNumberPad;
        _inputTextField.layer.borderColor=[UIColor lightGrayColor].CGColor;
        _inputTextField.layer.borderWidth=1;
        _inputTextField.layer.masksToBounds=YES;
        _inputTextField.layer.cornerRadius=YES;
    }
    return _inputTextField;
}

-(UIButton *)animationButton{
    
    if (_animationButton==nil) {
        _animationButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_animationButton setTitle:@"Animation" forState:UIControlStateNormal];
        [_animationButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_animationButton addTarget:self action:@selector(animationButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _animationButton;
}

-(void)animationButtonAction{
    
    self.progress=[self.inputTextField.text floatValue];
    
    if (self.timer) {
        [self.timer fire];
    }else{
        self.timer=[NSTimer scheduledTimerWithTimeInterval:0.04 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }
    
    //    [UIView animateWithDuration:8 animations:^{
    //        self.progressLayer.strokeStart=0;
    //        self.progressLayer.strokeEnd=[self.inputTextField.text floatValue]/100.0;
    //        CGFloat end=self.progressLayer.strokeEnd;
    //        self.percentLabel.text=[NSString stringWithFormat:@"%.1lf%@",end*100,@"%"];
    //    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.progress=0;
    self.lastProgress=0;
    
    [self draw];
    [self draw1];
    
    self.percentLabel.bounds=CGRectMake(0, 0, 150, 80);
    self.percentLabel.center=self.view.center;
    [self.view addSubview:self.percentLabel];
    
    self.inputTextField.frame=CGRectMake(self.view.center.x-100, self.view.center.y-200, 100, 40);
    [self.view addSubview:self.inputTextField];
    
    self.animationButton.frame=CGRectMake(self.view.center.x+50, self.view.center.y-200, 100, 40);
    [self.view addSubview:self.animationButton];
    
}

-(void)draw{
    
    UIBezierPath *path=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.view.center.x-125, self.view.center.y-125, 250, 250) cornerRadius:10];
    CAShapeLayer *layer=[CAShapeLayer layer];
    layer.path=path.CGPath;
    layer.fillColor=[UIColor orangeColor].CGColor;
    [self.view.layer addSublayer:layer];
    
}

-(void)draw1{
    
    UIBezierPath *progressPath=[UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:100 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    CAShapeLayer *layer=[CAShapeLayer layer];
    layer.path=progressPath.CGPath;
    layer.strokeColor=[UIColor lightGrayColor].CGColor;
    layer.lineWidth=10;
    layer.fillColor=nil;
    [self.view.layer addSublayer:layer];
    
    self.progressLayer=[CAShapeLayer layer];
    self.progressLayer.path=progressPath.CGPath;
    self.progressLayer.strokeColor=[UIColor greenColor].CGColor;
    self.progressLayer.strokeEnd=0;
    self.progressLayer.strokeStart=0;
    self.progressLayer.lineWidth=10;
    self.progressLayer.fillColor=nil;
    [self.view.layer addSublayer:self.progressLayer];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.inputTextField resignFirstResponder];
}



@end
