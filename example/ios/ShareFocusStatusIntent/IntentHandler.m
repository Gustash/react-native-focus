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
    if ([intent isKindOfClass:[INShareFocusStatusIntent class]]) {
        return [[FocusStatusIntentHandler alloc] init];
    }
    
    return self;
}

@end
