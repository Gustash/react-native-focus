@protocol FocusStatusDelegate

// Called when the `isFocused` key in UserDefaults changes.
- (void)focusDidChange:(BOOL)isFocused;

@end
