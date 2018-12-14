//
//  ViewController.m
//  GCD_dispatch_source_demo
//
//  Created by TrimbleZhang on 2018/12/14.
//  Copyright © 2018 AlexanderYeah. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}



- (IBAction)getCodeAction:(id)sender {
    
  
    
    __block int timeout= 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self->_verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                self->_verifyBtn.userInteractionEnabled = YES;
            });
            
        }else{

            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置

                [self->_verifyBtn setTitle:[NSString stringWithFormat:@"%@秒重发",strTime] forState:UIControlStateNormal];
                self->_verifyBtn.userInteractionEnabled = NO;
                
                
                
            });
            
            
            
            timeout--;
            
            
            
        }
        
        
        
    });
    
    
    
    dispatch_resume(_timer);
    
    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//
//    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
//
//    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0);
//
//    dispatch_source_set_event_handler(_timer, ^{
//        if (timeout <= 0) {
//            // 倒计时结束 关闭
//            dispatch_source_cancel(self->_timer);
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //设置界面的按钮显示 根据自己需求设置
//                self->_verifyBtn.userInteractionEnabled = YES;
//                [self->_verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//            });
//
//
//        }else{
//
//            int seconds = timeout % 60;
//            NSString *strTime = [NSString stringWithFormat:@"%d",seconds];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self->_verifyBtn setTitle:[NSString stringWithFormat:@"%@(秒重发)",strTime] forState:UIControlStateNormal];
//                self->_verifyBtn.userInteractionEnabled = NO;
//            });
//        }
//        // 没过一秒 --
//        timeout --;
//    });
//
//    dispatch_resume(_timer);
//
    
}




- (void)createTimer
{

    // 创建定时器
    dispatch_source_t timer =  dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    
    // 设置定时器
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC, 0);
    
    // 定时器处理
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"log一下子");
        // 定时器取消
        // dispatch_source_cancel(timer)
    });
    
    
    // 取消的回调
    dispatch_source_set_cancel_handler(timer, ^{
        NSLog(@"定时器取消了");
    });
    
 
    // 5  启动计时器
//    dispatch_resume(_timer);

}



@end
