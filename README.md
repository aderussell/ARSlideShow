# ARSlideShow


## Installing

The easiest way to install to your project is using Cocoapods.

`pod 'ARSlideShow'`

If you wish to manually install as a dependency, copy all the files from the [ARSlideShow folder](ARSlideShow/) to your project.



## Creating a slide show

Slide shows are controlled by an instance of `ARSlideShowController`. 
The controller will be instantiated with the container view there the slideshow will be presented and an `ARSlideShowImageProviding` data provider which will provide all the images to be displayed as well as any transition animators to be used to transition between the images.
It can also take an optional music controller which can play background music along with the slide show while it is being displayed.



### A simple example

``` objective-c
// prepare the images to be shown in the slide show.
// note that this is an example object used only by the example project and not a part of ARSlideShow
TestImagesSlideShowImagePreparation *imagePreparation = [[TestImagesSlideShowImagePreparation alloc] init];
[imagePreparation prepareImages:nil];

// create an image provider object for the slide show which will provide the images to be displayed and the transitions to use between the provided images
id<ARSlideShowImageProviding> imageProvider = [[TestSlideShowImageProvider alloc] initWithImages:imagePreparation.images];

// get the view upon which the slide show images will be displayed
UIView *containerView = self.view;

// create the slide show controller with the image provider and container view
ARSlideShowController *slideShowController = [[ARSlideShowController alloc] initWithImageProvider:imageProvider containerView:containerView musicController:nil];
slideShowController.repeat   = YES;
slideShowController.delegate = self;

// start the slide show
[slideShowController beginSlideShow];
```

### Creating an image provider

An image provider must conform to `ARSlideShowImageProviding`.




### Creating a music controller




## Available animated transitions

* No Animation (`NoAnimationTransitionAnimator`)
* Slide (`SlideTransitionAnimator`)
* Bounce (`BounceTransitionAnimator`)
* Spin (`SpinTransitionAnimator`)
* Cube (`CubeTransitionAnimator`)
* Fade (`FadeTransitionAnimator`)
* Iris In (`IrisTransitionAnimation`)
* Explosion (`ExplosionTransitionAnimation`)
