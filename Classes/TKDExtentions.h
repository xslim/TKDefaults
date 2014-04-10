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
+ (void)showBlocking;
+ (void)showError:(NSError *)error;
+ (void)dismissWithPossibleMessage:(id)responce;
@end
#endif

@interface UIStoryboard (TKDExtentions)
+ (id)instantiateViewControllerWithIdentifier:(NSString *)identifier inStoryboardWithName:(NSString *)storyboardName;
@end

@interface NSUserDefaults (TKDExtentions)
- (void)setBool:(BOOL)value forKeyPath:(NSString*)keyPath;
@end