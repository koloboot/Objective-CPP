/*******************************************************************************
 * Copyright (c) 2015, Jean-David Gadina - www.xs-labs.com / www.digidna.net
 * Distributed under the Boost Software License, Version 1.0.
 * 
 * Boost Software License - Version 1.0 - August 17th, 2003
 * 
 * Permission is hereby granted, free of charge, to any person or organization
 * obtaining a copy of the software and accompanying documentation covered by
 * this license (the "Software") to use, reproduce, display, distribute,
 * execute, and transmit the Software, and to prepare derivative works of the
 * Software, and to permit third-parties to whom the Software is furnished to
 * do so, all subject to the following:
 * 
 * The copyright notices in the Software and this entire statement, including
 * the above license grant, this restriction and the following disclaimer,
 * must be included in all copies of the Software, in whole or in part, and
 * all derivative works of the Software, unless such copies or derivative
 * works are solely in the form of machine-executable object code generated by
 * a source language processor.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
 * SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
 * FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 ******************************************************************************/

/*!
 * @file        Test-NSString+ObjectiveCPP.mm
 * @copyright   (c) 2015 - Jean-David Gadina - www.xs-labs.com / www.digidna.net
 * @abstract    Unit tests for NSString( ObjectiveCPP )
 */

#import <ObjectiveCPP.h>
#import <GoogleMock/GoogleMock.h>

using namespace testing;

TEST( Objective_CPP, defaultCPPStringEncoding )
{
    ASSERT_TRUE( [ NSString defaultCPPStringEncoding ] == NSUTF8StringEncoding );
    
    [ NSString setDefaultCPPStringEncoding: NSASCIIStringEncoding ];
    
    ASSERT_TRUE( [ NSString defaultCPPStringEncoding ] == NSASCIIStringEncoding );
    
    [ NSString setDefaultCPPStringEncoding: NSUTF8StringEncoding ];
    
    ASSERT_TRUE( [ NSString defaultCPPStringEncoding ] == NSUTF8StringEncoding );
}

TEST( Objective_CPP, stringWithCPPString )
{
    ASSERT_TRUE( [ [ NSString stringWithCPPString: "hello, world" ] isEqualToString: @"hello, world" ] );
}

TEST( Objective_CPP, stringWithCPPString_encoding )
{
    ASSERT_TRUE( [ [ NSString stringWithCPPString: "hello, world" encoding: NSUTF8StringEncoding  ] isEqualToString: @"hello, world" ] );
    ASSERT_TRUE( [ [ NSString stringWithCPPString: "hello, world" encoding: NSASCIIStringEncoding ] isEqualToString: @"hello, world" ] );
}

TEST( Objective_CPP, cppStringWithContentsOfFile_encoding_error )
{
    NSError * e;
    
    e = nil;
    
    ASSERT_TRUE( [ NSString cppStringWithContentsOfFile: @"/etc/hosts" encoding: NSUTF8StringEncoding error: &e ].length() > 0 );
    ASSERT_TRUE( e == nil );
    
    ASSERT_TRUE( [ NSString cppStringWithContentsOfFile: @"/foo/bar" encoding: NSUTF8StringEncoding error: &e ].length() == 0 );
    ASSERT_TRUE( e != nil );
}

TEST( Objective_CPP, cppStringWithContentsOfFile_usedEncoding_error )
{
    NSError        * e;
    NSStringEncoding enc;
    
    e   = nil;
    enc = 0;
    
    ASSERT_TRUE( [ NSString cppStringWithContentsOfFile: @"/etc/hosts" usedEncoding: &enc error: &e ].length() > 0 );
    ASSERT_TRUE( e == nil );
    ASSERT_TRUE( enc != 0 );
    
    ASSERT_TRUE( [ NSString cppStringWithContentsOfFile: @"/foo/bar" usedEncoding: &enc error: &e ].length() == 0 );
    ASSERT_TRUE( e != nil );
    ASSERT_TRUE( enc != 0 );
}

TEST( Objective_CPP, cppStringWithContentsOfURL_encoding_error )
{
    NSError * e;
    
    e = nil;
    
    ASSERT_TRUE( [ NSString cppStringWithContentsOfURL: [ NSURL URLWithString: @"file:///etc/hosts" ] encoding: NSUTF8StringEncoding error: &e ].length() > 0 );
    ASSERT_TRUE( e == nil );
    
    ASSERT_TRUE( [ NSString cppStringWithContentsOfURL: [ NSURL URLWithString: @"file:///foo/bar" ] encoding: NSUTF8StringEncoding error: &e ].length() == 0 );
    ASSERT_TRUE( e != nil );
}

