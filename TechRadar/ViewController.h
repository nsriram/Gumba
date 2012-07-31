#import <UIKit/UIKit.h>
#import "RadarItemDetailViewController.h"

@class ACMagnifyingView;

@interface ViewController : UIViewController<RadarItemDetailViewControllerDelegate>
@property (nonatomic,strong) NSMutableArray *quadrantViews;
@property (nonatomic, retain) IBOutlet ACMagnifyingView *magnifyingView;
@end