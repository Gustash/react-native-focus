#import "FocusObserver.h"
#import "Constants.h"

@implementation FocusObserver
{
    id<FocusStatusDelegate> delegate;
    NSUserDefaults *userDefaults;
}

- (instancetype)initWithDelegate:(id<FocusStatusDelegate>)delegate
{
    self = [super init];
    self->delegate = delegate;
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    NSString *suiteName = [NSString stringWithFormat:@"group.%@.RNFocus", bundleIdentifier];
    self->userDefaults = [[NSUserDefaults alloc] initWithSuiteName:suiteName];
    [self addFocusStatusObserver];
    return self;
}

- (void)dealloc
{
    [self removeFocusStatusObserver];
}

- (void)addFocusStatusObserver
{
    [userDefaults addObserver:self
                   forKeyPath:IsFocusedStorageKey
                      options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
                      context:nil];
}

-(void)removeFocusStatusObserver
{
    [userDefaults removeObserver:self forKeyPath:IsFocusedStorageKey context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{
    if (![keyPath isEqualToString:IsFocusedStorageKey]) {
        return;
    }
    
    
    BOOL newValue = [change[NSKeyValueChangeNewKey] boolValue];
    BOOL oldValue = [change[NSKeyValueChangeOldKey] boolValue];
    
    if (newValue == oldValue) {
        return;
    }
    
    [delegate focusDidChange:newValue];
}

@end
