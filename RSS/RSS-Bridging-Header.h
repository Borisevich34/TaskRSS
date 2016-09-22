//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#import <SystemConfiguration/SystemConfiguration.h>
#import <MobileCoreServices/MobileCoreServices.h>

#import <RestKit/CoreData.h>
#import <RestKit/RestKit.h>
#import <CoreData/CoreData.h>
#import <MagicalRecord/MagicalRecord.h>


@interface NSManagedObjectContext ()
+ (void)MR_setRootSavingContext:(NSManagedObjectContext *)context;
+ (void)MR_setDefaultContext:(NSManagedObjectContext *)moc;
@end