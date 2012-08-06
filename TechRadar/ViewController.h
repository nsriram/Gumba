#import <UIKit/UIKit.h>
#import "RadarItemDetailViewController.h"

@interface ViewController : UIViewController<RadarItemDetailViewControllerDelegate, 
UIPopoverControllerDelegate, UISearchBarDelegate> 
@property (nonatomic,strong) NSMutableArray *quadrantViews;
@property (nonatomic,strong) NSString *searchTerm;
-(IBAction) adopt:(UIBarButtonItem *)barButtonItem;
-(IBAction) trial:(UIBarButtonItem *)barButtonItem;
-(IBAction) assess:(UIBarButtonItem *)barButtonItem;
-(IBAction) hold:(UIBarButtonItem *)barButtonItem;
-(IBAction) all:(UIBarButtonItem *)barButtonItem;
@end