//
//  ViewController.m
//  testXib
//
//  Created by 汤维炜 on 16/3/13.
//  Copyright © 2016年 Tommy. All rights reserved.
//

#import "ViewController.h"

#define UIScreenWidth self.view.frame.size.width

@interface ViewController ()

// 控件
@property (weak, nonatomic) IBOutlet UIView *workingView;
@property (weak, nonatomic) IBOutlet UIView *finishView;
@property (weak, nonatomic) IBOutlet UILabel *leftTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cycleImageView;

@property (weak, nonatomic) IBOutlet UILabel *workStatusLabel;
@property (weak, nonatomic) IBOutlet UIButton *operationBtn;
@property (weak, nonatomic) IBOutlet UIView *cycleStatusView;
@property (weak, nonatomic) IBOutlet UILabel *tasteLabel;
@property (weak, nonatomic) IBOutlet UILabel *sweetLabel;
@property (nonatomic, assign) double angle;
@property (nonatomic, strong) NSTimer *updateTimer;
@property (nonatomic, assign) int updateTime;
@property (weak, nonatomic) IBOutlet UILabel *workStatusLabelDes;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *workingViewMarginTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *finishViewMarginTop;
- (IBAction)clickOperation:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSTimer *cycleTime = [NSTimer scheduledTimerWithTimeInterval:10.f target:self selector:@selector(startCycleAnimation) userInfo:nil repeats:YES];
    [cycleTime fire];
    _angle = 0;
    _updateTime = 25;
    _updateTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(updateWorkStatusLabel) userInfo:nil repeats:YES];
    
    [self updateUIContranits];
    
}

- (void)updateUIContranits {
    
    _finishView.backgroundColor = [UIColor lightGrayColor];
    _workingView.backgroundColor = [UIColor whiteColor];
    
    if (UIScreenWidth == 375) {
        _finishViewMarginTop.constant += 130;
        _workingViewMarginTop.constant += 40;
    }else if (UIScreenWidth == 414) {
        _finishViewMarginTop.constant += 140;
        _workingViewMarginTop.constant += 50;
    }

}

- (void)updateWorkStatusLabel {
    _updateTime -= 1;
    if (_updateTime <= 0) {
        [_updateTimer invalidate];
        _updateTimer = nil;
        self.workingView.hidden = YES;
        self.finishView.hidden = NO;
        [self.operationBtn setTitle:@"完成" forState:UIControlStateNormal];
        self.workStatusLabelDes.text = @"您的美食已烹饪完成，可以享用美食了哦~";
        
    }else {
        _leftTimeLabel.text = [NSString stringWithFormat:@"预计%d分后完成",_updateTime];
    }
}

- (void)startCycleAnimation {

    if (_angle <= 0) {
        [self startAnimation];
    }
}

- (void)startAnimation {
    
    CATransform3D transform3d = CATransform3DMakeRotation(_angle*(M_PI/180.f), 0, 0, 1);
    int delayTime = 0.02;
    [UIView animateWithDuration:delayTime animations:^{
        _cycleImageView.layer.transform = transform3d;
        
    } completion:^(BOOL finished) {
        _angle += 3;
        [self startAnimation];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickOperation:(UIButton *)sender {
    UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:@"tips" message:@"it's over" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_updateTimer invalidate];
        _updateTimer =nil;
    }];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertCtr addAction:okAction];
    [alertCtr addAction:cancleAction];
    [self presentViewController:alertCtr animated:YES completion:nil];
    
}
@end
