#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import "QuadrantView.h"
#import "CircleView.h"
#import "Radar.h"
#import "RadarView.h"
#import "AppConstants.h"
#import "ItemDetailViewController.h"

@implementation ViewController
@synthesize selectedButton;
@synthesize barButtonColor;
@synthesize radarView;

-(void) highlightSelectedBarButton :(UIBarButtonItem *) barButton {
    if(selectedButton != NULL){
        [selectedButton setTintColor:barButtonColor];
        
    }else {
        barButtonColor = selectedButton.tintColor;
    }
    selectedButton = barButton;
    [selectedButton setTintColor:[UIColor darkGrayColor]];
}

-(IBAction) adopt:(UIBarButtonItem *)adoptButtobarButtonItem{
    [self highlightSelectedBarButton:adoptButtobarButtonItem];
    [self.radarView hideCircle:0.0 AndOuter:150.0];
}

-(IBAction) trial:(UIBarButtonItem *)barButtonItem{
    [self highlightSelectedBarButton:barButtonItem];
    [self.radarView hideCircle:150.0 AndOuter:275.0];
}
-(IBAction) assess:(UIBarButtonItem *)barButtonItem{
    [self highlightSelectedBarButton:barButtonItem];
    [self.radarView hideCircle:275.0 AndOuter:350.0];
}

-(IBAction) hold:(UIBarButtonItem *)barButtonItem{
    [self highlightSelectedBarButton:barButtonItem];
    [self.radarView hideCircle:350.0 AndOuter:400.0];
}

-(IBAction) all:(UIBarButtonItem *)barButtonItem{
    [self highlightSelectedBarButton:barButtonItem];
    [self.radarView hideCircle:0.0 AndOuter:400.0];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    if([searchBar.text length] > 0) {
        [self.radarView searchRadar:searchBar.text];
    }
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self.radarView searchRadar:searchBar.text];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.radarView searchRadar:searchBar.text];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self.radarView searchRadar:searchBar.text];
    if([searchBar.text length] == 0) {
        [searchBar performSelector: @selector(resignFirstResponder)
                        withObject: nil
                        afterDelay: 0.1];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(ItemView*)itemView
{
	if ([segue.identifier isEqualToString:@"radar-to-details"]) {
    	ItemDetailViewController *itemDetailViewController = (ItemDetailViewController*)segue.destinationViewController;
        itemDetailViewController.detailText = [NSString stringWithFormat:@"%@", itemView.blipName];
        itemDetailViewController.descriptionText = itemView.description;
        itemDetailViewController.imageText = itemView.type;
	}
}

-(void)radarView:(RadarView*)radarView didSelectItem:(ItemView *)itemView {
    [self performSegueWithIdentifier:@"radar-to-details" sender:itemView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.radarView.delegate = self;
    [self.radarView updateWithRadar: [Radar radarFromFile:@"may2013"]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}
@end