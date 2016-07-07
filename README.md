# ImageQuilting
Image Quilting for Texture Synthesis and Transfer

## Explanation
Synthesizing images by stitching together small patches.
Using Matlab.

## Results
#### Image Quilting
![input_2.bmp](https://raw.githubusercontent.com/PJunhyuk/ImageQuilting/master/img/image-quilting/input_2.bmp)
![iq-result_2.png](https://raw.githubusercontent.com/PJunhyuk/ImageQuilting/master/img/image-quilting/iq-result_2.png)
#### Texture Synthesis
![texture_4.jpg](https://raw.githubusercontent.com/PJunhyuk/ImageQuilting/master/img/texture-synthesis/texture_4.jpg)

![target.jpg](https://raw.githubusercontent.com/PJunhyuk/ImageQuilting/master/img/texture-synthesis/target.jpg)

![ts-result_4.jpg](https://raw.githubusercontent.com/PJunhyuk/ImageQuilting/master/img/texture-synthesis/ts-result_4.jpg)

## Usage
- For image quilting
  1. Download all Matlab codes in one folder.
  1. Open quilt_simple.m
  1. Input "cmdcode_quilt_simple"
  
- For texture transfer
  1. Download all Matlab codes in one folder.
  1. Open texture_transfer.m
  1. Input "cmdcode_texture_transfer"

#### Cmdcodes
cmdcode_quilt_simple

```
clear;
clc;
datestr(now)
sample = imread('input5.bmp');
outsize = [600; 600];
patchsize = 48;
overlap = 8;
tol = 0.1;
// sample
imout = quilt_simple(sample, outsize, patchsize, overlap, tol);
imout = imout / 255;
imshow(imout);
```

cmdcode_texture_transfer
```
clear;
clc;
datestr(now)
texture = imread('texture7.jpg');
texture = double(texture);
patchsize = 10;
overlap = 3;
target = imread('target.jpg');
target = double(target);
tol = 0.1;
// sample
imout = texture_transfer(texture, target, patchsize, overlap, tol);
imout = imout / 255;
imshow(imout);
```

## References
- Image Quilting for Texture Synthesis and Transfer(Alexei A. Efros, William T. Freeman)
  - link : http://graphics.cs.cmu.edu/people/efros/research/quilting/quilting.pdf
