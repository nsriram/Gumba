#import <UIKit/UIKit.h>
#import "RadarItemDetailViewController.h"

@interface ViewController : UIViewController<RadarItemDetailViewControllerDelegate, 
UIPopoverControllerDelegate, UISearchBarDelegate> 
@property (nonatomic,strong) NSMutableArray *quadrantViews;
@property (nonatomic,strong) NSString *searchTerm;
@end