//
//  panelsComicCell.m
//  panels
//
//  Created by James A Hill on 10/01/2014.
//  Copyright (c) 2014 Jcodr. All rights reserved.
//

#import "QuartzCore/CALayer.h"
#import "panelsComicCell.h"

@interface panelsComicCell()
@property (strong, nonatomic) IBOutlet UIImageView *stampView;
@property (strong, nonatomic) IBOutlet UILabel *volumeLabel;
@property (strong, nonatomic) IBOutlet UITextView *nameText;
@property (strong, nonatomic) IBOutlet UIProgressView *progressBar;
@property (strong, nonatomic) IBOutlet UILabel *pageProgress;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) IBOutlet UIButton *moveButton;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;
@property (strong, nonatomic) IBOutlet UIImageView *comicCover;
@end
@implementation panelsComicCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setComicTitle:(NSString *)title {
    self.nameText.text = title;
//    NSLog(@"%@", self.nameText.text);
}

- (void)setComicVolume:(NSNumber *)volume {
    self.volumeLabel.text = [NSString stringWithFormat:@"%@", [volume stringValue]];
}

- (void)setComicImage:(UIImage *)image {
    CGSize imageSize = CGSizeMake(230, 370);
    image = [self compressImage:image scaledToSize:imageSize];
    if(image) {

        self.comicCover.image = image;
        self.comicCover.layer.shadowColor = [UIColor grayColor].CGColor;
        self.comicCover.layer.shadowOffset = CGSizeMake(0, 10);
        self.comicCover.layer.shadowOpacity = 0.5;
        self.comicCover.layer.shadowRadius = 5;
        self.comicCover.clipsToBounds = NO;
    }

}

- (void)setComicPageProgress:(NSNumber *)totalPages atPage:(NSNumber *)page isCompleted:(BOOL)completed{
    // Update progress bar and label
    float currentProgress;
    if(page==0 && !completed) {
        currentProgress = 0.0;
    } else if(completed) {
        currentProgress = 1.0;
    } else {
        double something = (([page intValue]*100)/[totalPages intValue]);
        currentProgress = something/100;
    }
    NSMutableString *progressLabelString;
    if(completed) {
        progressLabelString = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%d/%d",[totalPages intValue], [totalPages intValue]]];
    } else {
        progressLabelString = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%@/%d",page, [totalPages intValue]]];
    }

    UILabel *pageProgressLabel = (UILabel *)[self viewWithTag:106];
    [pageProgressLabel setText:progressLabelString];
    UIProgressView *progressBar = (UIProgressView *)[self viewWithTag:105];
    [progressBar setProgress:currentProgress];
    
    [self.pageProgress setText:progressLabelString];
    [self.progressBar setProgress:currentProgress];
}

/*
 Credit to Brad Larson (Stack Overflow): http://stackoverflow.com/questions/612131/whats-the-easiest-way-to-resize-optimize-an-image-size-with-the-iphone-sdk
 */
-(UIImage *)compressImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end
