//
//  TTMultiSelectItem.h
//  TTMultiSelectTable
//
//  Created by Adam Bossy on 2/16/11.
//

#import <Three20/Three20.h>


@interface TTMultiSelectTableItem : TTTableTextItem {
	BOOL		_isSelected;
}

@property (nonatomic) BOOL isSelected;

+ itemWithText:(NSString *)text;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)_;

@end
