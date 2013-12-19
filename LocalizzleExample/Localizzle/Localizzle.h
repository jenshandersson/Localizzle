//
//  LocalLabel.h
//  Localizzle
//
//  Created by Jens Andersson on 12/12/13.
//  Copyright (c) 2013 Jens Andersson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LocalizzedView)

/*
 * The key to lookup with NSLocalizedString()
 * You specify this key from the Xib.
 */
@property (nonatomic, retain) NSString *localizingKey;

@end
