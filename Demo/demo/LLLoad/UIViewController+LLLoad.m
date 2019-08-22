//
//  UIViewController+LLLoad.m
//  Demo
//
//  Created by Eju on 2019/8/6.
//  Copyright © 2019年 Eju. All rights reserved.
//

#import "UIViewController+LLLoad.h"

@implementation UIViewController (LLLoad)

- (void)viewDidLoad{
    
    if ([self isKindOfClass:NSClassFromString(@"LLLoadViewController")]) {
        NSLog(@"111");
    }
    
    
}


@end
