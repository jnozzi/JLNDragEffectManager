//
//  DragQueenDemoView.m
//  Drag Queen
//
//  Created by Joshua Nozzi on 10/27/09.
//  Copyright 2009 Joshua Nozzi. All rights reserved.
//
//	 This software is supplied to you by Joshua Nozzi in consideration 
//	 of your agreement to the following terms, and your use, installation, 
//	 modification or redistribution of this software constitutes 
//	 acceptance of these terms. If you do not agree with these terms, 
//	 please do not use, install, modify or redistribute this software.
//	 
//	 In consideration of your agreement to abide by the following terms, 
//	 and subject to these terms, Joshua Nozzi grants you a personal, 
//	 non-exclusive license, to use, reproduce, modify and redistribute 
//	 the software, with or without modifications, in source and/or binary 
//	 forms; provided that if you redistribute the software in its entirety 
//	 and without modifications, you must retain this notice and the 
//	 following text and disclaimers in all such redistributions of the 
//	 software, and that in all cases attribution of Joshua Nozzi as the 
//	 original author of the source code shall be included in all such 
//	 resulting software products or distributions. Neither the name, 
//	 trademarks, service marks or logos of Joshua Nozzi may be used to 
//	 endorse or promote products derived from the software without specific 
//	 prior written permission from Joshua Nozzi. Except as expressly stated 
//	 in this notice, no other rights or licenses, express or implied, are 
//	 granted by Joshua Nozzi herein, including but not limited to any patent 
//	 rights that may be infringed by your derivative works or by other works 
//	 in which the software may be incorporated.
//	 
//	 THIS SOFTWARE IS PROVIDED BY JOSHUA NOZZI ON AN "AS IS" BASIS. JOSHUA 
//	 NOZZI MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT 
//	 LIMITATION THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY 
//	 AND FITNESS FOR A PARTICULAR PURPOSE, REGARDING THE SOFTWARE OR ITS USE 
//	 AND OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
//	 
//	 IN NO EVENT SHALL JOSHUA NOZZI BE LIABLE FOR ANY SPECIAL, INDIRECT, 
//	 INCIDENTAL OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
//	 PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
//	 PROFITS; OR BUSINESS INTERRUPTION) ARISING IN ANY WAY OUT OF THE 
//	 USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION OF THE SOFTWARE, 
//	 HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING 
//	 NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF JOSHUA NOZZI HAS 
//	 BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//	


#import "DragQueenDemoView.h"
#import "JLNDragEffectManager.h"


@implementation DragQueenDemoView


#pragma mark Mouse Interaction

- (void)mouseDragged:(NSEvent *)theEvent
{
	/* 
	 
		Here, we start the dragging session normally for the most part. 
		
		Two caveats:
		
		1 - Passing nil for the drag image makes Cocoa angry. You DO NOT want 
			to anger Cocoa the Drag Queen. She's fierce, girl. Seriously. Cocoa 
			is also a size queen. An image of NSZeroSize just won't do, honey.
			
			To get around these issues, just give her what she wants: "an" image 
			with dimensions. An empty one with a size of {1, 1} will fool her 
			since she's always liquered up anyway. She'll never notice.
	 
		2 - Cocoa runs on her schedule. If you ask HER to do the slide-back, 
			she'll take her time before we get to clean up after her. Best
			not to ask - we'll do it ourselves.
	 
	 */
	
	[self dragImage:[[[NSImage alloc] initWithSize:NSMakeSize(1, 1)] autorelease] 
				 at:[NSEvent mouseLocation] 
			 offset:NSZeroSize 
			  event:theEvent 
		 pasteboard:nil 
			 source:self 
		  slideBack:NO];
}


#pragma mark Dragging Source

- (NSDragOperation)draggingSourceOperationMaskForLocal:(BOOL)isLocal
{
	return NSDragOperationNone;
}

- (void)draggedImage:(NSImage *)anImage beganAt:(NSPoint)aPoint
{
	// Let's figure out our geometry. For shits-n-giggles, we'll 
	// make the whole window our source screen rect, and the 
	// current mouse position (at start of drag) as the slide-back point
	NSPoint startPointInScreen = [NSEvent mouseLocation];
	NSRect sourceScreenRect = [[self window] frame];
	
	// Let's use some images reminiscent of Interface Builder's
	// drag-from-Library-palette-to-make-a-real-object effect
	NSImage * insideImage = [NSImage imageNamed:@"textfieldasicon"];
	NSImage * outsideImage = [NSImage imageNamed:@"textfieldrealized"];
	
	// Don the boas and start the drag show!
	[[JLNDragEffectManager sharedDragEffectManager] startDragShowFromSourceScreenRect:sourceScreenRect 
																	  startingAtPoint:startPointInScreen 
																			   offset:NSZeroSize
																		  insideImage:insideImage 
																		 outsideImage:outsideImage 
																			slideBack:YES];
}

- (void)draggedImage:(NSImage *)draggedImage movedTo:(NSPoint)screenPoint
{
	// Update the position
	[[JLNDragEffectManager sharedDragEffectManager] updatePosition];
}

- (void)draggedImage:(NSImage *)anImage endedAt:(NSPoint)aPoint operation:(NSDragOperation)operation
{
	// End the drag show, clean up the glitter and sweat-and-masquera puddles and call it a day
	[[JLNDragEffectManager sharedDragEffectManager] endDragShowWithResult:operation];
	
	// Do any other processing you might need, including going home to your cats and wig collection
	// ...
}


@end
