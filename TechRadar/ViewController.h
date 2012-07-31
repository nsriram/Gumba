#import <UIKit/UIKit.h>
#import "RadarItemDetailViewController.h"

@class ACMagnifyingView;

@interface ViewController : UIViewController<RadarItemDetailViewControllerDelegate, UIPopoverControllerDelegate>
@property (nonatomic,strong) NSMutableArray *quadrantViews;
@end