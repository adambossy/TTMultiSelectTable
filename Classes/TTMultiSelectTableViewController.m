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

#import "TTMultiSelectTableViewController.h"

#import "TTMultiSelectTableDataSource.h"
#import "TTMultiSelectTableViewDelegate.h"

#import "TTMultiSelectTableStyleSheet.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTMultiSelectTableViewController


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) init {
	if (self = [super init]) {
		self.title = @"Twitter feed";
		self.variableHeightRows = YES;

		// Correct spot for this?
		[TTStyleSheet setGlobalStyleSheet:[[[TTMultiSelectTableStyleSheet alloc] init] autorelease]];
	}

	return self;
}

- (void)dealloc {
	[TTStyleSheet setGlobalStyleSheet:nil];
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createModel {
  self.dataSource = [[[TTMultiSelectTableDataSource alloc]
                      initWithSearchQuery:@"jeopardy"] autorelease];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<UITableViewDelegate>)createDelegate {
	return [[[TTMultiSelectTableViewDelegate alloc] initWithController:self] autorelease];
}


@end

