# Calculator Application (iOS)

#### Table Of Content
[Short Description](#sdesc)
[Design](#design)
[Architecture](#arch)
[Responsive View Pictures](#view)


<a name="sdesc"/>

### Short Description
The project is about the calculator iOS application using swift programming language. I would like to provide context in points mentioned below.
* Created an enitre project programmatically without using any xib file.
* Created project using MVC model to keep the models, views, and controllers seperate.
* Used UILabel, UIButton to create a view.

<a name="design"/>

### Design
* The view of an application is very simple. It has only one view with it's viewcontroller and model. 
* The view is created using AutoLayout and activated respective constraints to it so that it will become responsive.
* The buttons are tappable and it should display respective expression on the screen that is in UILabel.

<a name="arch"/>

### Architecture
* I have created a verticle stack view that will store all other views. Set the safearea constraints to it for responsive design.
* Created a UILabel to show the expression on the screen.
* Created following stack views:
  1. Stack view with buttons %, DEL, AC, /.
  2. Stack view with buttons 7, 8, 9, x.
  3. Stack view with buttons 4, 5, 6, -.
  4. Stack view with buttons 1, 2, 3, +.
  5. Stack view with buttons 0, ., =.
* Added thses five horizontal stack views to the vertical stack view.
* Finally, I got the required view with responsive layout. See the pictures below.

<a name="view"/>

### Responsive View Pictures
* Here is a responsive view on portrait mode of iPhone 13 pro max.
<img src="https://drive.google.com/uc?export=view&id=1I0OzVKyMT5A4FszofgEZiTqnFNaISInO" height="600px"/>
