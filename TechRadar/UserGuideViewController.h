#import <UIKit/UIKit.h>

@interface UserGuideViewController : UIViewController<UIScrollViewDelegate> {
    UIScrollView* scrollView;
    UIPageControl* pageControl;
}
@property (nonatomic, strong) IBOutlet UIScrollView* scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl* pageControl;
@property (nonatomic, assign) BOOL pageControlBeingUsed;
- (IBAction)changePage;
@end