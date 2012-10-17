//
//  WEPopoverContentViewController.m
//  WEPopover
//
//  Created by Werner Altewischer on 06/11/10.
//  Copyright 2010 Werner IT Consultancy. All rights reserved.
//

#import "WEPopoverContentViewController.h"


@interface WEPopoverContentViewController()
@property (nonatomic, strong) NSString *blipName;
@property (nonatomic, strong) NSString *description;
@end


@implementation WEPopoverContentViewController

@synthesize blipName;
@synthesize description;

- (id)initWithStyle:(UITableViewStyle)style andBlipName:(NSString*)name andDescription:(id)desc {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
		self.contentSizeForViewInPopover = CGSizeMake(300, 1 * 44 - 1);
        self.blipName = name;
        self.description = desc;
    }
    return self;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

	self.tableView.rowHeight = 44.0;
	self.view.backgroundColor = [UIColor clearColor];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	cell.textLabel.text = self.blipName;
    cell.textLabel.font = [UIFont systemFontOfSize:11.0];
	cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.detailTextLabel.text = self.description;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:9.0];
	cell.detailTextLabel.textColor = [UIColor whiteColor];

    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

