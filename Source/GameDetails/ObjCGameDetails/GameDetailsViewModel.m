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
  
  NSString* gameName = self.selectedGame.name;
  NSString* appID = self.selectedGame.appID;
  NSString* price = [NSString stringWithFormat:@"R%.2f", self.selectedGame.price];
  NSString* shortDescription = self.selectedGame.shortDescription;
  NSString* developers = @"";   
  NSString* publishers = @"";
  UIImage* headerImage = self.selectedGame.headerImage;
  
  for (id developer in self.selectedGame.developers) {
    developers = [developers stringByAppendingString:developer];
  }
  
  for (id publisher in self.selectedGame.publishers) {
    publishers = [publishers stringByAppendingString:publisher];
  }
  
  [self.view gameDetailsFound:gameName
                             :appID
                             :price
                             :shortDescription
                             :developers
                             :publishers
                             :headerImage];
  
}

@end
