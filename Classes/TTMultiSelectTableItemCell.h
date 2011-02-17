//
//  TTMultiSelectItemCell.h
//  TTMultiSelectTable
//
//  Created by Adam Bossy on 2/16/11.
//

#import <Three20/Three20.h>

@interface TTMultiSelectTableItemCell : TTTableTextItemCell {
	TTImageView* _checkmark;
}

@property (nonatomic, retain) TTImageView* checkmark;

// - (TTMultiSelectItemCell *)setSelected:(BOOL)isSelected;

@end
