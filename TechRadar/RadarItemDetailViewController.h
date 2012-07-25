#import <UIKit/UIKit.h>

@protocol RadarItemDetailViewControllerDelegate; 

@interface RadarItemDetailViewController : UIViewController {
    IBOutlet UILabel *detail;
    IBOutlet UIImageView *itemType;
    id<RadarItemDetailViewControllerDelegate> delegate;
}
@property (nonatomic,strong) UILabel *detail;
@property (nonatomic,strong) UIImageView *itemType;
@property (nonatomic,strong) NSString* detailText;
@property (nonatomic,strong) NSString* imageText;
@property (strong) id<RadarItemDetailViewControllerDelegate> delegate;
-(IBAction) ok:(UIButton *)ok;

@end

@protocol RadarItemDetailViewControllerDelegate
-(void) radarItemViewController:(RadarItemDetailViewController*)sender;
@end