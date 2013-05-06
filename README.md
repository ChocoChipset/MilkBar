MilkBar
=======

iOS library to create simple bar charts.

Given an array of NSNumber objects, the library will generate a UIImage object containing a simple graph representing them. The height of the tallest bar will correspond to the maximum value of the array.  

![MilkBar Example](http://i.imgur.com/ZoMmGup.png)

Usage
----

1. Import the files located in the folder *Source/* to your project.

2. Initialize an instance of *MBBarGrapher* with a non-empty NSArray containing only instances of NSNumbers.

    ```objective-c
    NSArray *exampleValues = @[@23, @35.5, @20, @70.2, @45.5, @47.7, @13.2, @33.3, @69.999, @83.25, @90.2, @99.9, @120.0];
        
    MBBarGrapher *barGrapher = [[MBBarGrapher alloc] initWithValues:exampleValues];
    ```

3. Adjust the background, outline and fill colors and the space between bars

    ```objective-c
    barGrapher.percentageOfSpaceBetweenBars = 0.2;
        
    barGrapher.fillColor = [UIColor orangeColor];
    barGrapher.strokeColor = [UIColor blackColor];
    barGrapher.backgroundColor = [UIColor clearColor];
    ```

4. Generate a UIImage to display on screen, send through the Internetz or whatever.

    ```objective-c
    self.imaginaryImageView.image = [barGrapher generateImageForSize:self.imaginaryImageView.bounds.size];
    ```
    
5. Life happily everafter.


Current Limitations
-------------------

* Currently the library handles only positive real values.


To-Dos
------
Please refer to the "Issues" section in Github.


Contribution
------------
Of course! Fork this project and feel free to contribute your ideas, bug-fixes, re-factoring or suggestions through a pull-request.


License
-------

Copyright (c) 2013 Hector Zarate

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
