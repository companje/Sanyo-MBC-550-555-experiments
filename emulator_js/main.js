var greenOffset = 0x0c000;
var memory = [];
var cols=72;
var w=576;
var h=200;
// var context = document.getElementById("canvas").getContext("2d");
// var imgData = context.getImageData(0, 0, width, height);
// var pixels = imgData.data;

function preload() {
  loadBytes("game-of-life.img",(data)=>{
    for (let i = 0; i < data.bytes.byteLength; i++) {
      memory[0x00380 + i] = data.bytes[i];
    }    
  });
}

function setup() {
  pixelDensity(1);
  createCanvas(w, h);
  // console.log(width,height);
  ah = al = bh = bl = 0;
  ch = cl = dh = dl = 0;
  si = 0;
  di = 0;
  cs = 0x0038;
  ss = 0x0be4;
  sp = 0x0000;
  halt = false;
}

function draw() {
  // background(50);

  for (var i=0; i<1000; i++) {
    tick();
  }

  loadPixels();
  for (var y=0, bit=0, j=0; y<height; y++) {
    for (var x=0; x<width; x++, bit=128>>(x%8), j++) {
      const i = Math.floor(y/4)*(width/2)+(y%4)+Math.floor(x/8)*4;
      // const r = (memory[0xf0000+i] & bit)>0 ? 255 : 0;
      // const g = (memory[greenOffset+i] & bit)>0 ? 255 : 0;
      // const b = (memory[0xf4000+i] & bit)>0 ? 255 : 0;
      
      pixels[j+0] = (memory[0xf0000+i] & bit) * 255; //>0 ? 255 : 0;
      pixels[j+1] = (memory[greenOffset+i] & bit) * 255; //>0 ? 255 : 0;
      pixels[j+2] = (memory[0xf4000+i] & bit) * 255; //>0 ? 255 : 0;
      pixels[j+3] = 255;
    }
  }
//   for (var i=0; i<w*h*4; i+=4) {
// pixels[i+0] = 255;
// pixels[i+1] = 255;
// pixels[i+2] = 255;
// pixels[i+3] = 255;  
// } 

  updatePixels();
}

// async function setup() {
//   await reload();
//   window.requestAnimationFrame(draw);
// }

// async function draw() {  
//   for (var i=0; i<10000; i++) {
//     tick();
//   }

//   for (var y=0, bit=0, j=0; y<height; y++) {
//     for (var x=0; x<width; x++, bit=128>>(x%8), j+=4) {
//       const i=Math.floor(y/4)*(width/2)+(y%4)+Math.floor(x/8)*4;
//       pixels[j+0] = (memory[0xf0000+i] & bit) * 255; //>0 ? 255 : 0;
//       pixels[j+1] = (memory[greenOffset+i] & bit) * 255; //>0 ? 255 : 0;
//       pixels[j+2] = (memory[0xf4000+i] & bit) * 255; //>0 ? 255 : 0;
//       pixels[j+3] = 255;
//    }
//   }
//   context.putImageData(imgData,0,0);
//   window.requestAnimationFrame(draw);
// }

// setup();

// function portIn(port) {
//   return 0;
// }

// function portOut(port,val) {

// }

// function reload() {
//   return new Promise((resolve) => {
//     reset();
//     for (var i=0; i<0x200000; i++) {
//       memory[i] = 0; //Math.random()*255;
//     }

//     //load memory from file here:
//     var xhr = new XMLHttpRequest();
//     xhr.open('GET', 'game-of-life.img', true);
//     xhr.responseType = 'arraybuffer';

//     self = this;

//     xhr.onload = function(e) {
//       const arrayBuffer = this.response; // Note: not oReq.responseText
//       if (arrayBuffer) {
//         const byteArray = new Uint8Array(arrayBuffer);
//         for (let i = 0; i < byteArray.byteLength; i++) {
//           memory[0x00380 + i] = byteArray[i];
//         }
//       }
//       console.log("onload");
//       resolve();
//     };

//     xhr.send();

//     ah = al = bh = bl = 0;
//     ch = cl = dh = dl = 0;
//     si = 0;
//     di = 0;
//     cs = 0x0038;
//     ss = 0x0be4;
//     sp = 0x0000;
//     halt = false;
//   })
// }


