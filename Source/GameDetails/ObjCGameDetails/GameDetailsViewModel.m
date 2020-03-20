//
//  GameDetailsViewModel.m
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/03/19.
//

#import "GameDetailsViewModel.h"
#import "GameDetailsLoadedType.h"
#import <CommonFiles/CommonFiles-Swift.h>

@implementation GameDetailsViewModel

-(instancetype) initWith:(id<GameDetailsLoadedType>)view
                        : (Game *) selectedGame;
{
  
  self = [super init];
  
  if (self) {
    self.view = view;
    self.selectedGame = selectedGame;
  }
  
  return self;
  
}

- (void)getGameData {
  
  NSString* gameName = self.selectedGame.name;
  NSString* appID = self.selectedGame.appID;
  
  [self.view gameDetailsFound:gameName :appID];
  
}

@end
