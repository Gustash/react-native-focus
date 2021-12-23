#import "FocusStatusIntentHandler.h"
#import "Constants.h"

@implementation FocusStatusIntentHandler

+ (void)handleShareFocusStatus:(INShareFocusStatusIntent *)intent
                    completion:(void (^)(INShareFocusStatusIntentResponse * _Nonnull))completion
{
    BOOL isFocused = [intent.focusStatus.isFocused boolValue];
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.example.reactnativefocus"];
    [userDefaults setBool:isFocused forKey:IsFocusedStorageKey];
    
    INShareFocusStatusIntentResponse *response = [[INShareFocusStatusIntentResponse alloc]
                                                  initWithCode:INShareFocusStatusIntentResponseCodeSuccess
                                                  userActivity:nil];
    completion(response);
}

@end
