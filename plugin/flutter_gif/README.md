# flutter_gif

We should know that in order to achieve Gif in flutter, we can use Image, but we have no way to manipulate Gif, for example: change its speed, control it has been playing in a frame,
 in which frame range loop. These problems can be solved by this widget,it also help you contain gif cache,avoid load frame every time.

# Screenshots

![](arts/gif.gif)

# Usage(Simple)
  add in pubspec

   ```dart

        flutter_gif: any // or the latest version on Pub

   ```

 simple usage

 ```dart
     FlutterGifController controller= FlutterGifController(vsync: this);


     GifImage(
          controller: controller,
          image: AssetImage("images/animate.gif"),
     )

 ```

 list the most common operate in FlutterGifController:


 ```dart
 // loop from 0 frame to 29 frame
 controller.repeat(min:0, max:29, period:const Duration(millseconds:300));

 // jumpTo thrid frame(index from 0)
 controller.value = 0;

 // from current frame to 26 frame
 controller.animateTo(26);

 ```

 If you need to preCache gif,try this

 ```dart
 // put imageProvider
 fetchGif(AssetImage("images/animate.gif"));

 ```


# Support the package (optional)
If you find this package useful, you can support it for free by giving it a thumbs up at the top of this page.  Here's another option to support the package:

<a href="https://www.buymeacoffee.com/saytoonz"><img src="https://img.buymeacoffee.com/button-api/?text=Buy me a coffee&emoji=&slug=saytoonz&button_colour=5F7FFF&font_colour=ffffff&font_family=Cookie&outline_colour=000000&coffee_colour=FFDD00" /></a>



# Thanks
* [flutter_gifimage](https://github.com/peng8350/flutter_gifimage)

# License

```
MIT License

Copyright (c) 2019 Jpeng

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

```