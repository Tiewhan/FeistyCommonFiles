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

-(instancetype) initWith:(id<GameDetailsLoadedType>)view {
  
  self = [super init];
  
  if (self) {
    self.view = view;
  }
  
  return self;
  
}

- (void)getGameData {
  
}

@end
