//
// Copyright 2009-2010 Facebook
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "TTMultiSelectTableDataSource.h"

#import "TTTwitterSearchFeedModel.h"
#import "TTTwitterTweet.h"

#import "TTMultiSelectTableItem.h"
#import "TTMultiSelectTableItemCell.h"

#import "TTMultiSelectTableStyleSheet.h"

// Three20 Additions
#import <Three20Core/NSDateAdditions.h>


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTMultiSelectTableDataSource

@synthesize selectedIndices = _selectedIndices;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithSearchQuery:(NSString*)searchQuery {
	if (self = [super init]) {
		_searchFeedModel = [[TTTwitterSearchFeedModel alloc] initWithSearchQuery:searchQuery];
		_selectedIndices = [[NSMutableSet alloc] init];
	}

	return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_searchFeedModel);
	TT_RELEASE_SAFELY(_selectedIndices);
	[super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<TTModel>)model {
	return _searchFeedModel;
}


- (NSInteger)findOffsetBetweenNewItems:(NSMutableArray *)newItems andOldItems:(NSArray *)oldItems {
	
	for (int i = 0; i < [newItems count]; i++) {
		TTMultiSelectTableItem* newItem = (TTMultiSelectTableItem *)[newItems objectAtIndex:i];
		for (int j = 0; j < [oldItems count]; j++) {
			TTMultiSelectTableItem* oldItem = (TTMultiSelectTableItem *)[oldItems objectAtIndex:j];

			NSLog(@"i=%d j=%d newItem.text=%@ oldItem.text=%@", i, j, newItem.text, oldItem.text);
			
			// TODO These should utilize a better unique id than their text
			if ([newItem.text isEqual:oldItem.text]) {
				// Valid range: 0 - j < n < i
				return i - j;
			}			
		}
	}
	
	NSLog(@"no match found.");

	return INT_MAX; // Could use [items counts] as a boundary here too
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableViewDidLoadModel:(UITableView*)tableView {
	NSMutableArray* items = [[NSMutableArray alloc] init];

	for (TTTwitterTweet* tweet in _searchFeedModel.tweets) {
		[items addObject:[TTMultiSelectTableItem itemWithText:tweet.text]];
	}

	NSInteger offset = [self findOffsetBetweenNewItems:items andOldItems:self.items];
	
	NSLog(@"offset %d", offset);
	
	if (offset < INT_MAX) {
		for (NSIndexPath* indexPath in _selectedIndices) {
			if ((indexPath.row + offset) < [items count]) {
				TTMultiSelectTableItem* item = [items objectAtIndex:(indexPath.row + offset)];
				item.isSelected = YES;
			}
		}
	} else {
		// No more selected indices, so wipe the set and re-init it
		_selectedIndices = [[NSMutableSet alloc] init];
	}
	
	TT_RELEASE_SAFELY(items);
	
	self.items = items;
	TT_RELEASE_SAFELY(items);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForLoading:(BOOL)reloading {
  if (reloading) {
    return NSLocalizedString(@"Updating remote feed...", @"Remote feed updating text");
  } else {
    return NSLocalizedString(@"Loading remote feed...", @"Remote feed loading text");
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForEmpty {
  return NSLocalizedString(@"No feed items found.", @"Remote feed no results");
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)subtitleForError:(NSError*)error {
  return NSLocalizedString(@"Sorry, there was an error loading the feed.", @"");
}


- (BOOL)isSelected:(NSIndexPath	*)indexPath {
	return [_selectedIndices containsObject:indexPath];
}

- (BOOL)toggleIndexPath:(NSIndexPath *)indexPath {
	
	BOOL isSelected = [self isSelected:indexPath];
	
	if (isSelected) {
		[_selectedIndices removeObject:indexPath];
	} else {
		[_selectedIndices addObject:indexPath];
	}
	
	return !isSelected;
}


- (Class)tableView:(UITableView*)tableView cellClassForObject:(id) object {   
	
    if ([object isKindOfClass:[TTMultiSelectTableItem class]]) {  
        return [TTMultiSelectTableItemCell class];  
    }
	
    return [super tableView:tableView cellClassForObject:object];  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *cellIdentifier = @"TTMultiSelectItemCell";
	
	TTMultiSelectTableItemCell *cell =
			(TTMultiSelectTableItemCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (!cell) {
		cell = [[[TTMultiSelectTableItemCell alloc] initWithStyle:UITableViewCellStyleDefault 
											 reuseIdentifier:cellIdentifier] autorelease];
	}
	[cellIdentifier release];
		
	TTMultiSelectTableItem* itemAtIndexPath = [self.items objectAtIndex:indexPath.row];
	
	cell.textLabel.text = itemAtIndexPath.text;
	
	if (itemAtIndexPath.isSelected) {
		cell.contentView.backgroundColor = TTSTYLEVAR(cellSelectedBackground);
		cell.checkmark.urlPath = @"bundle://IsSelected.png";
	} else {
		cell.contentView.backgroundColor = TTSTYLEVAR(cellUnselectedBackground);
		cell.checkmark.urlPath = @"bundle://NotSelected.png";
	}

//	cell = [cell setSelected:itemAtIndexPath.isSelected]; // Why doesn't calling this work?

	return cell;
}



@end

