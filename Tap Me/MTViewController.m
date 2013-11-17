//
//  MTViewController.m
//  Tap Me
//
//  Created by john on 13-11-17.
//
//

#import "MTViewController.h"

@interface MTViewController ()

@end

@implementation MTViewController

- (IBAction)buttonPressed {
    NSLog(@"Pressed!");
    count ++;
    //[NSString stringWithFormat:@"Score\n%i", count];
    scoreLabel.text = [NSString stringWithFormat:@"Score:\n%i",count];
}

-(void) setupGame
{
    //1
    seconds = 30;
    count = 0;
    
    //2
    timerLable.text = [NSString stringWithFormat:@"Time:%i",seconds];
    scoreLabel.text = [NSString stringWithFormat:@"Score:\n%i",count];
    
    //3
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(subtractTime)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)subtractTime {
    // 1
    seconds--;
    timerLable.text = [NSString stringWithFormat:@"Time: %i",seconds];
    
    // 2
    if (seconds == 0) {
        [timer invalidate];
        // new code is here!
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time is up!"
                                                        message:[NSString stringWithFormat:@"You scored %i points", count]
                                                       delegate:self
                                              cancelButtonTitle:@"Play Again"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self setupGame];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setupGame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
