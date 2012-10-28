//  ViewController.m
//
//  Created by Michael MacCallum on 10/28/12.
//  NO COPYRIGHT AND ABSOLUTELY NO WARRANTY EXPRESSED OR IMPLIED
//
#import <UIKit/UIKit.h>
@interface arrayViewController : UIViewController
{
    UIImageView *zoomedImage;
    CGRect rectToReturnTo;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end