TEST( Objective_CPP, cppStringWithContentsOfURL_usedEncoding_error )
{
    NSError        * e;
    NSStringEncoding enc;
    
    e   = nil;
    enc = 0;
    
    ASSERT_TRUE( [ NSString cppStringWithContentsOfURL: [ NSURL URLWithString: @"file:///etc/hosts" ] usedEncoding: &enc error: &e ].length() > 0 );
    ASSERT_TRUE( e == nil );
    ASSERT_TRUE( enc != 0 );
    
    ASSERT_TRUE( [ NSString cppStringWithContentsOfURL: [ NSURL URLWithString: @"file:///foo/bar" ] usedEncoding: &enc error: &e ].length() == 0 );
    ASSERT_TRUE( e != nil );
    ASSERT_TRUE( enc != 0 );
}

TEST( Objective_CPP, initWithCPPString )
{
    ASSERT_TRUE( [ [ [ NSString alloc ] initWithCPPString: "hello, world" ] isEqualToString: @"hello, world" ] );
}

TEST( Objective_CPP, initWithCPPString_encoding )
{
    ASSERT_TRUE( [ [ [ NSString alloc ] initWithCPPString: "hello, world" encoding: NSUTF8StringEncoding  ] isEqualToString: @"hello, world" ] );
    ASSERT_TRUE( [ [ [ NSString alloc ] initWithCPPString: "hello, world" encoding: NSASCIIStringEncoding ] isEqualToString: @"hello, world" ] );
}

TEST( Objective_CPP, cppString )
{
    ASSERT_TRUE( [ @"hello, world" cppString ] == "hello, world" );
}

TEST( Objective_CPP, cppStringUsingEncoding )
{
    ASSERT_TRUE( [ @"hello, world" cppStringUsingEncoding: NSUTF8StringEncoding  ] == "hello, world" );
    ASSERT_TRUE( [ @"hello, world" cppStringUsingEncoding: NSASCIIStringEncoding ] == "hello, world" );
}

TEST( Objective_CPP, cppStringByAppendingString )
{
    ASSERT_TRUE( [ @"hello, world" cppStringByAppendingString: @"..." ] == "hello, world..." );
}

TEST( Objective_CPP, stringByAppendingCPPString )
{
    ASSERT_TRUE( [ [ @"hello, world" stringByAppendingCPPString: "..." ] isEqualToString: @"hello, world..." ] );
}

TEST( Objective_CPP, cppStringByPaddingToLength_withString_startingAtIndex )
{}

TEST( Objective_CPP, stringByPaddingToLength_withCPPString_startingAtIndex )
{}

TEST( Objective_CPP, cppStringByTrimmingCharactersInSet )
{}

TEST( Objective_CPP, cppSubstringFromIndex )
{
    ASSERT_TRUE( [ @"hello, world" cppSubstringFromIndex: 7 ] == "world" );
}

TEST( Objective_CPP, cppSubstringWithRange )
{
    ASSERT_TRUE( [ @"hello, world" cppSubstringWithRange: NSMakeRange( 7, 2 ) ] == "wo" );
}

TEST( Objective_CPP, cppSubstringToIndex )
{
    ASSERT_TRUE( [ @"hello, world" cppSubstringToIndex: 5 ] == "hello" );
}

TEST( Objective_CPP, rangeOfCPPString )
{
    NSRange r;
    
    r = [ @"hello, world" rangeOfCPPString: "wo" ];
    
    ASSERT_TRUE( r.location == 7 );
    ASSERT_TRUE( r.length   == 2 );
    
    r = [ @"hello, world" rangeOfCPPString: "universe" ];
    
    ASSERT_TRUE( r.location == NSNotFound );
    ASSERT_TRUE( r.length   == 0 );
}

TEST( Objective_CPP, rangeOfCPPString_options )
{
    NSRange r;
    
    r = [ @"hello, world" rangeOfCPPString: "wo" options: NSCaseInsensitiveSearch ];
    
    ASSERT_TRUE( r.location == 7 );
    ASSERT_TRUE( r.length   == 2 );
    
    r = [ @"hello, world" rangeOfCPPString: "WO" options: NSCaseInsensitiveSearch ];
    
    ASSERT_TRUE( r.location == 7 );
    ASSERT_TRUE( r.length   == 2 );
    
    r = [ @"hello, world" rangeOfCPPString: "universe" options: NSCaseInsensitiveSearch ];
    
    ASSERT_TRUE( r.location == NSNotFound );
    ASSERT_TRUE( r.length   == 0 );
}

