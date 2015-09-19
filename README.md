# A collection of things I did during the 6 weeks of Creative Coding

I've been inundated with requests (2) for me to post some of the code I created as I worked by way through Future Learn's Creative Coding course.

One thing I particularly like about Processing is the use of "Sketch" for a program, it feels relaxed, loose, inviting you to quickly sketch out ideas. As such the code here was never really supposed to be public, some of it was iterated over quick sometimes changing direction halfway through. I'm a long time coder, but only dabbled in Processing, often giving up on it due to terrible debugging tools, which are now partially addressed in version 3.

I've gone back into the code to add comments and clean away some of the redundant cruft that was left over from coding swerves. All of this is a long winded way of apologising for the state of the code, much of which was written during late evenings.

There is however a narrative of sorts, an evolution of ideas running through the code. If this were a book it'd make sense to start reading the code at the beginning and work your way through to the somewhat lackluster end. The most probable action though is to jump right into the hexagons as they're the prettiest.

Either way, I hope there's something in here that helps someone somewhere, especially if you came via google looking for answers, they may be in here.

### On naming conventions

Apparently I didn't do any coding during week one, but for the rest of the weeks I did stuff based on the course, and more stuff inspired by the course where I wanted to quickly thrash out ideas.

Sketches starting with "c0x\_" are sketches done for the course, those with "c9x\_bonus\_" are extras often taking an element of the course and pushing into something I wanted to test.

Onwards...

## [Week 2](https://github.com/revdancatt/FutureLearn-Creative-Coding/tree/master/week_02)

An introduction to rules and systems, how can we follow rules to create generative art?

### [c01_25squares](https://github.com/revdancatt/FutureLearn-Creative-Coding/tree/master/week_02/c01_25squares)

