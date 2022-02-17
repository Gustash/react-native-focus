#import "FocusStatusIntentHandler.h"
#import "Constants.h"

@implementation FocusStatusIntentHandler

- (NSString *)appBundleIdentifier
{
    NSBundle *bundle = [NSBundle mainBundle];
    if ([[bundle.bundleURL pathExtension] isEqualToString:@"appex"]) {
        bundle = [NSBundle bundleWithURL:[[bundle.bundleURL URLByDeletingLastPathComponent] URLByDeletingLastPathComponent]];
    }
    
    return [bundle bundleIdentifier];
}

- (void)handleShareFocusStatus:(INShareFocusStatusIntent *)intent
                    completion:(void (^)(INShareFocusStatusIntentResponse * _Nonnull))completion
API_AVAILABLE(ios(15.0))
{
    BOOL isFocused = [intent.focusStatus.isFocused boolValue];
    NSString *suiteName = [NSString stringWithFormat:@"group.%@.RNFocus", [self appBundleIdentifier]];
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:suiteName];
    [userDefaults setBool:isFocused forKey:IsFocusedStorageKey];
    
    INShareFocusStatusIntentResponse *response = [[INShareFocusStatusIntentResponse alloc]
                                                  initWithCode:INShareFocusStatusIntentResponseCodeSuccess
                                                  userActivity:nil];
    completion(response);
}

@end