TEST( Objective_CPP, rangeOfCPPString_options_range )
{
    NSRange r;
    
    r = [ @"hello, world" rangeOfCPPString: "wo" options: NSCaseInsensitiveSearch range: NSMakeRange( 0, 12 ) ];
    
    ASSERT_TRUE( r.location == 7 );
    ASSERT_TRUE( r.length   == 2 );
    
    r = [ @"hello, world" rangeOfCPPString: "WO" options: NSCaseInsensitiveSearch range: NSMakeRange( 0, 12 ) ];
    
    ASSERT_TRUE( r.location == 7 );
    ASSERT_TRUE( r.length   == 2 );
    
    r = [ @"hello, world" rangeOfCPPString: "wo" options: NSCaseInsensitiveSearch range: NSMakeRange( 0, 4 ) ];
    
    ASSERT_TRUE( r.location == NSNotFound );
    ASSERT_TRUE( r.length   == 0 );
    
    r = [ @"hello, world" rangeOfCPPString: "universe" options: NSCaseInsensitiveSearch range: NSMakeRange( 0, 12 ) ];
    
    ASSERT_TRUE( r.location == NSNotFound );
    ASSERT_TRUE( r.length   == 0 );
}

TEST( Objective_CPP, rangeOfCPPString_options_range_locale )
{
    NSRange r;
    
    r = [ @"hello, world" rangeOfCPPString: "wo" options: NSCaseInsensitiveSearch range: NSMakeRange( 0, 12 ) locale: nil ];
    
    ASSERT_TRUE( r.location == 7 );
    ASSERT_TRUE( r.length   == 2 );
    
    r = [ @"hello, world" rangeOfCPPString: "WO" options: NSCaseInsensitiveSearch range: NSMakeRange( 0, 12 ) locale: nil ];
    
    ASSERT_TRUE( r.location == 7 );
    ASSERT_TRUE( r.length   == 2 );
    
    r = [ @"hello, world" rangeOfCPPString: "wo" options: NSCaseInsensitiveSearch range: NSMakeRange( 0, 4 ) locale: nil ];
    
    ASSERT_TRUE( r.location == NSNotFound );
    ASSERT_TRUE( r.length   == 0 );
    
    r = [ @"hello, world" rangeOfCPPString: "universe" options: NSCaseInsensitiveSearch range: NSMakeRange( 0, 12 ) locale: nil ];
    
    ASSERT_TRUE( r.location == NSNotFound );
    ASSERT_TRUE( r.length   == 0 );
}

TEST( Objective_CPP, cppStringByReplacingOccurrencesOfString_withString )
{
    ASSERT_TRUE( [ @"hello, world" cppStringByReplacingOccurrencesOfString: @"world" withString: @"universe" ] == "hello, universe" );
    ASSERT_TRUE( [ @"hello, world" cppStringByReplacingOccurrencesOfString: @"foo"   withString: @"universe" ] == "hello, world" );
}

TEST( Objective_CPP, cppStringByReplacingOccurrencesOfString_withString_options_range )
{}

TEST( Objective_CPP, stringByReplacingOccurrencesOfString_withCPPString )
{
    ASSERT_TRUE( [ [ @"hello, world" stringByReplacingOccurrencesOfString: @"world" withCPPString: "universe" ] isEqualToString: @"hello, universe" ] );
    ASSERT_TRUE( [ [ @"hello, world" stringByReplacingOccurrencesOfString: @"foo"   withCPPString: "universe" ] isEqualToString: @"hello, world" ] );
}

TEST( Objective_CPP, stringByReplacingOccurrencesOfString_withCPPString_options_range )
{}

TEST( Objective_CPP, stringByReplacingOccurrencesOfCPPString_withString )
{
    ASSERT_TRUE( [ [ @"hello, world" stringByReplacingOccurrencesOfCPPString: "world" withString: @"universe" ] isEqualToString: @"hello, universe" ] );
    ASSERT_TRUE( [ [ @"hello, world" stringByReplacingOccurrencesOfCPPString: "foo"   withString: @"universe" ] isEqualToString: @"hello, world" ] );
}

TEST( Objective_CPP, stringByReplacingOccurrencesOfCPPString_withString_options_range )
{}

