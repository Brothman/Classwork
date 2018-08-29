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
/******/ 	return __webpack_require__(__webpack_require__.s = "./frontend/twitter.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./frontend/api_util.js":
/*!******************************!*\
  !*** ./frontend/api_util.js ***!
  \******************************/
/*! no static exports found */
/***/ (function(module, exports) {

const APIUtil = {
  followUser: (id) => {
    return $.ajax({
      method: 'POST',
      url: `/users/${id}/follow`,
      data: {user_id: id},
      dataType: 'json'
    });
  },

  unFollowUser: (id) => {
    return $.ajax({
      method: 'DELETE',
      url: `/users/${id}/follow`,
      dataType: 'json'
    });
  },

  searchUsers: (queryVal, successCallback) => {
     $.ajax({
      method: 'GET',
      url: '/users/search',
      dataType: 'json',
      data: {query: queryVal}
    }).then(successCallback);
  }
};

module.exports = APIUtil;


/***/ }),

/***/ "./frontend/follow_toggle.js":
/*!***********************************!*\
  !*** ./frontend/follow_toggle.js ***!
  \***********************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__ (/*! ./api_util.js */ "./frontend/api_util.js");

class FollowToggle {
  constructor(el) {
    this.$el = $(el);
    this.userId = this.$el.data('user-id');
    this.followState = this.$el.data('initial-follow-state');
    this.render();
  }

  render() {
    if (this.followState === 'following' || this.followState === 'unfollowing') {
      this.$el.prop('disabled', true);
    }
    else {
      this.$el.prop('disabled', false);
      if (this.followState === 'followed'){
          this.$el.text('Unfollow!');
        } else {
          this.$el.text('Follow!');
        }
      }
    }

  toggleState() {
    this.followState = ((this.followState === 'unfollowing') ? 'unfollowed' : 'followed');
    this.render();
  }

  handleClick() {
    event.preventDefault();

    if (this.followState === 'followed') {
      this.followState = 'unfollowing';
      this.render();
      APIUtil.unFollowUser(this.userId).then(this.toggleState.bind(this));
    }
    else {
      this.followState = 'following';
      this.render();
      APIUtil.followUser(this.userId).then(this.toggleState.bind(this));
    }
  }
}

module.exports = FollowToggle;


/***/ }),

/***/ "./frontend/twitter.js":
/*!*****************************!*\
  !*** ./frontend/twitter.js ***!
  \*****************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

const FollowToggle = __webpack_require__(/*! ./follow_toggle.js */ "./frontend/follow_toggle.js");
const UserSearch = __webpack_require__(/*! ./users_search.js */ "./frontend/users_search.js");

$( () => {
  $('.follow-toggle').each( (index, button) => {
    const followToggle = new FollowToggle(button);
    $(button).on('click', followToggle.handleClick.bind(followToggle));
  });

  const $nav = $('nav');
  // $('nav').children('input').on('change', () => {
  //   const userSearch = new UserSearch($nav);
  //   userSearch.handleInput();
  // });
  $nav.keyup( () => {
    const userSearch = new UserSearch($nav);
    userSearch.handleInput();
  });
});


/***/ }),

/***/ "./frontend/users_search.js":
/*!**********************************!*\
  !*** ./frontend/users_search.js ***!
  \**********************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(/*! ./api_util.js */ "./frontend/api_util.js");
const FollowToggle = __webpack_require__(/*! ./follow_toggle.js */ "./frontend/follow_toggle.js");

class UsersSearch {
  constructor($el) {
    this.$el = $el;
    this.$input = $el.children('input');
    this.$ul = $el.children('ul');
  }

  handleInput() {
    //pass in success callback
    return APIUtil.searchUsers(this.$input.val(), this.renderResults.bind(this));
  }

  renderResults(fetchedUsers) {
    this.$ul.empty();

    for (var i = 0; i < fetchedUsers.length; i++) {
      const $button = $('<button>');
      $button.data('user-id', fetchedUsers[i].id);
      $button.addClass('follow-toggle');
      if (fetchedUsers[i].followed) {
        $button.data('initial-followed-state', 'followed');
      }
      else {
        $button.data('initial-followed-state', 'unfollowed');
      }

      const followToggle = new FollowToggle($button[0]);
      $button.on('click', followToggle.handleClick.bind(followToggle));

      const $li = $('<li>');
      const $a = $('<a>');
      $a.prop('href', `${fetchedUsers[i].id}`);
      $a.text(fetchedUsers[i].username);
      $li.append($a);
      $li.append($button);
      this.$ul.append($li);
    }
  }
}

// export default UsersSearch;
module.exports = UsersSearch;


/***/ })

/******/ });
//# sourceMappingURL=bundle.js.map