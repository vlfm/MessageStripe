MessageStripe
=============

MessageStripe is popup message view that is displayed on screen for short period of time.
It's kind of Toast on Android platform, but is context aware: it is displayed in a particular UIViewController in specified position.
MessageStripe aligns text at center horizontally and vertically and adjusts font according to its size.

Usage
===
[MessageStripe showMessage:@"Login failed! Please check your name and password"
              inViewController:self
                       inFrame:CGRectMake(x, y, w, h)];

![Screenshot](https://raw.github.com/vlfm/MessageStripe/master/Screenshots/(5, 5, 300, 65).png "(x=5, y=5, w=300, h=65)")  ![Screenshot](https://raw.github.com/vlfm/MessageStripe/master/Screenshots/(20, 20, 260, 65).png "(x=20, y=20, w=260, h=65)")  ![Screenshot](https://raw.github.com/vlfm/MessageStripe/master/Screenshots/(20, 20, 260, 110).png "(x=20, y=20, w=260, h=110)")