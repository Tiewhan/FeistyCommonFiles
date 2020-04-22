//
//  GameDetailsLoadedType.h
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/03/19.
//

#import <Foundation/Foundation.h>
@class GameDataTransferObject;

NS_ASSUME_NONNULL_BEGIN

@protocol GameDetailsLoadedType <NSObject>
-(void) gameDetailsFound: (GameDataTransferObject *) gameDTO;
@end

NS_ASSUME_NONNULL_END
