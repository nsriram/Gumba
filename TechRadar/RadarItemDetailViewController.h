#import <UIKit/UIKit.h>

@protocol RadarItemDetailViewControllerDelegate; 

@interface RadarItemDetailViewController : UIViewController {
    IBOutlet UILabel *detail;
    id<RadarItemDetailViewControllerDelegate> delegate;
}
@property (nonatomic,strong) UILabel *detail;
@property (nonatomic,strong) NSString* detailText;
@property (strong) id<RadarItemDetailViewControllerDelegate> delegate;

-(IBAction) ok:(UIButton *)ok;

@end

@protocol RadarItemDetailViewControllerDelegate
-(void) radarItemViewController:(RadarItemDetailViewController*)sender;
@end