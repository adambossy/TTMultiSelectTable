//
//  TTMultiSelectTableViewDelegate.m
//  TTMultiSelectTable
//
//  Created by Adam Bossy on 2/16/11.
//

#import "TTMultiSelectTableViewDelegate.h"

#import "TTMultiSelectTableItem.h"
#import "TTMultiSelectTableItemCell.h"
#import "TTMultiSelectTableDataSource.h"


@implementation TTMultiSelectTableViewDelegate


- (id)initWithController:(TTTableViewController*)controller {
	if (self = [super initWithController:controller]) {}
	
	return self;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	TTMultiSelectTableDataSource* dataSource = (TTMultiSelectTableDataSource*)[[super controller] dataSource];
	
	[dataSource toggleIndexPath:indexPath];
	
	TTMultiSelectTableItem *item = (TTMultiSelectTableItem *)[dataSource.items objectAtIndex:indexPath.row];
	
	[item tableView:tableView didSelectRowAtIndexPath:indexPath];
}


@end
