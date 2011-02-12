JLNDragEffectManager
Written by Joshua Nozzi
http://joshua.nozzi.name
========================


What is JLNDragEffectManager?
----------------------------

JLNDragEffectManager is a subclass of NSWindowController which allows you to replace a static dragging image with an animated effect similar to dragging items from the Library palette to a window or view in Interface Builder.


What platforms does it support?
-------------------------------

It might work on 10.4 (I think), but it should definitely work on 10.5 and beyond.


What are the licensing requirements?
------------------------------------

See the license document (License.txt) that is included with the source code. It is free to use but requires attribution. Feel free to contact me at joshua@nozzi.name with any licensing questions.


How do I use it in my project?
------------------------------

1 - Copy JLNDragEffectManager.m and JLNDragEffectManager.h into your project.
2 - Include JLNDragEffectManager.h wherever you intend to use it.
3 - Link against QuartzCore.framework in any target in which you intend to use it.
4 - Wire it up to your desired views' dragging source protocol methods (start to start, moved to update, end to end), per the example code found in DragQueenDemoView.m.


How can I reach you?
--------------------

You can e-mail me at joshua@nozzi.name. I'm happy to answer most questions about this source code but am not willing to "hold your hand" or debug your code. It's straightforward to use if you are familiar with Cocoa and take a few moments to study the source. Please do your homework first. Questions sent to me that make it obvious the sender didn't do their homework will be ignored.


