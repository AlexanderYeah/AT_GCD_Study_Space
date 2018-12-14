### dispatch_source

是BSD系内核惯有的kqueue的包装，kqueue 是XNU内核中发生各种事件时，在应用程序编程中执行处理的技术。

CPU 负荷非常小，尽量不占用资源。



#### dispatch_queue 和dispatch_source 

dispatch_source 是可以取消的，取消也是有对应的回调的。



### dispatch source的种类



|              名称              |          内容          |
| :----------------------------: | :--------------------: |
|   DISPATCH_SOURCE_TYPE_READ    |     可读取文件映像     |
|   DISPATCH_SOURCE_TYPE_PROC    | 检测到与进程相关的事件 |
|  DISPATCH_SOURCE_TYPE_SIGNAL   |        接收信号        |
|   DISPATCH_SOURCE_TYPE_TIMER   |         定时器         |
|   DISPATCH_SOURCE_TYPE_VNODE   |     文件系统有变更     |
|   DISPATCH_SOURCE_TYPE_WRITE   |     可写入文件映像     |
| DISPATCH_SOURCE_TYPE_DATA_ADD  |        变量增加        |
|  DISPATCH_SOURCE_TYPE_DATA_OR  |         变量or         |
| DISPATCH_SOURCE_TYPE_MACH_SEND |     MACH 端口发送      |
| DISPATCH_SOURCE_TYPE_MACH_RECV |     MACH 端口接收      |





### 定时器示例



```objective-c
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




```





验证码倒计时



```objective-c
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
```