TEST( Objective_CPP, stringByReplacingOccurrencesOfCPPString_withCPPString )
{}

TEST( Objective_CPP, stringByReplacingOccurrencesOfCPPString_withCPPString_options_range )
{}

TEST( Objective_CPP, cppStringByReplacingCharactersInRange_withString )
{}

TEST( Objective_CPP, stringByReplacingCharactersInRange_withCPPString )
{}

TEST( Objective_CPP, caseInsensitiveCompareWithCPPString )
{
    ASSERT_TRUE( [ @"hello, world" caseInsensitiveCompareWithCPPString: "hello, WORLD"    ] == NSOrderedSame );
    ASSERT_TRUE( [ @"hello, world" caseInsensitiveCompareWithCPPString: "HELLO, WORLD"    ] == NSOrderedSame );
    ASSERT_TRUE( [ @"hello, world" caseInsensitiveCompareWithCPPString: "HELLO, WORLD..." ] != NSOrderedSame );
    ASSERT_TRUE( [ @"hello, world" caseInsensitiveCompareWithCPPString: "hello, UNIVERSE" ] != NSOrderedSame );
}

TEST( Objective_CPP, localizedCaseInsensitiveCompareWithCPPString )
{
    ASSERT_TRUE( [ @"hello, world" localizedCaseInsensitiveCompareWithCPPString: "hello, WORLD"    ] == NSOrderedSame );
    ASSERT_TRUE( [ @"hello, world" localizedCaseInsensitiveCompareWithCPPString: "HELLO, WORLD"    ] == NSOrderedSame );
    ASSERT_TRUE( [ @"hello, world" localizedCaseInsensitiveCompareWithCPPString: "HELLO, WORLD..." ] != NSOrderedSame );
    ASSERT_TRUE( [ @"hello, world" localizedCaseInsensitiveCompareWithCPPString: "hello, UNIVERSE" ] != NSOrderedSame );
}

TEST( Objective_CPP, compareWithCPPString )
{
    ASSERT_TRUE( [ @"hello, world" compareWithCPPString: "hello, world"    ] == NSOrderedSame );
    ASSERT_TRUE( [ @"hello, world" compareWithCPPString: "HELLO, WORLD"    ] != NSOrderedSame );
    ASSERT_TRUE( [ @"hello, world" compareWithCPPString: "hello, world..." ] != NSOrderedSame );
    ASSERT_TRUE( [ @"hello, world" compareWithCPPString: "hello, universe" ] != NSOrderedSame );
}

TEST( Objective_CPP, localizedCompareWithCPPString )
{
    ASSERT_TRUE( [ @"hello, world" localizedCompareWithCPPString: "hello, world"    ] == NSOrderedSame );
    ASSERT_TRUE( [ @"hello, world" localizedCompareWithCPPString: "HELLO, WORLD"    ] != NSOrderedSame );
    ASSERT_TRUE( [ @"hello, world" localizedCompareWithCPPString: "hello, world..." ] != NSOrderedSame );
    ASSERT_TRUE( [ @"hello, world" localizedCompareWithCPPString: "hello, universe" ] != NSOrderedSame );
}

TEST( Objective_CPP, compareWithCPPString_options )
{
    ASSERT_TRUE( [ @"hello, world" compareWithCPPString: "hello, world"    options: NSCaseInsensitiveSearch ] == NSOrderedSame );
    ASSERT_TRUE( [ @"hello, world" compareWithCPPString: "HELLO, WORLD"    options: NSCaseInsensitiveSearch ] == NSOrderedSame );
    ASSERT_TRUE( [ @"hello, world" compareWithCPPString: "hello, world..." options: NSCaseInsensitiveSearch ] != NSOrderedSame );
    ASSERT_TRUE( [ @"hello, world" compareWithCPPString: "hello, universe" options: NSCaseInsensitiveSearch ] != NSOrderedSame );
}

TEST( Objective_CPP, compareWithCPPString_options_range )
{}

TEST( Objective_CPP, compareWithCPPString_options_range_locale )
{}

TEST( Objective_CPP, localizedStandardCompareWithCPPString )
{}

TEST( Objective_CPP, hasCPPStringPrefix )
{
    ASSERT_TRUE(  [ @"hello, world" hasCPPStringPrefix: "hello" ] );
    ASSERT_FALSE( [ @"hello, world" hasCPPStringPrefix: "bonjour" ] );
}

