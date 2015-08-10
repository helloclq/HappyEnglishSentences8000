//
//  UIImage+DefaultImage.m
//
//  Created by Dominik Pich on 23.07.13.
//
#import "UIImage+DefaultImage.h"

@implementation UIImage (DefaultImage)

+ (UIImage *)defaultImage {
    return [self defaultImageForOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}

+ (UIImage  *)defaultImageForOrientation:(UIInterfaceOrientation)orient {
    // choose the correct launch image for orientation, device and scale
    NSMutableString *launchImageName = [[NSMutableString alloc] initWithString:@"Default"];
  {


		if ( CGRectGetWidth([UIScreen mainScreen].bounds) > 375.f) {
			// 6+
			launchImageName = [NSMutableString stringWithFormat:@"%@-736h", launchImageName];
		} else  if ( CGRectGetWidth([UIScreen mainScreen].bounds) > 320.f) {
			// 6
			launchImageName = [NSMutableString stringWithFormat:@"%@-667h", launchImageName];
		}else  if ( CGRectGetHeight([UIScreen mainScreen].bounds) > 480.f) {
            //5
            launchImageName = [NSMutableString stringWithFormat:@"%@-568h", launchImageName];
        } else {
            // Default.png
            // Default@2x.png
            launchImageName = [NSMutableString stringWithFormat:@"%@", launchImageName];
        }
    }
    return [UIImage imageNamed:launchImageName];
}

@end
