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

#ifdef COCOAPODS_POD_AVAILABLE_BloodMagic
    #import <BloodMagic/BMLazy.h>
    #import <BloodMagic/BMInitializer+LazyInitializer.h>
#endif

#ifdef COCOAPODS_POD_AVAILABLE_MagicalRecord
    #define MR_SHORTHAND
    #import "CoreData+MagicalRecord.h"
#endif

#import "TKDExtentions.h"

@interface TKDefaults : NSObject

//+ (void)inject;
+ (void)configureWithParameters:(NSDictionary *)params;

+ (void)loadInMain;

#ifdef COCOAPODS_POD_AVAILABLE_InAppSettingsKit
+ (void)attachHiddenSettingsTo:(UIView *)view;
+ (void)showHiddenSettings;
#endif

+ (NSString *)appVersion;
+ (NSBundle *)currentLanguageBundle;

+ (void)reloadAppTheme;

@end

extern const NSString *TKDUserKey;
extern const NSString *TKDKeyKey;

extern const NSString *TKDPixateKey;
extern const NSString *TKDTestFlightKey;
extern const NSString *TKDGoogleAnalyticsKey;


