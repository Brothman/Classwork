/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./src/asteroids/asteroids.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./src/asteroids/asteroid.js":
/*!***********************************!*\
  !*** ./src/asteroids/asteroid.js ***!
  \***********************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("const Util = __webpack_require__(/*! ./utils.js */ \"./src/asteroids/utils.js\");\nconst MovingObject = __webpack_require__(/*! ./moving_object.js */ \"./src/asteroids/moving_object.js\");\n\n\nfunction Asteroid(options) {\n  this.COLOR = \"#FF0000\";\n  this.RADIUS = 22;\n  options.color = this.COLOR;\n  options.radius = this.RADIUS;\n  options.velocity = Util.randomVec(5);\n  MovingObject.call(this, options);\n}\n\nUtil.inherits(Asteroid, MovingObject);\nmodule.exports = Asteroid;\n// function Asteroid() {\n//\n// }\n\n\n//# sourceURL=webpack:///./src/asteroids/asteroid.js?");

/***/ }),

/***/ "./src/asteroids/asteroids.js":
/*!************************************!*\
  !*** ./src/asteroids/asteroids.js ***!
  \************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("const Asteroid = __webpack_require__(/*! ./asteroid.js */ \"./src/asteroids/asteroid.js\");\nwindow.Asteroid = Asteroid;\n\nconst Game = __webpack_require__(/*! ./game.js */ \"./src/asteroids/game.js\");\nwindow.Game = Game;\n\nconsole.log(\"Webpack is working\");\n\n\n//# sourceURL=webpack:///./src/asteroids/asteroids.js?");

/***/ }),

/***/ "./src/asteroids/game.js":
/*!*******************************!*\
  !*** ./src/asteroids/game.js ***!
  \*******************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("const Asteroid = __webpack_require__(/*! ./asteroid.js */ \"./src/asteroids/asteroid.js\");\n\nfunction Game() {\n  this.DIM_X = 500;\n  this.DIM_Y = 500;\n  this.NUM_ASTEROIDS = 4;\n  this.asteroids = [new Asteroid({pos: randomPos()})];\n\n  this.ctx = document.getElementsByTagName(\"canvas\")[0].getContext(\"2d\");\n\n  addAsteroids();\n}\n\nfunction addAsteroids() {\n  for (var i = 0; i < this.NUM_ASTEROIDS; i++) {\n    this.asteroids.push(new Asteroid({pos: randomPos()}));\n  }\n}\n\nfunction randomPos() {\n  return [Math.random() * this.DIM_X, Math.random() * this.DIM_Y];\n}\n\nGame.prototype.draw = function(ctx) {\n  this.ctx.clearRect(0, 0, this.DIM_X, this.DIM_Y);\n  for (var i = 0; i < this.asteroids.length; i++) {\n    this.asteroids[i].draw(this.ctx);\n  }\n};\n\nGame.prototype.moveObjects = function() {\n  for (var i = 0; i < this.asteroids.length; i++) {\n    this.asteroids[i].move();\n  }\n};\n\n// const g = new Game();\n//\n// setInterval(g.draw, 20);\n// setInterval(g.moveObjects, 20);\nmodule.exports = Game;\n\n\n//# sourceURL=webpack:///./src/asteroids/game.js?");

/***/ }),

/***/ "./src/asteroids/moving_object.js":
/*!****************************************!*\
  !*** ./src/asteroids/moving_object.js ***!
  \****************************************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("\nfunction MovingObject(options) {\n  this.pos = options.pos;\n  this.velocity = options.velocity;\n  this.radius = options.radius;\n  this.color = options.color;\n}\n// //\n// const canvasEl = document.getElementsByTagName(\"canvas\")[0];\n// const ctx = canvasEl.getContext(\"2d\");\n// ctx.clearRect(0, 0, canvas.width, canvas.height);\n// canvasEl.height = window.innerHeight;\n// canvasEl.width = window.innerWidth;\n\nMovingObject.prototype.draw = function(ctx) {\n  ctx.fillStyle = this.color;\n  ctx.beginPath();\n\n  ctx.arc(\n    this.pos[0],\n    this.pos[1],\n    this.radius,\n    0,\n    2 * Math.PI,\n    false\n  );\n\n  ctx.fill();\n};\n\n\nMovingObject.prototype.move = function() {\n  this.pos[0] += this.velocity[0];\n  this.pos[1] += this.velocity[1];\n};\n\nmodule.exports = MovingObject;\n\n\n//# sourceURL=webpack:///./src/asteroids/moving_object.js?");

/***/ }),

/***/ "./src/asteroids/utils.js":
/*!********************************!*\
  !*** ./src/asteroids/utils.js ***!
  \********************************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("\nconst Util = {\n  inherits: function(childClass, parentClass) {\n    childClass.prototype = Object.create(parentClass.prototype);\n    childClass.prototype.constructor = childClass;\n  },\n  randomVec: function(length) {\n    const deg = 2 * Math.PI * Math.random();\n    return Util.scale([Math.sin(deg), Math.cos(deg)], length);\n  },\n  scale: function(vec, m) {\n    return [vec[0] * m, vec[1] * m];\n  }\n};\n\n\nmodule.exports = Util;\n\n\n//# sourceURL=webpack:///./src/asteroids/utils.js?");

/***/ })

/******/ });