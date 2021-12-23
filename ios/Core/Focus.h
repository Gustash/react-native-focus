#import "FocusStatusDelegate.h"

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface Focus : RCTEventEmitter <RCTBridgeModule, FocusStatusDelegate>

@end