TEST( Objective_CPP, hasCPPStringSuffix )
{
    ASSERT_TRUE(  [ @"hello, world" hasCPPStringSuffix: "world" ] );
    ASSERT_FALSE( [ @"hello, world" hasCPPStringSuffix: "universe" ] );
}

TEST( Objective_CPP, isEqualToCPPString )
{
    ASSERT_TRUE(  [ @"hello, world" isEqualToCPPString: "hello, world" ] );
    ASSERT_FALSE( [ @"hello, world" isEqualToCPPString: "hello, universe" ] );
}

TEST( Objective_CPP, cppStringByFoldingWithOptions_locale )
{}

TEST( Objective_CPP, commonPrefixWithCPPString_options )
{}

TEST( Objective_CPP, commonCPPPrefixWithString_options )
{}

TEST( Objective_CPP, capitalizedCPPString )
{
    ASSERT_TRUE( [ @"hello, world" capitalizedCPPString ] == "Hello, World" );
}

TEST( Objective_CPP, lowercaseCPPString )
{
    ASSERT_TRUE( [ @"HELLO, WORLD" lowercaseCPPString ] == "hello, world" );
}

TEST( Objective_CPP, uppercaseCPPString )
{
    ASSERT_TRUE( [ @"hello, world" uppercaseCPPString ] == "HELLO, WORLD" );
}

TEST( Objective_CPP, decomposedCPPStringWithCanonicalMapping )
{}

TEST( Objective_CPP, decomposedCPPStringWithCompatibilityMapping )
{}

TEST( Objective_CPP, precomposedCPPStringWithCanonicalMapping )
{}

TEST( Objective_CPP, precomposedCPPStringWithCompatibilityMapping )
{}

TEST( Objective_CPP, lastPathComponentAsCPPString )
{
    ASSERT_TRUE( [ @"foo/bar" lastPathComponentAsCPPString ] == "bar" );
}

TEST( Objective_CPP, pathExtensionAsCPPString )
{
    ASSERT_TRUE( [ @"foo/bar.txt" pathExtensionAsCPPString ] == "txt" );
}

TEST( Objective_CPP, cppStringByAbbreviatingWithTildeInPath )
{}

TEST( Objective_CPP, cppStringByAppendingPathComponent )
{
    ASSERT_TRUE( [ @"/foo/bar" cppStringByAppendingPathComponent: @"foobar" ] == "/foo/bar/foobar" );
}

TEST( Objective_CPP, stringByAppendingCPPPathComponent )
{
    ASSERT_TRUE( [ [ @"/foo/bar" stringByAppendingCPPPathComponent: "foobar" ] isEqualToString: @"/foo/bar/foobar" ] );
}

TEST( Objective_CPP, cppStringByAppendingCPPPathComponent )
{
    ASSERT_TRUE( [ @"/foo/bar" cppStringByAppendingCPPPathComponent: "foobar" ] == "/foo/bar/foobar" );
}

TEST( Objective_CPP, cppStringByAppendingPathExtension )
{
    ASSERT_TRUE( [ @"/foo/bar" cppStringByAppendingPathExtension: @"txt" ] == "/foo/bar.txt" );
}

TEST( Objective_CPP, stringByAppendingCPPPathExtension )
{
    ASSERT_TRUE( [ [ @"/foo/bar" stringByAppendingCPPPathExtension: "txt" ] isEqualToString: @"/foo/bar.txt" ] );
}

TEST( Objective_CPP, cppStringByAppendingCPPPathExtension )
{
    ASSERT_TRUE( [ @"/foo/bar" cppStringByAppendingCPPPathExtension: "txt" ] == "/foo/bar.txt" );
}

TEST( Objective_CPP, cppStringByDeletingLastPathComponent )
{
    ASSERT_TRUE( [ @"/foo/bar" cppStringByDeletingLastPathComponent ] == "/foo" );
}

TEST( Objective_CPP, cppStringByDeletingPathExtension )
{
    ASSERT_TRUE( [ @"/foo/bar.txt" cppStringByDeletingPathExtension ] == "/foo/bar" );
}

TEST( Objective_CPP, cppStringByExpandingTildeInPath )
{}

TEST( Objective_CPP, cppStringByResolvingSymlinksInPath )
{}

TEST( Objective_CPP, cppStringByStandardizingPath )
{}

TEST( Objective_CPP, cppStringByAddingPercentEscapesUsingEncoding )
{}

TEST( Objective_CPP, cppStringByReplacingPercentEscapesUsingEncoding )
{}
