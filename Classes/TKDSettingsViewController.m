//
//  TKDSettingsViewController.m
//  Pods
//
//  Created by Taras Kalapun on 25/11/13.
//
//

#import "TKDSettingsViewController.h"

#ifdef COCOAPODS_POD_AVAILABLE_InAppSettingsKit
#import "IASKSettingsReader.h"
#import "IASKSettingsStoreUserDefaults.h"


@interface TKDSettingsStoreUserDefaults : IASKSettingsStoreUserDefaults
@end
@implementation TKDSettingsStoreUserDefaults

- (void)setBool:(BOOL)value forKey:(NSString*)key {
    NSArray *components = [key componentsSeparatedByString:@"."];
    if (components.count == 2) {
        NSString *key = components[0];
        NSString *key2 = components[1];
        
        NSMutableDictionary *d = [[self.defaults objectForKey:key] mutableCopy];
        if (!d) d = NSMutableDictionary.new;
        d[key2] = @(value);
        [self.defaults setObject:d forKey:key];
    } else {
        [super setBool:value forKey:key];
    }
}


- (BOOL)boolForKey:(NSString*)key {
    return [[self.defaults valueForKeyPath:key] boolValue];
//    return [self.defaults boolForKey:key];
}

- (id)objectForKey:(NSString *)key {
    return [self.defaults valueForKeyPath:key];
}

@end


@interface TKDSettingsViewController ()
- (IASKSettingsReader*)settingsReader;
@end

@implementation TKDSettingsViewController

//@synthesize settingsReader = _settingsReader;
@synthesize settingsStore = _settingsStore;

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
	if ((self.appVersion.length > 0) && (section == [self.settingsReader numberOfSections]-1)) {
		// Show Version
        return [NSString stringWithFormat:NSLocalizedString(@"Version: %@", nil), self.appVersion];
	} else {
		return [super tableView:tableView titleForFooterInSection:section];
	}
}

//- (IASKSettingsReader*)settingsReader {
//	if (!_settingsReader) {
//		_settingsReader = [[IASKSettingsReader alloc] initWithFile:self.file];
//	}
//	return _settingsReader;
//}

- (id<IASKSettingsStore>)settingsStore {
	if (!_settingsStore) {
		_settingsStore = [[TKDSettingsStoreUserDefaults alloc] init];
	}
	return _settingsStore;
}

@end
#endif