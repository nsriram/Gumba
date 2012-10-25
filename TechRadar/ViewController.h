#import <UIKit/UIKit.h>
#import "RadarViewDelegate.h"
@class RadarView;

@interface ViewController : UIViewController<RadarViewDelegate, UISearchBarDelegate>
@property (nonatomic,strong) UIBarButtonItem *selectedButton;
@property (nonatomic,strong) UIColor *barButtonColor;
@property (nonatomic,strong) IBOutlet RadarView *radarView;
-(IBAction) adopt:(UIBarButtonItem *)barButtonItem;
-(IBAction) trial:(UIBarButtonItem *)barButtonItem;
-(IBAction) assess:(UIBarButtonItem *)barButtonItem;
-(IBAction) hold:(UIBarButtonItem *)barButtonItem;
-(IBAction) all:(UIBarButtonItem *)barButtonItem;
@end