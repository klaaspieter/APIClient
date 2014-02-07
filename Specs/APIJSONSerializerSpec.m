#import "SpecHelper.h"

#import "APIJSONSerializer.h"

SpecBegin(APIJSONSerializer)

describe(@"APIJSONSerializer", ^{
    it(@"deserializes JSON", ^{
        APIJSONSerializer *serializer = [[APIJSONSerializer alloc] init];
        expect([serializer deserializeJSON:[@"{}" dataUsingEncoding:NSUTF8StringEncoding] error:nil]).to.equal(@{});
    });

    it(@"returns the error by reference if the JSON cannot be parsed", ^{
        APIJSONSerializer *serializer = [[APIJSONSerializer alloc] init];
        NSError *error;
        [serializer deserializeJSON:[@"<html></html>" dataUsingEncoding:NSUTF8StringEncoding] error:&error];
        expect(error.domain).to.equal(APIJSONSerializerErrorDomain);
        expect(error.userInfo[NSUnderlyingErrorKey]).toNot.beNil();
    });

    it(@"does not attempt to dereference a  nil error", ^{
        APIJSONSerializer *serializer = [[APIJSONSerializer alloc] init];
        id object = [serializer deserializeJSON:[@"<html></html>" dataUsingEncoding:NSUTF8StringEncoding] error:nil];
        expect(object).to.beNil();
    });
});

SpecEnd
