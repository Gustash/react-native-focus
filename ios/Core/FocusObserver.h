#import "FocusStatusDelegate.h"

@interface FocusObserver : NSObject

- (instancetype)initWithDelegate:(id<FocusStatusDelegate>)delegate;

@end
