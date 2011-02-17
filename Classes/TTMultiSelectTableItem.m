//
//  TTMultiSelectItem.m
//  TTMultiSelectTable
//
//  Created by Adam Bossy on 2/16/11.
//

#import "TTMultiSelectTableItem.h"

#import "TTMultiSelectTableItemCell.h"
#import "TTMultiSelectTableStyleSheet.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTMultiSelectTableItem

@synthesize isSelected = _isSelected;

- (id)init {
	if (self = [super init]) {
		_isSelected = NO;
	}
	
	return self;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_text);
	[super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Class public

+ itemWithText:(NSString *)text {
	TTMultiSelectTableItem* item = [[[self alloc] init] autorelease];
	item.text = text;
	return item;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark ? (potentially CellController)

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	_isSelected = !_isSelected;
	
	TTMultiSelectTableItemCell *cell = (TTMultiSelectTableItemCell *)[tableView cellForRowAtIndexPath:indexPath];
	
	if (!cell) {
		return;
	}
	
//	cell.contentView.backgroundColor = _isSelected ?
//			TTSTYLEVAR(cellSelectedBackground) :
//			TTSTYLEVAR(cellUnselectedBackground);
	
	if (_isSelected) {
		cell.contentView.backgroundColor = TTSTYLEVAR(cellSelectedBackground);
		cell.checkmark.urlPath = @"bundle://IsSelected.png";
	} else {
		cell.contentView.backgroundColor = TTSTYLEVAR(cellUnselectedBackground);
		cell.checkmark.urlPath = @"bundle://NotSelected.png";
	}
	
//	cell = [cell setSelected:_isSelected]; // Why doesn't this work? Gahhh....
	
	NSLog(@"selected %@", _isSelected ? @"YES" : @"NO");
}	

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSCoding


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCoder:(NSCoder*)decoder {
	if (self = [super initWithCoder:decoder]) {
		self.text = [decoder decodeObjectForKey:@"text"];
	}
	return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)encodeWithCoder:(NSCoder*)encoder {
	[super encodeWithCoder:encoder];
	if (self.text) {
		[encoder encodeObject:self.text forKey:@"text"];
	}
}


@end
