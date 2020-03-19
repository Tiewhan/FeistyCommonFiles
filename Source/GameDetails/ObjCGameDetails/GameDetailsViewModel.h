//
//  GameDetailsViewModel.h
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/03/19.
//

#import <Foundation/Foundation.h>
#import "GameDetailsLoadedType.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameDetailsViewModel : NSObject

@property (weak) id <GameDetailsLoadedType> view;

-(instancetype) initWith : (id <GameDetailsLoadedType>) view
                         : (Game *) game;

-(void) getGameData;

@end

NS_ASSUME_NONNULL_END

