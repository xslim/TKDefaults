//
//  TKScanKit
//
//  Copyright (c) 2013 Taras Kalapun. All rights reserved.
//

#import "TKDefaults.h"
#import <objc/runtime.h>

#ifdef COCOAPODS_POD_AVAILABLE_InAppSettingsKit
    #import <InAppSettingsKit/IASKAppSettingsViewController.h>
    #import <InAppSettingsKit/IASKSettingsReader.h>
#endif
#import "TKDSettingsViewController.h"

#ifdef COCOAPODS_POD_AVAILABLE_DCIntrospect
#if TARGET_IPHONE_SIMULATOR
#ifdef DEBUG
    //#import <DCIntrospect.h>
#endif
#endif
#endif

//void runOnMainQueueWithoutDeadlocking(void (^block)(void))
//{
//    if ([NSThread isMainThread])
//    {
//        block();
//    }
//    else
//    {
//        dispatch_sync(dispatch_get_main_queue(), block);
//    }
//}

@interface TKDefaults ()
#ifdef COCOAPODS_POD_AVAILABLE_InAppSettingsKit
<IASKSettingsDelegate>
#endif

@end

@implementation TKDefaults

static NSDictionary *tkDefaultsConfig;

+ (void)inject {
    NSLog(@"Injecting TKDefaults");
    
    [[self class] registerNotificationListeners];
}

+ (void)registerNotificationListeners
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:[self class]
           selector:@selector(applicationDidFinishLaunchingNotification:)
               name:UIApplicationDidFinishLaunchingNotification
             object:nil];
    
    [nc addObserver:[self class]
           selector:@selector(windowDidBecomeKeyNotification:)
               name:UIWindowDidBecomeKeyNotification
             object:nil];
    

    
}

+ (void)applicationDidFinishLaunchingNotification:(NSNotification *)notification
{

#ifdef COCOAPODS_POD_AVAILABLE_InAppSettingsKit
    [self initializeSettings];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:[self class] selector:@selector(appSettingsChangedNotification:) name:kIASKAppSettingChanged object:nil];
#endif
    

    
}

+ (void)appSettingsChangedNotification:(NSNotification *)note
{
//    NSLog(@"appSettingsChanged: %@", note);
    if (![note.object isKindOfClass:[NSString class]]) {
        return;
    }
    
}

//+ (void)reloadAppTheme
//{
//#ifdef COCOAPODS_POD_AVAILABLE_Pixate
//    NSString *fileName = [[NSUserDefaults standardUserDefaults] stringForKey:@"TKDThemeCSSFileName"];
//    if (fileName.length == 0) {
//        return;
//    }
//    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
//    [Pixate styleSheetFromFilePath:path withOrigin:PXStylesheetOriginApplication];
//    [Pixate updateStylesForAllViews];
//
//#endif
//#ifdef COCOAPODS_POD_AVAILABLE_PixateFreestyle
////    NSString *fileName = [[NSUserDefaults standardUserDefaults] stringForKey:@"TKDThemeCSSFileName"];
////    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
////    [PixateFreestyle styleSheetFromFilePath:path withOrigin:PXStylesheetOriginApplication];
////    [PixateFreestyle updateStylesForAllViews];
//#endif
//}

static BOOL initializedOnWindowDidBecomeKey;
+ (void)windowDidBecomeKeyNotification:(NSNotification *)notification
{
    // Just in case
    if (initializedOnWindowDidBecomeKey) {
        return;
    }
    initializedOnWindowDidBecomeKey = YES;
    
#ifdef COCOAPODS_POD_AVAILABLE_DCIntrospect
#if TARGET_IPHONE_SIMULATOR
#ifdef DEBUG
    //[[DCIntrospect sharedIntrospector] start];
#endif
#endif
#endif
    
    //UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //if (!window) return;
        
    
    // Remove notification
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:[self class] name:UIWindowDidBecomeKeyNotification object:nil];
}

#pragma mark - Public

+ (void)configureWithParameters:(NSDictionary *)params
{
    [self inject];
    [self setDefaultsConfig:params];
}

+ (void)loadInMain
{

}

#pragma mark - Usefull getters

+ (NSString *)appVersion
{
    NSString *versionString;
    NSString *bundleShortVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSArray *versionCompontents = [bundleShortVersionString componentsSeparatedByString:@"."];
    if ([versionCompontents count] == 2) {
        float tmpVersion = [versionCompontents[1] intValue] / 10.0f;
        versionString = [NSString stringWithFormat:@"%@.%.1f", versionCompontents[0], tmpVersion];
    } else {
        versionString = bundleShortVersionString;
    }
    NSString *bundleVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    
	return [NSString stringWithFormat:@"%@ (%@)", versionString, bundleVersion];
    
}

