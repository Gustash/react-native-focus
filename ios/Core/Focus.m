#import "Focus.h"
#import "FocusObserver.h"
#import "Constants.h"

#import <Intents/Intents.h>

@implementation Focus
{
    bool hasListeners;
    FocusObserver *observer;
}

- (void)startObserving
{
    hasListeners = YES;
}

- (void)stopObserving
{
    hasListeners = NO;
}

- (NSArray<NSString *> *)supportedEvents
{
    return @[FocusStatusEvent];
}

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

- (instancetype)init
{
    self = [super init];
    self->observer = [[FocusObserver alloc] initWithDelegate:self];
    return self;
}

- (void)focusDidChange:(BOOL)isFocused
{
    [self sendFocusStatusChangedEventWithStatus:isFocused];
}

-(void)sendFocusStatusChangedEventWithStatus:(BOOL)isFocused
{
    if (hasListeners) {
        [self sendEventWithName:FocusStatusEvent body:@(isFocused)];
    }
}

RCT_EXPORT_MODULE()

// Example method
// See // https://reactnative.dev/docs/native-modules-ios
RCT_REMAP_METHOD(requestAuthorization,
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
{
    if (@available(iOS 15.0, *)) {
        INFocusStatusCenter *center = [INFocusStatusCenter defaultCenter];
        [center requestAuthorizationWithCompletionHandler:^(INFocusStatusAuthorizationStatus status) {
            resolve(@(status));
        }];
    } else {
        reject(NotAvailableErrorCode, @"This feature is only available on iOS 15+", nil);
    };
}

RCT_EXPORT_BLOCKING_SYNCHRONOUS_METHOD(getCurrentFocusStatus)
{
    if (@available(iOS 15.0, *)) {
        INFocusStatusCenter *center = [INFocusStatusCenter defaultCenter];
        return @([center.focusStatus.isFocused boolValue]);
    }

    return @(NO);
}

@end
