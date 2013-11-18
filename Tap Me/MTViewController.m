#import "MTViewController.h"

//为什么interface在这里定义呢？
@interface MTViewController ()

@end

@implementation MTViewController

- (IBAction)buttonPressed 
{
    NSLog(@"Pressed!");
    count ++;
    //[NSString stringWithFormat:@"Score\n%i", count];
    scoreLabel.text = [NSString stringWithFormat:@"Score:\n%i",count];
    
    [buttonBeep play];
}

-(void) setupGame
{
        [backgroundMusic setVolume:0.3];
        [backgroundMusic play];

        //1
        seconds     = 30;
        count       = 0;

        //2
        timerLable.text = [NSString stringWithFormat:@"Time:%i",seconds];
        scoreLabel.text = [NSString stringWithFormat:@"Score:\n%i",count];

        //3
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                             target:self //发送到的对象
                                           selector:@selector(subtractTime) //要执行target对象的selector的方法
                                           userInfo:nil
                                            repeats:YES];
}

- (void) subtractTime 
{
        [secondBeep play];
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

- (void) alertView:(UIAlertView *) alertView clickedButtonAtIndex:(NSInteger) buttonIndex 
{
        [self setupGame];
}


- (AVAudioPlayer *) setupAudioPlayerWithFile:(NSString *)file type:(NSString *)type
{
    // 1
    NSString    *path   = [[NSBundle mainBundle] pathForResource:file ofType:type];
    NSURL       *url    = [NSURL fileURLWithPath:path];
    
    // 2
    NSError *error;
    
    // 3
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    // 4
    if (!audioPlayer) {
        NSLog(@"%@",[error description]);
    }
    
    // 5
    return audioPlayer;
}

- (void)viewDidLoad
{
        self.view.backgroundColor       = [UIColor purpleColor];
        self.view.backgroundColor       = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tile.png"]];
        scoreLabel.backgroundColor      = [UIColor colorWithPatternImage:[UIImage imageNamed:@"field_score.png"]];
        timerLable.backgroundColor      = [UIColor colorWithPatternImage:[UIImage imageNamed:@"field_time.png"]];

        buttonBeep      = [self setupAudioPlayerWithFile:@"ButtonTap" type:@"wav"];
        secondBeep      = [self setupAudioPlayerWithFile:@"SecondBeep" type:@"wav"];
        backgroundMusic = [self setupAudioPlayerWithFile:@"HallOfTheMountainKing" type:@"mp3"];

        [super viewDidLoad];
        [self setupGame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