![25 Squares](https://raw.githubusercontent.com/revdancatt/FutureLearn-Creative-Coding/master/week_02/c01_25squares/frames/square_004.png)

Playing with [`handy`](http://www.gicentre.net/handy), to give things a sketched feel. And promptly wanted to use it for every single new project it was that fun/good.

### [c02_line_loops](https://github.com/revdancatt/FutureLearn-Creative-Coding/tree/master/week_02/c02_line_loops)

![Line Loops](https://raw.githubusercontent.com/revdancatt/FutureLearn-Creative-Coding/master/week_02/c02_line_loops/frames/round_085.png)

In which I learn that cutting 500x500px animated gif loops is great for tumblr.

### [c03_circles](https://github.com/revdancatt/FutureLearn-Creative-Coding/tree/master/week_02/c03_circles)

![More with the handy library](https://raw.githubusercontent.com/revdancatt/FutureLearn-Creative-Coding/master/week_02/c03_circles/frames/sketch_004.png)

Which introduced us to accepting keyboard input, meanwhile I was more interested in how circles look awesome with the `handy` library (again!!)

### [c99_bonus_cubes](https://github.com/revdancatt/FutureLearn-Creative-Coding/tree/master/week_02/c99_bonus_cubes)

![All the animated cubes](https://raw.githubusercontent.com/revdancatt/FutureLearn-Creative-Coding/master/week_02/c99_bonus_cubes/cubes.gif)

I wanted to move off grid, and always been interested in isometric graphics. An attempt was made to animate cubes, which in this case are really hexagons.

Once again in special tumblr format :)

## [Week 3](https://github.com/revdancatt/FutureLearn-Creative-Coding/tree/master/week_03)

Has me linking `sin()` functions and `frameCount` together for more perfectly looping gifs. And into probably the prettiest part of the course, the screensave/wallpaper lines. Which I then wanted to take in 3D.

### [c01_obligatory_tumblr_gif_loop](https://github.com/revdancatt/FutureLearn-Creative-Coding/tree/master/week_03/c01_obligatory_tumblr_gif_loop)

![The loops](https://raw.githubusercontent.com/revdancatt/FutureLearn-Creative-Coding/master/week_03/c01_obligatory_tumblr_gif_loop/animated.gif)

Sin waves, circles, the illusion of rotation oh my.

### [c02_draw_the_pretty_lines](https://github.com/revdancatt/FutureLearn-Creative-Coding/tree/master/week_03/c02_draw_the_pretty_lines)

![All the pretty lines](https://raw.githubusercontent.com/revdancatt/FutureLearn-Creative-Coding/master/week_03/c02_draw_the_pretty_lines/frames/frame_002500.png)

I think a lot of the success in these line images comes from an understanding of colours and opacity. By knocking back the opacity I knew what I was looking for wasn't the initial burst of lines, but rather the subtle build up of tones and saturation, while not letting the image get too busy.

Pulling from the more subtle CMYK palette rather than bolder RGB helps too.

What I'm getting at here is that a) I'm awesome and b) going into code with an understanding of colour, tone and texture beats trying to force an end result with just the code. Code itself is not enough.

### [c03_draw_zachary](https://github.com/revdancatt/FutureLearn-Creative-Coding/tree/master/week_03/c03_draw_zachary)

![Draw Zachary](https://raw.githubusercontent.com/revdancatt/FutureLearn-Creative-Coding/master/week_03/c03_draw_zachary/zachary.gif)

An attempt to combine the line drawing code and an image, to have the effect of the line drawing the image. Arguably this didn't really work. Which I think is a function of the algorithm used to move the line around than anything else. Given time I'd do this one differently.

### [c97_bonus_3D_cube](https://github.com/revdancatt/FutureLearn-Creative-Coding/tree/master/week_03/c97_bonus_3D_cube)

![Too fast explody cubes](https://raw.githubusercontent.com/revdancatt/FutureLearn-Creative-Coding/master/week_03/c97_bonus_3D_cube/cubes.gif)

I wanted to move the lines code into 3D, but before that I figured I need to explore 3D a little, which I did writing some code to draw, rotate a cube in 3D. And being able to manipulate elements of it. There's something useful going on here for pattern making, but I didn't push it far enough.

### [c98_bonus_isometric_ish_cube](https://github.com/revdancatt/FutureLearn-Creative-Coding/tree/master/week_03/c98_bonus_isometric_ish_cube)

Figuring out how to do isometric stuff with cubes thinking I'd go off in that direction. To have them being properly lit by (maybe moving) lighting rather than drawing "3D" cubes in 2D was the end objective. I didn't get very far, but enough to know it was do-able, which is what counts.

### [c99_bonus_3D_pretty_lines](https://github.com/revdancatt/FutureLearn-Creative-Coding/tree/master/week_03/c99_bonus_3D_pretty_lines)

![Bouncing points in 3D](https://raw.githubusercontent.com/revdancatt/FutureLearn-Creative-Coding/master/week_03/c99_bonus_3D_pretty_lines/loop01.gif)

Taking the "bouncing lines" code and turning it into 3D was relatively simple, although I had to separated out the code that moved the lines from the code that drew them which was closely paired in the 2D version.

The gif above shows the points bouncing around inside a box, meanwhile the full code persists those lines within the 3D space. But it's harder to show what's going in a single still from the whole sketch.

[[Click here or below to see HD YouTube version](http://www.youtube.com/watch?v=oMzJUlSgq5g)]<br />
[![YouTube 3D Lines video](http://img.youtube.com/vi/oMzJUlSgq5g/0.jpg)](http://www.youtube.com/watch?v=oMzJUlSgq5g "YouTube 3D Lines video")


## [Week 4](https://github.com/revdancatt/FutureLearn-Creative-Coding/tree/master/week_04)

This was probably the most fun week, and got the most interesting images out of me. I'd had an image in my head for such a long time from a cut & paste collage I'd seen years ago. Where triangles had been cut out of a design and swapped around.

Triangle pose an interesting challenge for coding in that computers are great at rectangles. Not so much at triangles (and by extension, hexagons).

When we started with the pixel reading/writing code I knew it was a chance to have a go (and by chance I mean, time set aside that I normally wouldn't have).

### [c01_one_pixel_cinema](https://github.com/revdancatt/FutureLearn-Creative-Coding/tree/master/week_04/c01_one_pixel_cinema)

![One pixel Cinema](https://raw.githubusercontent.com/revdancatt/FutureLearn-Creative-Coding/master/week_04/c01_one_pixel_cinema/film_thelma_louise/frame_0001.png)

There are a number of ways to extract the main colour palette used in an image, and each have their own idiosyncrasies. Because I'm terrible slack in the past I always just scale the image down to a 1x1, 5x1, 2x2, 3x2 and so on pixel image depending on my need, then read the very few pixel values and use those.

In this case I just scale the image down to a 2 pixel high image. Then in theory I could just scale the image back up. In this case I'm actually reading the values and then drawing lines between the two values incase I want to do something different or clever with them (maybe throw in some curves).

### [c98_bonus_3D_landscape](https://github.com/revdancatt/FutureLearn-Creative-Coding/tree/master/week_04/c98_bonus_3D_landscape)

![3D Landscape](https://raw.githubusercontent.com/revdancatt/FutureLearn-Creative-Coding/master/week_04/c98_bonus_3D_landscape/frames/frame_0030.png)

Back into the land (natch) of 3D. This was very quick and a test of the random noise generator in Processing. Also to test the lighting a little bit. There's about a billion different ways this could be improved.

### [c99_bonus_triangle_images](https://github.com/revdancatt/FutureLearn-Creative-Coding/tree/master/week_04/c99_bonus_triangle_images)

![Triangles!](https://raw.githubusercontent.com/revdancatt/FutureLearn-Creative-Coding/master/week_04/c99_bonus_triangle_images/source01/frame_0011.png)

And here we are with the great triangle switch-a-roo. Almost everything I want to say about this is in the comments in the code. Again I love this because we don't often see triangles used in computer graphics. I used a number of source images and seems it works best with primary colours and strong contrasts.

Code should just-work so try for yourself.

## [Week 5](https://github.com/revdancatt/FutureLearn-Creative-Coding/tree/master/week_02)

I don't recall there being much in the way of projects to code this week, more of an introduction to new concepts. I took the time out to finally get round to exploring hexes. Just like the triangle grid it's fun to work off square-grid. There's the extra utility that if you have a hex grid by it's very nature you have a triangle grid (and the other way round I guess).

First...

### [c01_clock](https://github.com/revdancatt/FutureLearn-Creative-Coding/tree/master/week_05/c01_clock)

![Clock](https://raw.githubusercontent.com/revdancatt/FutureLearn-Creative-Coding/master/week_05/c01_clock/clock.gif)

Time and motion. An excuse to throw in the rotation matrix stuff I'd learnt. Pretty simple with a couple of interesting things going on in the framing. I didn't want to let the numbers just float around in space, and yet the framing should distract from the numbes, after all those are what you want to read, but still represent the tick/tock passing of time.

### [c02_hex_pattern](https://github.com/revdancatt/FutureLearn-Creative-Coding/tree/master/week_05/c02_hex_pattern)

![Hexes](https://raw.githubusercontent.com/revdancatt/FutureLearn-Creative-Coding/master/week_05/c02_hex_pattern/frames/frame_0008.png)

![Hexes 2](https://raw.githubusercontent.com/revdancatt/FutureLearn-Creative-Coding/master/week_05/c02_hex_pattern/frames/frame_0004.png)

This was the 1st pass at generating a hexgrid, there's still a few logical/math flaws in the code, but they tend to be hidden away from most use cases.

This code through various tweaking generated a variety of image. The default one is pretty good as showing what's going on with the various sizes of hexes. But changing values around can give a surprising about of different effects.

### [c03_sketchy_hex_pattern](https://github.com/revdancatt/FutureLearn-Creative-Coding/tree/master/week_05/c03_sketchy_hex_pattern)

![Sketchy Hexes](https://raw.githubusercontent.com/revdancatt/FutureLearn-Creative-Coding/master/week_05/c03_sketchy_hex_pattern/c03_sketchy_hex_pattern.jpg)

Haven't touched the `handy` sketchy effect for a while, time to sort that out :D

### [c04_colourful_hexes](https://github.com/revdancatt/FutureLearn-Creative-Coding/tree/master/week_05/c04_colourful_hexes)

![Colourful Hexes](https://raw.githubusercontent.com/revdancatt/FutureLearn-Creative-Coding/master/week_05/c04_colourful_hexes/example_06.jpg)

This started off as an failed experiment as importing and reusing an SVG to form a pattern. In the end I just hand rolled the code to divide a hex up into segments. I'll need to come back to importing SVG another day. I suspect my problems were more caused by Illustrator and Photoshop than Processing.

Again, I tweaked the code a lot while figuring out what I was doing.

### [c97_bonus_circles_on_hex_grid](https://github.com/revdancatt/FutureLearn-Creative-Coding/tree/master/week_05/c97_bonus_circles_on_hex_grid)

![Circles on a hex grid](https://raw.githubusercontent.com/revdancatt/FutureLearn-Creative-Coding/master/week_05/c97_bonus_circles_on_hex_grid/anim1/frame_0154.png)

What patterns, I thought, would you get if you put expanding circles on the hex grid. One way to find out.

### [c98_bonus_3D_hexes](https://github.com/revdancatt/FutureLearn-Creative-Coding/tree/master/week_05/c98_bonus_3D_hexes)

![3D hexes](https://raw.githubusercontent.com/revdancatt/FutureLearn-Creative-Coding/master/week_05/c98_bonus_3D_hexes/hex_tower.gif)

After creating the hex images I was challenged on twitter to add a couple of dimensions. So I added an extra two, the 3rd and time.

Next up Hex-Bert.

### [c99_bonus_hexgrid_svg](https://github.com/revdancatt/FutureLearn-Creative-Coding/tree/master/week_05/c99_bonus_hexgrid_svg)

![Hex cuts](https://raw.githubusercontent.com/revdancatt/FutureLearn-Creative-Coding/master/week_05/c99_bonus_hexgrid_svg/papercuts.jpg)

I got my hands on a craft paper cutting machine (like a laser cutter but less likely to burst into flame), you feed it SVGs and it cuts the shapes out.

I failed to import an SVG, how hard could it be to export one.

Super easy as it happens, you start an SVG capture, draw all the shapes then end the capture. With SVG exported, I (using supplied software) sent it to the cutting machine and got the above back.

## [Week 6](https://github.com/revdancatt/FutureLearn-Creative-Coding/tree/master/week_06)

Probably the trickiest of weeks because I had very little time and was probably trying to cram too much new stuff into that time. I aimed to learn all about Vectors (or at least understand them more than I did before) and FFT audio processing, which I've done in JavaScript before but not Processing.

### [c01_landscape_postcard](https://github.com/revdancatt/FutureLearn-Creative-Coding/tree/master/week_06/c01_landscape_postcard)

![Landscape 1](https://raw.githubusercontent.com/revdancatt/FutureLearn-Creative-Coding/master/week_06/c01_landscape_postcard/seed_3175/frame_00200.png)

![Landscape 2](https://raw.githubusercontent.com/revdancatt/FutureLearn-Creative-Coding/master/week_06/c01_landscape_postcard/seed_1039/frame_03000.png)

![Landscape 3](https://raw.githubusercontent.com/revdancatt/FutureLearn-Creative-Coding/master/week_06/c01_landscape_postcard/seed_9652/frame_00200.png)

I never quite got this one right. There were some nice elements to it, the random colours, the stars the moved over time as the sky got darker. Flowing landscape that were slightly different each time. And a bunch of fireflies flitting around with boid like behaviour. The speed of the Aurora, flies and hex sizes all controlled by different parts of the audio being played it.

Each part of the code was trying ideas out, so I could take the elements and work with them. But they never really worked together. Something to build on though.

I played (which is why it's a bit shonky) the audio live from a Native Instruments Komplete Kontrol, piping it in via SoundFlower. Could easily change the code to get the audio in from somewhere else.

[[Click here or below to see HD Vimeo version](https://player.vimeo.com/video/138961447)]<br />
[![YouTube 3D Lines video](https://i.vimeocdn.com/video/534561113_640x360.jpg)](https://player.vimeo.com/video/138961447 "Vimeo landscape video")
