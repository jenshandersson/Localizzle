//
//  LocalLabel.m
//  Localizzle
//
//  Created by Jens Andersson on 12/12/13.
//  Copyright (c) 2013 Jens Andersson. All rights reserved.
//

#import "Localizzle.h"
#import <objc/runtime.h>

static char const * const LocalizationKey = "localizingKey";


/*
 * Thanks to Jamz Tang for this swissling snippet.
 * http://ioscodesnippet.com/2013/02/17/method-swizzling-in-objective-c/
 */
void SwizzleInstanceMethod(Class c, SEL orig, SEL new)
{
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    if(class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)))
        class_replaceMethod(c, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    else
        method_exchangeImplementations(origMethod, newMethod);
}


@implementation UIView (LocalizzedView)

#pragma mark - Class methods

+ (void)enableIBLocalization {
    SwizzleInstanceMethod([UIView class], @selector(awakeFromNib), @selector(awakeFromNibLocalized));
}


#pragma mark - Instance methods

- (void)awakeFromNibLocalized {
    [self awakeFromNibLocalized];
    
    NSString *localizingKeyFromIB = self.localizingKey;
    if (localizingKeyFromIB) {
        NSString *text = NSLocalizedString(localizingKeyFromIB, nil);
        
        [self localizeWithString:text];
    }

}


/*
 * Implement in Category or subclass. Base implementation does nothing
 */
- (void)localizeWithString:(NSString *)string {
    
}


#pragma mark - Faking member variables

- (void)setLocalizingKey:(NSString *)key {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIView enableIBLocalization];
    });
    objc_setAssociatedObject(self, LocalizationKey, key, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)localizingKey {
    return objc_getAssociatedObject(self, LocalizationKey);
}

@end

#pragma mark - Categories for localizing

@implementation UILabel (LocalizedView)

- (void)localizeWithString:(NSString *)string {
    self.text = string;
}

@end


@implementation UITextView (LocalizedView)

- (void)localizeWithString:(NSString *)string {
    self.text = string;
}

@end


@implementation UITextField (LocalizedView)

- (void)localizeWithString:(NSString *)string {
    self.placeholder = string;
}

@end


@implementation UIButton (LocalizedView)

- (void)localizeWithString:(NSString *)string {
    [self setTitle:string forState:UIControlStateNormal];
}

@end
