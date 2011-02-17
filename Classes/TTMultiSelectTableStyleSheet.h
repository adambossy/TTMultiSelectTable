//
//  TTMultiSelectTableStyleSheet.h
//  TTMultiSelectTable
//
//  Created by Adam Bossy on 2/16/11.
//

#import <Three20/Three20.h>

#import "Three20Style/TTStyleSheet.h"


@interface TTMultiSelectTableStyleSheet : TTDefaultStyleSheet

@property (nonatomic, readonly) UIColor* cellSelectedBackground;
@property (nonatomic, readonly) UIColor* cellUnselectedBackground;

@end
