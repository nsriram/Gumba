#import "ItemView.h"

@implementation ItemView

@synthesize entry = _entry, blipName =_blipName;

-(void) drawBackgroundGradient : (CGContextRef) context{
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0};
    CGFloat components[12] = {  70.0/255.0, 130.0/255.0, 170.0/255.0, 0.8, 
        70.0/255.0, 130.0/255.0, 170.0/255.0, 0.8 };
    CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef myGradient = CGGradientCreateWithColorComponents (myColorspace, 
                                                                    components,locations, 
                                                                    num_locations);
    CGPoint myStartPoint, myEndPoint;    
    myStartPoint.x = 0.0;    
    myStartPoint.y = 0.0;
    myEndPoint.x = self.frame.size.width;
    myEndPoint.y = self.frame.size.height;    
    CGContextDrawLinearGradient (context, myGradient, myStartPoint, myEndPoint, 0);
}

-(void) minimize{
    CGRect currentFrame = self.frame;
    [self setFrame:CGRectMake(currentFrame.origin.x/2.0, currentFrame.origin.y/2.0, currentFrame.size.width/2.0, currentFrame.size.height/2.0)];
}

-(void) maximize {
    CGRect currentFrame = self.frame;
    [self setFrame:CGRectMake(currentFrame.origin.x*2.0, currentFrame.origin.y*2.0, currentFrame.size.width*2.0, currentFrame.size.height*2.0)];    
}

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:_blipName
                                                       delegate:self
                                              cancelButtonTitle:nil
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"ok" ,nil];
    sheet.actionSheetStyle = UIActionSheetStyleDefault;
    [sheet setBackgroundColor:[UIColor blackColor]];
    [sheet showInView:self];
}

- (id)initWithFrame:(CGRect)frame AndEntry:(NSInteger)entry AndBlip:(NSString*)blipName {
    self = [super initWithFrame:frame];
    if (self) {
        self.entry = entry;
        self.blipName = blipName;
    }
    return self;
}
@end
