//
//  TKDefaultsMacros.h
//  Pods
//
//  Created by Taras Kalapun on 25/11/13.
//
//

// This macro's allows us to set the current language, without restarting the app.
// To change the language use [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObject:@"de"] forKey:@"AppleLanguages"];
#undef NSLocalizedString
#define NSLocalizedString(key, comment) NSLocalizedStringFromTableInBundle(key, nil, [TKDefaults currentLanguageBundle], @"")

#ifdef COCOAPODS_POD_AVAILABLE_TTTLocalizedPluralString
#define TKDLocalizedPluralString(count, singular, comment) [NSString stringWithFormat:[[TKDefaults currentLanguageBundle] localizedStringForKey:TTTLocalizedPluralStringKeyForCountAndSingularNoun(count, singular) value:@"" table:nil], count]
#endif

#undef NSLog
#ifdef COCOAPODS_POD_AVAILABLE_NBULog
    #import "NBULog.h"
    #ifdef DEBUG
        #define NSLog(fmt, ...) NBULogInfo(fmt,  ##__VA_ARGS__)
    #endif
#endif