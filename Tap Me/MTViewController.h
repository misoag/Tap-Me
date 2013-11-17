//
//  MTViewController.h
//  Tap Me
//
//  Created by john on 13-11-17.
//
//

#import <UIKit/UIKit.h>

@interface MTViewController : UIViewController<UIAlertViewDelegate>{

    IBOutlet UILabel *scoreLabel;
    IBOutlet UILabel *timerLable;
    
    NSInteger count;
    NSInteger seconds;
    NSTimer *timer;
}

-(IBAction)buttonPressed;

@end
