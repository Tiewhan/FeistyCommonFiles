//
//  GameDetailsViewModel.m
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/03/19.
//

#import "GameDetailsViewModel.h"
#import "GameDetailsLoadedType.h"
#import <CommonFiles/CommonFiles-Swift.h>
@import FirebaseAnalytics;

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
  [FIRAnalytics logEventWithName:kFIREventLogin
                      parameters:@{ kFIRParameterItemID: [NSString stringWithFormat:@"id-%@", self.selectedGame.appID],
                                    kFIRParameterItemName: self.selectedGame.name,
                                    kFIRParameterContentType: @"game"
                      }];
  
  GameDataTransferObject* gameDTO = [GameDataTransferObject alloc];
  gameDTO.appID = self.selectedGame.appID;
  gameDTO.name = self.selectedGame.name;
  gameDTO.price = [NSString stringWithFormat:@"R%.2f", self.selectedGame.price];
  gameDTO.shortDescription = self.selectedGame.shortDescription;
  gameDTO.developers = self.selectedGame.developers;
  gameDTO.publishers = self.selectedGame.publishers;
  gameDTO.headerImage = self.selectedGame.headerImage;
  
  [self.view gameDetailsFound:(gameDTO)];
  
}

@end
