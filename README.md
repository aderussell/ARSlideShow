# ARSlideShow


## Creating a slide show



### A simple example

```
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
