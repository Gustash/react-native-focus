//
//  IntentHandler.m
//  ShareFocusStatusIntent
//
//  Created by Gustavo Parreira on 23/12/2021.
//

#import "IntentHandler.h"
#import <react-native-focus/FocusStatusIntentHandler.h>

@implementation IntentHandler

- (id)handlerForIntent:(INIntent *)intent {
    // This is the default implementation.  If you want different objects to handle different intents,
    // you can override this and return the handler you want for that particular intent.
    
    return self;
}

@end

@interface IntentHandler (FocusStatus) <INShareFocusStatusIntentHandling>

@end

@implementation IntentHandler (FocusStatus)

- (void)handleShareFocusStatus:(INShareFocusStatusIntent *)intent
                    completion:(void (^)(INShareFocusStatusIntentResponse * _Nonnull))completion
{
  [FocusStatusIntentHandler handleShareFocusStatus:intent completion:completion];
}

@end
