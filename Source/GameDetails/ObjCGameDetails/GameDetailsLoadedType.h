//
//  GameDetailsLoadedType.h
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/03/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GameDetailsLoadedType <NSObject>
-(void) gameDetailsFound: (NSString *) withGameName
                        : (NSString *) andAppID
                        : (NSString *) price
                        : (NSString *) shortDescription
                        : (NSString *) developers
                        : (NSString *) publishers
                        : (UIImage *) headerImage;
@end

NS_ASSUME_NONNULL_END
