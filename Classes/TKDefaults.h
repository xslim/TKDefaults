//
//  TKDefaults
//
//  Copyright (c) 2013 Taras Kalapun. All rights reserved.
//

#import "TKDefaultsMacros.h"

// Includes

#ifdef COCOAPODS_POD_AVAILABLE_ReactiveCocoa
    #import <ReactiveCocoa.h>
    #import <ReactiveCocoa/RACEXTScope.h>
#endif

#ifdef COCOAPODS_POD_AVAILABLE_MagicalRecord
    #define MR_SHORTHAND
    #import "CoreData+MagicalRecord.h"
#endif

#import "UIView+TKDStyling.h"

@interface TKDefaults : NSObject

+ (void)inject;
+ (void)configureWithParameters:(NSDictionary *)params;

+ (void)loadInMain;

#ifdef COCOAPODS_POD_AVAILABLE_InAppSettingsKit
+ (void)attachHiddenSettingsTo:(UIView *)view;
+ (void)showHiddenSettings;
#endif

+ (NSString *)appVersion;
+ (NSBundle *)currentLanguageBundle;

@end

extern const NSString *TKDUserKey;
extern const NSString *TKDKeyKey;

extern const NSString *TKDTestFlightKey;
extern const NSString *TKDGoogleAnalyticsKey;


