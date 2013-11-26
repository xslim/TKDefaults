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

@interface TKDSettingsViewController ()
- (IASKSettingsReader*)settingsReader;
@end

@implementation TKDSettingsViewController

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
	if ((self.appVersion.length > 0) && (section == [self.settingsReader numberOfSections]-1)) {
		// Show Version
        return [NSString stringWithFormat:NSLocalizedString(@"Version: %@", nil), self.appVersion];
	} else {
		return [super tableView:tableView titleForFooterInSection:section];
	}
}

@end
#endif