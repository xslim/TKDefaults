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

+ (void)showBlocking
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
}

static NSString *currentDisplayedError = nil;
+ (void)showError:(NSError *)error
{
    NSString *errorDescription = (error) ? [error localizedDescription] : nil;
    [SVProgressHUD showErrorWithStatus:errorDescription];
}

+ (void)dismissWithPossibleMessage:(id)responce
{
    if ([responce isKindOfClass:[NSDictionary class]]) {
        if (responce[@"message"]) {
            if (responce[@"status"] && [responce[@"status"] intValue] == 200) {
                [SVProgressHUD showSuccessWithStatus:responce[@"message"]];
            } else {
                [SVProgressHUD showImage:nil status:responce[@"message"]];
            }
            
            return;
        }
    }
    [SVProgressHUD dismiss];
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

@implementation UIStoryboard (TKDExtentions)
+ (id)instantiateViewControllerWithIdentifier:(NSString *)identifier inStoryboardWithName:(NSString *)storyboardName
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}
@end

@implementation NSUserDefaults (TKDExtentions)
- (void)setBool:(BOOL)value forKeyPath:(NSString*)keyPath
{
    NSArray *components = [keyPath componentsSeparatedByString:@"."];
    if (components.count == 2) {
        NSString *key = components[0];
        NSString *key2 = components[1];
        
        NSMutableDictionary *d = [[self objectForKey:key] mutableCopy];
        if (!d) d = NSMutableDictionary.new;
        d[key2] = @(value);
        [self setObject:d forKey:key];
    } else {
        [self setBool:value forKey:keyPath];
    }
}
@end