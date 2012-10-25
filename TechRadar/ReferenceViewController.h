#import <UIKit/UIKit.h>

@interface ReferenceViewController : UIViewController {
}
@property NSString *currentURL;
@property (nonatomic,strong) IBOutletCollection(UIButton) NSArray *references;
@end
