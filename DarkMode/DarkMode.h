//
//  DarkMode.h
//  DarkMode
//
//  Created by Harvey on 2021/4/22.
//

#import <Foundation/Foundation.h>

//! Project version number for DarkMode.
FOUNDATION_EXPORT double DarkModeVersionNumber;

//! Project version string for DarkMode.
FOUNDATION_EXPORT const unsigned char DarkModeVersionString[];


@protocol DMSwizzlingProtocolOfUIView <NSObject>
@optional
+ (void)swizzlingMomentOfUIView;
@end


@protocol DMSwizzlingProtocolOfUILabel <NSObject>
@optional
+ (void)swizzlingMomentOfUILabel;
@end


@protocol DMSwizzlingProtocolOfUIButton <NSObject>
@optional
+ (void)swizzlingMomentOfUIButton;
@end


@protocol DMSwizzlingProtocolOfUIImageView <NSObject>
@optional
+ (void)swizzlingMomentOfUIImageView;
@end
