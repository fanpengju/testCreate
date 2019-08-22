//
//  FYTestXibViewController.m
//  Demo
//
//  Created by Eju on 2019/7/12.
//  Copyright © 2019年 Eju. All rights reserved.
//

#import "FYTestXibViewController.h"

@interface FYTestXibViewController ()

@end

@implementation FYTestXibViewController
- (IBAction)click:(id)sender {
    
    self.top.constant = self.top.constant+20;
    self.buttonTop.constant = self.buttonTop.constant+20;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.top.constant = 150;
    
 
    
    
    
}


@end
