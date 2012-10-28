//  ViewController.m
//
//  Created by Michael MacCallum on 10/28/12.
//  NO COPYRIGHT AND ABSOLUTELY NO WARRANTY EXPRESSED OR IMPLIED
//
#import "arrayViewController.h"
@interface arrayViewController ()
@end
@implementation arrayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    zoomedImage = nil;
    rectToReturnTo = CGRectZero;

    
    NSMutableArray *imageNames = [[NSMutableArray alloc] init];

    for (int i = 0; i <= 27; i++) {
        [imageNames addObject:[NSString stringWithFormat:@"%i.png",i]];
        /*
        I've used this loop to generate my array because I'm lazy and all my image names happen to be sequential.
        For a more real life example with irregularly named images replace this for loop and the mutable array above with:
            NSArray *imageNames = [[NSArray alloc] initWithObjects:@"myImageName1.png", @"myImageName2.png", @"myImageName3.png", nil];
        */
    }

    NSUInteger buttonWidth = 100;
    NSUInteger buttonHeight = 100;
    NSUInteger space = 5;
    float scrollContentY = (ceilf((float)imageNames.count / 3) * (buttonHeight + space));
    [imageNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        int row = idx / 3;
        int column = idx % 3;
        NSLog(@"Row: %i Column: %i",row,column);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((buttonWidth + space) * column + space, (buttonHeight + space) * row + space , buttonWidth, buttonHeight);
        [button setImage:[UIImage imageNamed:[imageNames objectAtIndex:idx]] forState:UIControlStateNormal];
        [button setTag:(NSInteger)idx];
        [button addTarget:self action:@selector(zoomIn:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
        [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, scrollContentY)];
    }];

}


- (void)zoomIn:(UIButton *)sender
{
    
    if (!zoomedImage) {
        [self.scrollView setScrollEnabled:NO];

        rectToReturnTo = sender.frame;

        zoomedImage = [[UIImageView alloc] initWithImage:sender.imageView.image];
        [zoomedImage setFrame:sender.frame];
        [zoomedImage setUserInteractionEnabled:YES];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomOut:)];
        [tap setNumberOfTapsRequired:1];
        [tap setNumberOfTouchesRequired:1];

        [zoomedImage addGestureRecognizer:tap];
        [self.scrollView addSubview:zoomedImage];

        CGRect accountForOffset = CGRectMake(self.scrollView.bounds.origin.x, self.scrollView.contentOffset.y, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [zoomedImage setFrame:accountForOffset];
        }completion:^(BOOL done){

        }];
    }
}

- (void)zoomOut:(UIGestureRecognizer *)sender
{
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [zoomedImage setFrame:rectToReturnTo];
    }completion:^(BOOL done){
        [zoomedImage removeGestureRecognizer:sender];
        [zoomedImage removeFromSuperview];
        zoomedImage = nil;
        [self.scrollView setScrollEnabled:YES];
        rectToReturnTo = CGRectZero;
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end