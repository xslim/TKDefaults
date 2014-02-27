//
//  TKDExtentions.h
//  Pods
//
//  Created by Taras Kalapun on 28/11/13.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef COCOAPODS_POD_AVAILABLE_SVProgressHUD
#import "SVProgressHUD.h"
@interface SVProgressHUD (Errors)
+ (void)showError:(NSError *)error;
@end
#endif

@interface UIStoryboard (TKDExtentions)
+ (id)instantiateViewControllerWithIdentifier:(NSString *)identifier inStoryboardWithName:(NSString *)storyboardName;
@end