+ (NSBundle *)currentLanguageBundle
{
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSLocale preferredLanguages] objectAtIndex:0] ofType:@"lproj"]];
    if (!bundle) {
        bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"]];
    }
    
    return bundle;
}

+ (void)selectLanguage:(NSString *)language
{
    NSString *currentLanguage = nil;
    NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    if ([languages count] > 0) {
        currentLanguage = languages[0];
        if (![currentLanguage isEqualToString:language]) {
            [[NSUserDefaults standardUserDefaults] setObject:@[language] forKey:@"AppleLanguages"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            //[[NSNotificationCenter defaultCenter] postNotificationName:kLanguageDidChangeNotification object:nil userInfo:nil];
        }
    }
}

#pragma mark - SettingsKit

#ifdef COCOAPODS_POD_AVAILABLE_InAppSettingsKit

+ (void)attachHiddenSettingsTo:(UIView *)view
{
    view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(showHiddenSettings)];
    tapGesture.numberOfTapsRequired = 5;
    [view addGestureRecognizer:tapGesture];
}

+ (void)initializeSettings
{
    // standard stored preference values
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    // settings files to process
    NSMutableArray *preferenceFiles = [[NSMutableArray alloc] init];
    
    // begin with Root file
    [preferenceFiles addObject:@"Root"];
    
    // as other settings files are discovered will be added to preferencesFiles
    while ([preferenceFiles count] > 0) {
        
        // init IASKSettingsReader for current settings file
        NSString *file = [preferenceFiles lastObject];
        [preferenceFiles removeLastObject];
        IASKSettingsReader *settingsReader = [[IASKSettingsReader alloc] initWithFile:file];
        
        // extract preference specifiers
        NSArray *preferenceSpecifiers = settingsReader.settingsDictionary[kIASKPreferenceSpecifiers];
        
        // process each specifier in the current settings file
        for (NSDictionary *specifier in preferenceSpecifiers) {
            
            // get type of current specifier
            NSString *type = specifier[kIASKType];
            
            // need to check child pane specifier for additional file
            if ([type isEqualToString:kIASKPSChildPaneSpecifier]) {
                [preferenceFiles addObject:specifier[kIASKFile]];
            }
            else {
                // check if current specifier has a default value
                id defaultValue = specifier[kIASKDefaultValue];
                
                if (defaultValue) {
                    // get key from specifier and current stored preference value
                    NSString *key = specifier[kIASKKey];
                    id value = [defaults objectForKey:key];
                    
                    // update preference value with default value if necessary
                    if (key && value == nil) {
                        [defaults setObject:defaultValue forKey:key];
                    }
                }
            }
            
        }
        
    }
    
    // synchronize stored preference values
    [defaults synchronize];
}

+ (void)showHiddenSettings
{
    TKDSettingsViewController *vc = [[TKDSettingsViewController alloc] init];
    vc.delegate = self;
    vc.showCreditsFooter = NO;
    vc.showDoneButton = YES;

    vc.appVersion = [TKDefaults appVersion];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    nc.modalPresentationStyle = UIModalPresentationFormSheet;
    
    UIViewController *topController = [[UIApplication sharedApplication].keyWindow rootViewController];
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    [topController presentViewController:nc animated:YES completion:nil];
}

+ (void)settingsViewControllerDidEnd:(IASKAppSettingsViewController *)sender
{
    UIViewController *rootVC = [[UIApplication sharedApplication].keyWindow rootViewController];
    [rootVC dismissViewControllerAnimated:YES completion:nil];
}

+ (UITableViewCell*)tableView:(UITableView*)tableView cellForSpecifier:(IASKSpecifier*)specifier
{
    return nil;
}

#endif

#pragma mark - Private

static NSDictionary *tkDefaultsConfig;

+ (void)setDefaultsConfig:(NSDictionary *)dict {
    //id app = [UIApplication sharedApplication];
    //objc_setAssociatedObject(app, @selector(tkDefaultsConfig), dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    tkDefaultsConfig = [dict copy];
}

+ (NSDictionary *)config {
    //id app = [UIApplication sharedApplication];
    //return objc_getAssociatedObject(app, @selector(tkDefaultsConfig));
    return tkDefaultsConfig;
}



@end

extern const NSString *TKDUserKey;
extern const NSString *TKDKeyKey;

extern const NSString *TKDTestFlightKey;
extern const NSString *TKDGoogleAnalyticsKey;


const NSString *TKDUserKey = @"TKDUserKey";
const NSString *TKDKeyKey = @"TKDKeyKey";

const NSString *TKDTestFlightKey = @"TKDTestFlightKey";
const NSString *TKDGoogleAnalyticsKey = @"TKDGoogleAnalyticsKey";

