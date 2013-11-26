//
//  TKDSettingsViewController.h
//  Pods
//
//  Created by Taras Kalapun on 25/11/13.
//
//

#ifdef COCOAPODS_POD_AVAILABLE_InAppSettingsKit

#import "IASKAppSettingsViewController.h"

@interface TKDSettingsViewController : IASKAppSettingsViewController
@property (nonatomic, strong) NSString *appVersion;
@end

#endif