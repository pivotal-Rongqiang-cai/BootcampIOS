//
//  UICollectionViewCell+MyCollectionCell.m
//  BestBuyIOS
//
//  Created by DX169-XL on 2014-09-11.
//
//
#import "MyCollectionCell.h"

@interface MyCollectionCell ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation MyCollectionCell

- (void)setThumbnailImage:(UIImage *)thumbnailImage {
    _thumbnailImage = thumbnailImage;
    self.imageView.image = thumbnailImage;
}
@end
