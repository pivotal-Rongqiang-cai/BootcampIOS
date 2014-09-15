//
//  UICollectionViewController+BestBuyPhotoViewController.h
//  BestBuyIOS
//
//  Created by DX169-XL on 2014-09-10.
//
//

#import <UIKit/UIKit.h>
@import Photos;

@interface BestBuyPhotoViewController : UICollectionViewController 
@property (strong, nonatomic) IBOutlet UICollectionView *myCollection;

@property (strong) PHFetchResult *assetsFetchResults;
@property (strong) PHAssetCollection *assetCollection;
@end
