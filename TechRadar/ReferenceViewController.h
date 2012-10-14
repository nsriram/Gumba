#import <UIKit/UIKit.h>

@interface ReferenceViewController : UIViewController<UIWebViewDelegate>{
    IBOutlet UIWebView *referencesWebView;
    UIToolbar *toolbar;
    UIBarButtonItem *backButton;
}
@property (nonatomic,strong) IBOutlet UIWebView *referencesWebView;
@property (nonatomic,strong) IBOutlet UIToolbar *toolbar;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *backButton;
-(IBAction) back:(UIBarButtonItem *)barButtonItem;
@end
