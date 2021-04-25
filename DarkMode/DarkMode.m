//
//  DarkMode.m
//  
//
//  Created by yaozuopan on 2021/03/17.
//  Copyright © 2021 yaozuopan. All rights reserved.
//

#import "DarkMode.h"
#import <UIKit/UIKit.h>

@implementation UIView(DMSwizzlingSupportOfUIView)
+ (void)load {
    if ([[self class] respondsToSelector:@selector(swizzlingMomentOfUIView)]) {
        [[self class] swizzlingMomentOfUIView];
    }
}
@end


@implementation UILabel(DMSwizzlingSupportOfUILabel)
+ (void)load {
    if ([[self class] respondsToSelector:@selector(swizzlingMomentOfUILabel)]) {
        [[self class] swizzlingMomentOfUILabel];
    }
}
@end


@implementation UIButton(DMSwizzlingSupportOfUIButton)
+ (void)load {
    if ([[self class] respondsToSelector:@selector(swizzlingMomentOfUIButton)]) {
        [[self class] swizzlingMomentOfUIButton];
    }
}
@end


@implementation UIImageView(DMSwizzlingSupportOfUIImageView)
+ (void)load {
    if ([[self class] respondsToSelector:@selector(swizzlingMomentOfUIImageView)]) {
        [[self class] swizzlingMomentOfUIImageView];
    }
}
@end
