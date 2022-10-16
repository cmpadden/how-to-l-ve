# How to LÖVE

Walking through the fantastic tutorial: [How to LÖVE](https://sheepolution.com/learn/book/contents) by Sheepolution, on learning to program games with LÖVE.

## Structure

Folders have been created for each chapter of the tutorial.

```
.
├── 15-shooter-game
├── 16-angles-and-distance
├── 17-animation
├── 18-tiles
├── 19-audio
├── 21-saving-and-loading
├── 22-cameras-and-canvases-pt1
├── 22-cameras-and-canvases-pt2
├── 23-resolving-collision
├── 24-platformer
├── README.md
└── love
```

## Prerequisites

On MacOS you can install LÖVE using brew:

```sh
brew install --cask love
```

To run the application, you must use the application path, which can be determined using `brew info`.

```sh
> brew info --json=v2 love | jq .casks[0].artifacts[1].binary[0]

"/Applications/love.app/Contents/MacOS/love"
```
