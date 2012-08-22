#import <UIKit/UIKit.h>

@interface ItemDetailViewController : UIViewController{
    IBOutlet UITextView *description;
    IBOutlet UILabel *detail;
    IBOutlet UIImageView *itemType;
}
@property (nonatomic,strong) IBOutlet UITextView *description;
@property (nonatomic,strong) UILabel *detail;
@property (nonatomic,strong) UIImageView *itemType;
@property (nonatomic,strong) NSString* detailText;
@property (nonatomic,strong) NSString* descriptionText;
@property (nonatomic,strong) NSString* imageText;
@end
