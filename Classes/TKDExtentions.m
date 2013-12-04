//
//  TKDExtentions.m
//  Pods
//
//  Created by Taras Kalapun on 28/11/13.
//
//

#import "TKDExtentions.h"

#ifdef COCOAPODS_POD_AVAILABLE_SVProgressHUD
@implementation SVProgressHUD (Errors)

static NSString *currentDisplayedError = nil;
+ (void)showError:(NSError *)error
{
    NSString *errorDescription = [error localizedDescription];
    [SVProgressHUD showErrorWithStatus:errorDescription];
}

+ (void)showAlertError:(NSError *)error
{
    
    NSString *errorDescription = nil;
    if ([errorDescription length] > 0 && ![errorDescription isEqualToString:currentDisplayedError]) {
        currentDisplayedError = errorDescription;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:errorDescription delegate:self cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
        [alert show];
    }
    [SVProgressHUD dismiss];
}

+ (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    currentDisplayedError = nil;
}

@end
#endif