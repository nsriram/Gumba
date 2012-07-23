#import <UIKit/UIKit.h>
#import "RadarItemDetailViewController.h"

@interface ViewController : UIViewController<RadarItemDetailViewControllerDelegate>
@property (nonatomic,strong) NSMutableArray *quadrantViews;
@end