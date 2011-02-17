//
//  TTMultiSelectItemCell.m
//  TTMultiSelectTable
//
//  Created by Adam Bossy on 2/16/11.
//

#import "TTMultiSelectTableItemCell.h"

#import "TTMultiSelectTableItem.h"
#import "TTMultiSelectTableStyleSheet.h"

#import "Three20UI/UIViewAdditions.h"


static const CGFloat kTableCellPadding = 8;
static const CGFloat kImageSize = 30;


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTMultiSelectTableItemCell

@synthesize checkmark = _checkmark;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
	if (self = [super initWithStyle:style reuseIdentifier:identifier]) {
		_checkmark = [[[TTImageView alloc] init] autorelease];
		_checkmark.urlPath = @"bundle://NotSelected.png";
		[self.contentView addSubview:_checkmark];

		self.textLabel.font = TTSTYLEVAR(tableSmallFont);
		self.textLabel.backgroundColor = [UIColor clearColor];
		
		self.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	return self;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_checkmark);
	[super dealloc];
}

/*
- (TTMultiSelectItemCell *)setSelected:(BOOL)isSelected {
	self.contentView.backgroundColor = isSelected ?
			TTSTYLEVAR(cellSelectedBackground) :
			TTSTYLEVAR(cellUnselectedBackground);

	_checkmark.urlPath = isSelected ?
			@"bundle://IsSelected.png" :
			@"bundle://NotSelected.png";
	
	return self;
}
*/


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
	if (_item != object) {
		[super setObject:object];
		
		TTMultiSelectTableItem* item = object;
		self.textLabel.text = item.text;
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
	[super layoutSubviews];
	
	// Set checkmark image
	_checkmark.frame = CGRectMake(kTableCellPadding, floor(self.height/2 - kImageSize/2), kImageSize, kImageSize);
	
	// contentView.<dimension> requires Three20's UIViewAdditions
	CGFloat innerWidth = self.contentView.width - (kTableCellPadding*2 + kImageSize);
	CGFloat innerHeight = self.contentView.height - kTableCellPadding*2;

	self.textLabel.frame = CGRectMake(kImageSize + kTableCellPadding*2, kTableCellPadding, innerWidth, innerHeight);
}


@end
