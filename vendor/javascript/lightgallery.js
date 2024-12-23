/*!
 * lightgallery | 2.7.2 | September 20th 2023
 * http://www.lightgalleryjs.com/
 * Copyright (c) 2020 Sachin Neravath;
 * @license GPLv3
 */
var __assign = function () {
  __assign =
    Object.assign ||
    function __assign(t) {
      for (var e, i = 1, s = arguments.length; i < s; i++) {
        e = arguments[i];
        for (var r in e) Object.prototype.hasOwnProperty.call(e, r) && (t[r] = e[r]);
      }
      return t;
    };
  return __assign.apply(this, arguments);
};
function __spreadArrays() {
  for (var t = 0, e = 0, i = arguments.length; e < i; e++) t += arguments[e].length;
  var s = Array(t),
    r = 0;
  for (e = 0; e < i; e++)
    for (var l = arguments[e], o = 0, n = l.length; o < n; o++, r++) s[r] = l[o];
  return s;
}
var t = {
  afterAppendSlide: 'lgAfterAppendSlide',
  init: 'lgInit',
  hasVideo: 'lgHasVideo',
  containerResize: 'lgContainerResize',
  updateSlides: 'lgUpdateSlides',
  afterAppendSubHtml: 'lgAfterAppendSubHtml',
  beforeOpen: 'lgBeforeOpen',
  afterOpen: 'lgAfterOpen',
  slideItemLoad: 'lgSlideItemLoad',
  beforeSlide: 'lgBeforeSlide',
  afterSlide: 'lgAfterSlide',
  posterClick: 'lgPosterClick',
  dragStart: 'lgDragStart',
  dragMove: 'lgDragMove',
  dragEnd: 'lgDragEnd',
  beforeNextSlide: 'lgBeforeNextSlide',
  beforePrevSlide: 'lgBeforePrevSlide',
  beforeClose: 'lgBeforeClose',
  afterClose: 'lgAfterClose',
  rotateLeft: 'lgRotateLeft',
  rotateRight: 'lgRotateRight',
  flipHorizontal: 'lgFlipHorizontal',
  flipVertical: 'lgFlipVertical',
  autoplay: 'lgAutoplay',
  autoplayStart: 'lgAutoplayStart',
  autoplayStop: 'lgAutoplayStop',
};
var e = {
  mode: 'lg-slide',
  easing: 'ease',
  speed: 400,
  licenseKey: '0000-0000-000-1111',
  height: '100%',
  width: '100%',
  addClass: '',
  startClass: 'lg-start-zoom',
  backdropDuration: 300,
  container: '',
  startAnimationDuration: 400,
  zoomFromOrigin: true,
  hideBarsDelay: 0,
  showBarsAfter: 1e4,
  slideDelay: 0,
  supportLegacyBrowser: true,
  allowMediaOverlap: false,
  videoMaxSize: '1280-720',
  loadYouTubePoster: true,
  defaultCaptionHeight: 0,
  ariaLabelledby: '',
  ariaDescribedby: '',
  resetScrollPosition: true,
  hideScrollbar: false,
  closable: true,
  swipeToClose: true,
  closeOnTap: true,
  showCloseIcon: true,
  showMaximizeIcon: false,
  loop: true,
  escKey: true,
  keyPress: true,
  trapFocus: true,
  controls: true,
  slideEndAnimation: true,
  hideControlOnEnd: false,
  mousewheel: false,
  getCaptionFromTitleOrAlt: true,
  appendSubHtmlTo: '.lg-sub-html',
  subHtmlSelectorRelative: false,
  preload: 2,
  numberOfSlideItemsInDom: 10,
  selector: '',
  selectWithin: '',
  nextHtml: '',
  prevHtml: '',
  index: 0,
  iframeWidth: '100%',
  iframeHeight: '100%',
  iframeMaxWidth: '100%',
  iframeMaxHeight: '100%',
  download: true,
  counter: true,
  appendCounterTo: '.lg-toolbar',
  swipeThreshold: 50,
  enableSwipe: true,
  enableDrag: true,
  dynamic: false,
  dynamicEl: [],
  extraProps: [],
  exThumbImage: '',
  isMobile: void 0,
  mobileSettings: { controls: false, showCloseIcon: false, download: false },
  plugins: [],
  strings: {
    closeGallery: 'Close gallery',
    toggleMaximize: 'Toggle maximize',
    previousSlide: 'Previous slide',
    nextSlide: 'Next slide',
    download: 'Download',
    playVideo: 'Play video',
    mediaLoadingFailed: 'Oops... Failed to load content...',
  },
};
function initLgPolyfills() {
  (function () {
    if ('function' === typeof window.CustomEvent) return false;
    function CustomEvent(t, e) {
      e = e || { bubbles: false, cancelable: false, detail: null };
      var i = document.createEvent('CustomEvent');
      i.initCustomEvent(t, e.bubbles, e.cancelable, e.detail);
      return i;
    }
    window.CustomEvent = CustomEvent;
  })();
  (function () {
    Element.prototype.matches ||
      (Element.prototype.matches =
        Element.prototype.msMatchesSelector || Element.prototype.webkitMatchesSelector);
  })();
}
var i = (function () {
  function lgQuery(t) {
    this.cssVenderPrefixes = [
      'TransitionDuration',
      'TransitionTimingFunction',
      'Transform',
      'Transition',
    ];
    this.selector = this._getSelector(t);
    this.firstElement = this._getFirstEl();
    return this;
  }
  lgQuery.generateUUID = function () {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (t) {
      var e = (16 * Math.random()) | 0,
        i = 'x' == t ? e : (3 & e) | 8;
      return i.toString(16);
    });
  };
  lgQuery.prototype._getSelector = function (t, e) {
    void 0 === e && (e = document);
    if ('string' !== typeof t) return t;
    e = e || document;
    var i = t.substring(0, 1);
    return '#' === i ? e.querySelector(t) : e.querySelectorAll(t);
  };
  lgQuery.prototype._each = function (t) {
    if (!this.selector) return this;
    void 0 !== this.selector.length ? [].forEach.call(this.selector, t) : t(this.selector, 0);
    return this;
  };
  lgQuery.prototype._setCssVendorPrefix = function (t, e, i) {
    var s = e.replace(/-([a-z])/gi, function (t, e) {
      return e.toUpperCase();
    });
    if (-1 !== this.cssVenderPrefixes.indexOf(s)) {
      t.style[s.charAt(0).toLowerCase() + s.slice(1)] = i;
      t.style['webkit' + s] = i;
      t.style['moz' + s] = i;
      t.style['ms' + s] = i;
      t.style['o' + s] = i;
    } else t.style[s] = i;
  };
  lgQuery.prototype._getFirstEl = function () {
    return this.selector && void 0 !== this.selector.length ? this.selector[0] : this.selector;
  };
  lgQuery.prototype.isEventMatched = function (t, e) {
    var i = e.split('.');
    return t
      .split('.')
      .filter(function (t) {
        return t;
      })
      .every(function (t) {
        return -1 !== i.indexOf(t);
      });
  };
  lgQuery.prototype.attr = function (t, e) {
    if (void 0 === e) return this.firstElement ? this.firstElement.getAttribute(t) : '';
    this._each(function (i) {
      i.setAttribute(t, e);
    });
    return this;
  };
  lgQuery.prototype.find = function (t) {
    return $LG(this._getSelector(t, this.selector));
  };
  lgQuery.prototype.first = function () {
    return this.selector && void 0 !== this.selector.length
      ? $LG(this.selector[0])
      : $LG(this.selector);
  };
  lgQuery.prototype.eq = function (t) {
    return $LG(this.selector[t]);
  };
  lgQuery.prototype.parent = function () {
    return $LG(this.selector.parentElement);
  };
  lgQuery.prototype.get = function () {
    return this._getFirstEl();
  };
  lgQuery.prototype.removeAttr = function (t) {
    var e = t.split(' ');
    this._each(function (t) {
      e.forEach(function (e) {
        return t.removeAttribute(e);
      });
    });
    return this;
  };
  lgQuery.prototype.wrap = function (t) {
    if (!this.firstElement) return this;
    var e = document.createElement('div');
    e.className = t;
    this.firstElement.parentNode.insertBefore(e, this.firstElement);
    this.firstElement.parentNode.removeChild(this.firstElement);
    e.appendChild(this.firstElement);
    return this;
  };
  lgQuery.prototype.addClass = function (t) {
    void 0 === t && (t = '');
    this._each(function (e) {
      t.split(' ').forEach(function (t) {
        t && e.classList.add(t);
      });
    });
    return this;
  };
  lgQuery.prototype.removeClass = function (t) {
    this._each(function (e) {
      t.split(' ').forEach(function (t) {
        t && e.classList.remove(t);
      });
    });
    return this;
  };
  lgQuery.prototype.hasClass = function (t) {
    return !!this.firstElement && this.firstElement.classList.contains(t);
  };
  lgQuery.prototype.hasAttribute = function (t) {
    return !!this.firstElement && this.firstElement.hasAttribute(t);
  };
  lgQuery.prototype.toggleClass = function (t) {
    if (!this.firstElement) return this;
    this.hasClass(t) ? this.removeClass(t) : this.addClass(t);
    return this;
  };
  lgQuery.prototype.css = function (t, e) {
    var i = this;
    this._each(function (s) {
      i._setCssVendorPrefix(s, t, e);
    });
    return this;
  };
  lgQuery.prototype.on = function (t, e) {
    var i = this;
    if (!this.selector) return this;
    t.split(' ').forEach(function (t) {
      Array.isArray(lgQuery.eventListeners[t]) || (lgQuery.eventListeners[t] = []);
      lgQuery.eventListeners[t].push(e);
      i.selector.addEventListener(t.split('.')[0], e);
    });
    return this;
  };
  lgQuery.prototype.once = function (t, e) {
    var i = this;
    this.on(t, function () {
      i.off(t);
      e(t);
    });
    return this;
  };
  lgQuery.prototype.off = function (t) {
    var e = this;
    if (!this.selector) return this;
    Object.keys(lgQuery.eventListeners).forEach(function (i) {
      if (e.isEventMatched(t, i)) {
        lgQuery.eventListeners[i].forEach(function (t) {
          e.selector.removeEventListener(i.split('.')[0], t);
        });
        lgQuery.eventListeners[i] = [];
      }
    });
    return this;
  };
  lgQuery.prototype.trigger = function (t, e) {
    if (!this.firstElement) return this;
    var i = new CustomEvent(t.split('.')[0], { detail: e || null });
    this.firstElement.dispatchEvent(i);
    return this;
  };
  lgQuery.prototype.load = function (t) {
    var e = this;
    fetch(t)
      .then(function (t) {
        return t.text();
      })
      .then(function (t) {
        e.selector.innerHTML = t;
      });
    return this;
  };
  lgQuery.prototype.html = function (t) {
    if (void 0 === t) return this.firstElement ? this.firstElement.innerHTML : '';
    this._each(function (e) {
      e.innerHTML = t;
    });
    return this;
  };
  lgQuery.prototype.append = function (t) {
    this._each(function (e) {
      'string' === typeof t ? e.insertAdjacentHTML('beforeend', t) : e.appendChild(t);
    });
    return this;
  };
  lgQuery.prototype.prepend = function (t) {
    this._each(function (e) {
      e.insertAdjacentHTML('afterbegin', t);
    });
    return this;
  };
  lgQuery.prototype.remove = function () {
    this._each(function (t) {
      t.parentNode.removeChild(t);
    });
    return this;
  };
  lgQuery.prototype.empty = function () {
    this._each(function (t) {
      t.innerHTML = '';
    });
    return this;
  };
  lgQuery.prototype.scrollTop = function (t) {
    if (void 0 !== t) {
      document.body.scrollTop = t;
      document.documentElement.scrollTop = t;
      return this;
    }
    return window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop || 0;
  };
  lgQuery.prototype.scrollLeft = function (t) {
    if (void 0 !== t) {
      document.body.scrollLeft = t;
      document.documentElement.scrollLeft = t;
      return this;
    }
    return (
      window.pageXOffset || document.documentElement.scrollLeft || document.body.scrollLeft || 0
    );
  };
  lgQuery.prototype.offset = function () {
    if (!this.firstElement) return { left: 0, top: 0 };
    var t = this.firstElement.getBoundingClientRect();
    var e = $LG('body').style().marginLeft;
    return { left: t.left - parseFloat(e) + this.scrollLeft(), top: t.top + this.scrollTop() };
  };
  lgQuery.prototype.style = function () {
    return this.firstElement
      ? this.firstElement.currentStyle || window.getComputedStyle(this.firstElement)
      : {};
  };
  lgQuery.prototype.width = function () {
    var t = this.style();
    return this.firstElement.clientWidth - parseFloat(t.paddingLeft) - parseFloat(t.paddingRight);
  };
  lgQuery.prototype.height = function () {
    var t = this.style();
    return this.firstElement.clientHeight - parseFloat(t.paddingTop) - parseFloat(t.paddingBottom);
  };
  lgQuery.eventListeners = {};
  return lgQuery;
})();
function $LG(t) {
  initLgPolyfills();
  return new i(t);
}
var s = [
  'src',
  'sources',
  'subHtml',
  'subHtmlUrl',
  'html',
  'video',
  'poster',
  'slideName',
  'responsive',
  'srcset',
  'sizes',
  'iframe',
  'downloadUrl',
  'download',
  'width',
  'facebookShareUrl',
  'tweetText',
  'iframeTitle',
  'twitterShareUrl',
  'pinterestShareUrl',
  'pinterestText',
  'fbHtml',
  'disqusIdentifier',
  'disqusUrl',
];
function convertToData(t) {
  if ('href' === t) return 'src';
  t = t.replace('data-', '');
  t = t.charAt(0).toLowerCase() + t.slice(1);
  t = t.replace(/-([a-z])/g, function (t) {
    return t[1].toUpperCase();
  });
  return t;
}
var r = {
  getSize: function (t, e, i, s) {
    void 0 === i && (i = 0);
    var r = $LG(t);
    var l = r.attr('data-lg-size') || s;
    if (l) {
      var o = l.split(',');
      if (o[1]) {
        var n = window.innerWidth;
        for (var a = 0; a < o.length; a++) {
          var g = o[a];
          var d = parseInt(g.split('-')[2], 10);
          if (d > n) {
            l = g;
            break;
          }
          a === o.length - 1 && (l = g);
        }
      }
      var h = l.split('-');
      var u = parseInt(h[0], 10);
      var c = parseInt(h[1], 10);
      var m = e.width();
      var p = e.height() - i;
      var f = Math.min(m, u);
      var y = Math.min(p, c);
      var v = Math.min(f / u, y / c);
      return { width: u * v, height: c * v };
    }
  },
  /**
   * @desc Get transform value based on the imageSize. Used for ZoomFromOrigin option
   * @param {jQuery Element}
   * @returns {String} Transform CSS string
   */
  getTransform: function (t, e, i, s, r) {
    if (r) {
      var l = $LG(t).find('img').first();
      if (l.get()) {
        var o = e.get().getBoundingClientRect();
        var n = o.width;
        var a = e.height() - (i + s);
        var g = l.width();
        var d = l.height();
        var h = l.style();
        var u =
          (n - g) / 2 -
          l.offset().left +
          (parseFloat(h.paddingLeft) || 0) +
          (parseFloat(h.borderLeft) || 0) +
          $LG(window).scrollLeft() +
          o.left;
        var c =
          (a - d) / 2 -
          l.offset().top +
          (parseFloat(h.paddingTop) || 0) +
          (parseFloat(h.borderTop) || 0) +
          $LG(window).scrollTop() +
          i;
        var m = g / r.width;
        var p = d / r.height;
        var f =
          'translate3d(' +
          (u *= -1) +
          'px, ' +
          (c *= -1) +
          'px, 0) scale3d(' +
          m +
          ', ' +
          p +
          ', 1)';
        return f;
      }
    }
  },
  getIframeMarkup: function (t, e, i, s, r, l) {
    var o = l ? 'title="' + l + '"' : '';
    return (
      '<div class="lg-video-cont lg-has-iframe" style="width:' +
      t +
      '; max-width:' +
      i +
      '; height: ' +
      e +
      '; max-height:' +
      s +
      '">\n                    <iframe class="lg-object" frameborder="0" ' +
      o +
      ' src="' +
      r +
      '"  allowfullscreen="true"></iframe>\n                </div>'
    );
  },
  getImgMarkup: function (t, e, i, s, r, l) {
    var o = s ? 'srcset="' + s + '"' : '';
    var n = r ? 'sizes="' + r + '"' : '';
    var a =
      '<img ' +
      i +
      ' ' +
      o +
      '  ' +
      n +
      ' class="lg-object lg-image" data-index="' +
      t +
      '" src="' +
      e +
      '" />';
    var g = '';
    if (l) {
      var d = 'string' === typeof l ? JSON.parse(l) : l;
      g = d.map(function (t) {
        var e = '';
        Object.keys(t).forEach(function (i) {
          e += ' ' + i + '="' + t[i] + '"';
        });
        return '<source ' + e + '></source>';
      });
    }
    return '' + g + a;
  },
  getResponsiveSrc: function (t) {
    var e = [];
    var i = [];
    var s = '';
    for (var r = 0; r < t.length; r++) {
      var l = t[r].split(' ');
      '' === l[0] && l.splice(0, 1);
      i.push(l[0]);
      e.push(l[1]);
    }
    var o = window.innerWidth;
    for (var n = 0; n < e.length; n++)
      if (parseInt(e[n], 10) > o) {
        s = i[n];
        break;
      }
    return s;
  },
  isImageLoaded: function (t) {
    return !!t && !!t.complete && 0 !== t.naturalWidth;
  },
  getVideoPosterMarkup: function (t, e, i, s, r) {
    var l = '';
    l = r && r.youtube ? 'lg-has-youtube' : r && r.vimeo ? 'lg-has-vimeo' : 'lg-has-html5';
    return (
      '<div class="lg-video-cont ' +
      l +
      '" style="' +
      i +
      '">\n                <div class="lg-video-play-button">\n                <svg\n                    viewBox="0 0 20 20"\n                    preserveAspectRatio="xMidYMid"\n                    focusable="false"\n                    aria-labelledby="' +
      s +
      '"\n                    role="img"\n                    class="lg-video-play-icon"\n                >\n                    <title>' +
      s +
      '</title>\n                    <polygon class="lg-video-play-icon-inner" points="1,0 20,10 1,20"></polygon>\n                </svg>\n                <svg class="lg-video-play-icon-bg" viewBox="0 0 50 50" focusable="false">\n                    <circle cx="50%" cy="50%" r="20"></circle></svg>\n                <svg class="lg-video-play-icon-circle" viewBox="0 0 50 50" focusable="false">\n                    <circle cx="50%" cy="50%" r="20"></circle>\n                </svg>\n            </div>\n            ' +
      (e || '') +
      '\n            <img class="lg-object lg-video-poster" src="' +
      t +
      '" />\n        </div>'
    );
  },
  getFocusableElements: function (t) {
    var e = t.querySelectorAll(
      'a[href]:not([disabled]), button:not([disabled]), textarea:not([disabled]), input[type="text"]:not([disabled]), input[type="radio"]:not([disabled]), input[type="checkbox"]:not([disabled]), select:not([disabled])'
    );
    var i = [].filter.call(e, function (t) {
      var e = window.getComputedStyle(t);
      return 'none' !== e.display && 'hidden' !== e.visibility;
    });
    return i;
  },
  /**
   * @desc Create dynamic elements array from gallery items when dynamic option is false
   * It helps to avoid frequent DOM interaction
   * and avoid multiple checks for dynamic elments
   *
   * @returns {Array} dynamicEl
   */
  getDynamicOptions: function (t, e, i, r) {
    var l = [];
    var o = __spreadArrays(s, e);
    [].forEach.call(t, function (t) {
      var e = {};
      for (var s = 0; s < t.attributes.length; s++) {
        var n = t.attributes[s];
        if (n.specified) {
          var a = convertToData(n.name);
          var g = '';
          o.indexOf(a) > -1 && (g = a);
          g && (e[g] = n.value);
        }
      }
      var d = $LG(t);
      var h = d.find('img').first().attr('alt');
      var u = d.attr('title');
      var c = r ? d.attr(r) : d.find('img').first().attr('src');
      e.thumb = c;
      i && !e.subHtml && (e.subHtml = u || h || '');
      e.alt = h || u || '';
      l.push(e);
    });
    return l;
  },
  isMobile: function () {
    return /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);
  },
  /**
   * @desc Check the given src is video
   * @param {String} src
   * @return {Object} video type
   * Ex:{ youtube  :  ["//www.youtube.com/watch?v=c0asJgSyxcY", "c0asJgSyxcY"] }
   *
   * @todo - this information can be moved to dynamicEl to avoid frequent calls
   */
  isVideo: function (t, e, i) {
    if (t) {
      var s = t.match(
        /\/\/(?:www\.)?youtu(?:\.be|be\.com|be-nocookie\.com)\/(?:watch\?v=|embed\/)?([a-z0-9\-\_\%]+)([\&|?][\S]*)*/i
      );
      var r = t.match(/\/\/(?:www\.)?(?:player\.)?vimeo.com\/(?:video\/)?([0-9a-z\-_]+)(.*)?/i);
      var l = t.match(/https?:\/\/(.+)?(wistia\.com|wi\.st)\/(medias|embed)\/([0-9a-z\-_]+)(.*)/);
      return s ? { youtube: s } : r ? { vimeo: r } : l ? { wistia: l } : void 0;
    }
    if (e) return { html5: true };
    console.error(
      'lightGallery :- data-src is not provided on slide item ' +
        (i + 1) +
        '. Please make sure the selector property is properly configured. More info - https://www.lightgalleryjs.com/demos/html-markup/'
    );
  },
};
var l = 0;
var o = (function () {
  function LightGallery(t, e) {
    this.lgOpened = false;
    this.index = 0;
    this.plugins = [];
    this.lGalleryOn = false;
    this.lgBusy = false;
    this.currentItemsInDom = [];
    this.prevScrollTop = 0;
    this.bodyPaddingRight = 0;
    this.isDummyImageRemoved = false;
    this.dragOrSwipeEnabled = false;
    this.mediaContainerPosition = { top: 0, bottom: 0 };
    if (!t) return this;
    l++;
    this.lgId = l;
    this.el = t;
    this.LGel = $LG(t);
    this.generateSettings(e);
    this.buildModules();
    if (
      this.settings.dynamic &&
      void 0 !== this.settings.dynamicEl &&
      !Array.isArray(this.settings.dynamicEl)
    )
      throw 'When using dynamic mode, you must also define dynamicEl as an Array.';
    this.galleryItems = this.getItems();
    this.normalizeSettings();
    this.init();
    this.validateLicense();
    return this;
  }
  LightGallery.prototype.generateSettings = function (t) {
    this.settings = __assign(__assign({}, e), t);
    if (
      this.settings.isMobile && 'function' === typeof this.settings.isMobile
        ? this.settings.isMobile()
        : r.isMobile()
    ) {
      var i = __assign(__assign({}, this.settings.mobileSettings), this.settings.mobileSettings);
      this.settings = __assign(__assign({}, this.settings), i);
    }
  };
  LightGallery.prototype.normalizeSettings = function () {
    this.settings.slideEndAnimation && (this.settings.hideControlOnEnd = false);
    this.settings.closable || (this.settings.swipeToClose = false);
    this.zoomFromOrigin = this.settings.zoomFromOrigin;
    this.settings.dynamic && (this.zoomFromOrigin = false);
    this.settings.container || (this.settings.container = document.body);
    this.settings.preload = Math.min(this.settings.preload, this.galleryItems.length);
  };
  LightGallery.prototype.init = function () {
    var e = this;
    this.addSlideVideoInfo(this.galleryItems);
    this.buildStructure();
    this.LGel.trigger(t.init, { instance: this });
    this.settings.keyPress && this.keyPress();
    setTimeout(function () {
      e.enableDrag();
      e.enableSwipe();
      e.triggerPosterClick();
    }, 50);
    this.arrow();
    this.settings.mousewheel && this.mousewheel();
    this.settings.dynamic || this.openGalleryOnItemClick();
  };
  LightGallery.prototype.openGalleryOnItemClick = function () {
    var t = this;
    var _loop_1 = function (s) {
      var r = e.items[s];
      var l = $LG(r);
      var o = i.generateUUID();
      l.attr('data-lg-id', o).on('click.lgcustom-item-' + o, function (e) {
        e.preventDefault();
        var i = t.settings.index || s;
        t.openGallery(i, r);
      });
    };
    var e = this;
    for (var s = 0; s < this.items.length; s++) _loop_1(s);
  };
  LightGallery.prototype.buildModules = function () {
    var t = this;
    this.settings.plugins.forEach(function (e) {
      t.plugins.push(new e(t, $LG));
    });
  };
  LightGallery.prototype.validateLicense = function () {
    this.settings.licenseKey
      ? '0000-0000-000-0000' === this.settings.licenseKey &&
        console.warn(
          'lightGallery: ' +
            this.settings.licenseKey +
            ' license key is not valid for production use'
        )
      : console.error('Please provide a valid license key');
  };
  LightGallery.prototype.getSlideItem = function (t) {
    return $LG(this.getSlideItemId(t));
  };
  LightGallery.prototype.getSlideItemId = function (t) {
    return '#lg-item-' + this.lgId + '-' + t;
  };
  LightGallery.prototype.getIdName = function (t) {
    return t + '-' + this.lgId;
  };
  LightGallery.prototype.getElementById = function (t) {
    return $LG('#' + this.getIdName(t));
  };
  LightGallery.prototype.manageSingleSlideClassName = function () {
    this.galleryItems.length < 2
      ? this.outer.addClass('lg-single-item')
      : this.outer.removeClass('lg-single-item');
  };
  LightGallery.prototype.buildStructure = function () {
    var t = this;
    var e = this.$container && this.$container.get();
    if (!e) {
      var i = '';
      var s = '';
      this.settings.controls &&
        (i =
          '<button type="button" id="' +
          this.getIdName('lg-prev') +
          '" aria-label="' +
          this.settings.strings.previousSlide +
          '" class="lg-prev lg-icon"> ' +
          this.settings.prevHtml +
          ' </button>\n                <button type="button" id="' +
          this.getIdName('lg-next') +
          '" aria-label="' +
          this.settings.strings.nextSlide +
          '" class="lg-next lg-icon"> ' +
          this.settings.nextHtml +
          ' </button>');
      '.lg-item' !== this.settings.appendSubHtmlTo &&
        (s = '<div class="lg-sub-html" role="status" aria-live="polite"></div>');
      var r = '';
      this.settings.allowMediaOverlap && (r += 'lg-media-overlap ');
      var l = this.settings.ariaLabelledby
        ? 'aria-labelledby="' + this.settings.ariaLabelledby + '"'
        : '';
      var o = this.settings.ariaDescribedby
        ? 'aria-describedby="' + this.settings.ariaDescribedby + '"'
        : '';
      var n =
        'lg-container ' +
        this.settings.addClass +
        ' ' +
        (document.body !== this.settings.container ? 'lg-inline' : '');
      var a =
        this.settings.closable && this.settings.showCloseIcon
          ? '<button type="button" aria-label="' +
            this.settings.strings.closeGallery +
            '" id="' +
            this.getIdName('lg-close') +
            '" class="lg-close lg-icon"></button>'
          : '';
      var g = this.settings.showMaximizeIcon
        ? '<button type="button" aria-label="' +
          this.settings.strings.toggleMaximize +
          '" id="' +
          this.getIdName('lg-maximize') +
          '" class="lg-maximize lg-icon"></button>'
        : '';
      var d =
        '\n        <div class="' +
        n +
        '" id="' +
        this.getIdName('lg-container') +
        '" tabindex="-1" aria-modal="true" ' +
        l +
        ' ' +
        o +
        ' role="dialog"\n        >\n            <div id="' +
        this.getIdName('lg-backdrop') +
        '" class="lg-backdrop"></div>\n\n            <div id="' +
        this.getIdName('lg-outer') +
        '" class="lg-outer lg-use-css3 lg-css3 lg-hide-items ' +
        r +
        ' ">\n\n              <div id="' +
        this.getIdName('lg-content') +
        '" class="lg-content">\n                <div id="' +
        this.getIdName('lg-inner') +
        '" class="lg-inner">\n                </div>\n                ' +
        i +
        '\n              </div>\n                <div id="' +
        this.getIdName('lg-toolbar') +
        '" class="lg-toolbar lg-group">\n                    ' +
        g +
        '\n                    ' +
        a +
        '\n                    </div>\n                    ' +
        ('.lg-outer' === this.settings.appendSubHtmlTo ? s : '') +
        '\n                <div id="' +
        this.getIdName('lg-components') +
        '" class="lg-components">\n                    ' +
        ('.lg-sub-html' === this.settings.appendSubHtmlTo ? s : '') +
        '\n                </div>\n            </div>\n        </div>\n        ';
      $LG(this.settings.container).append(d);
      document.body !== this.settings.container &&
        $LG(this.settings.container).css('position', 'relative');
      this.outer = this.getElementById('lg-outer');
      this.$lgComponents = this.getElementById('lg-components');
      this.$backdrop = this.getElementById('lg-backdrop');
      this.$container = this.getElementById('lg-container');
      this.$inner = this.getElementById('lg-inner');
      this.$content = this.getElementById('lg-content');
      this.$toolbar = this.getElementById('lg-toolbar');
      this.$backdrop.css('transition-duration', this.settings.backdropDuration + 'ms');
      var h = this.settings.mode + ' ';
      this.manageSingleSlideClassName();
      this.settings.enableDrag && (h += 'lg-grab ');
      this.outer.addClass(h);
      this.$inner.css('transition-timing-function', this.settings.easing);
      this.$inner.css('transition-duration', this.settings.speed + 'ms');
      this.settings.download &&
        this.$toolbar.append(
          '<a id="' +
            this.getIdName('lg-download') +
            '" target="_blank" rel="noopener" aria-label="' +
            this.settings.strings.download +
            '" download class="lg-download lg-icon"></a>'
        );
      this.counter();
      $LG(window).on(
        'resize.lg.global' + this.lgId + ' orientationchange.lg.global' + this.lgId,
        function () {
          t.refreshOnResize();
        }
      );
      this.hideBars();
      this.manageCloseGallery();
      this.toggleMaximize();
      this.initModules();
    }
  };
  LightGallery.prototype.refreshOnResize = function () {
    if (this.lgOpened) {
      var e = this.galleryItems[this.index];
      var i = e.__slideVideoInfo;
      this.mediaContainerPosition = this.getMediaContainerPosition();
      var s = this.mediaContainerPosition,
        l = s.top,
        o = s.bottom;
      this.currentImageSize = r.getSize(
        this.items[this.index],
        this.outer,
        l + o,
        i && this.settings.videoMaxSize
      );
      i && this.resizeVideoSlide(this.index, this.currentImageSize);
      if (this.zoomFromOrigin && !this.isDummyImageRemoved) {
        var n = this.getDummyImgStyles(this.currentImageSize);
        this.outer.find('.lg-current .lg-dummy-img').first().attr('style', n);
      }
      this.LGel.trigger(t.containerResize);
    }
  };
  LightGallery.prototype.resizeVideoSlide = function (t, e) {
    var i = this.getVideoContStyle(e);
    var s = this.getSlideItem(t);
    s.find('.lg-video-cont').attr('style', i);
  };
  /**
   * Update slides dynamically.
   * Add, edit or delete slides dynamically when lightGallery is opened.
   * Modify the current gallery items and pass it via updateSlides method
   * @note
   * - Do not mutate existing lightGallery items directly.
   * - Always pass new list of gallery items
   * - You need to take care of thumbnails outside the gallery if any
   * - user this method only if you want to update slides when the gallery is opened. Otherwise, use `refresh()` method.
   * @param items Gallery items
   * @param index After the update operation, which slide gallery should navigate to
   * @category lGPublicMethods
   * @example
   * const plugin = lightGallery();
   *
   * // Adding slides dynamically
   * let galleryItems = [
   * // Access existing lightGallery items
   * // galleryItems are automatically generated internally from the gallery HTML markup
   * // or directly from galleryItems when dynamic gallery is used
   *   ...plugin.galleryItems,
   *     ...[
   *       {
   *         src: 'img/img-1.png',
   *           thumb: 'img/thumb1.png',
   *         },
   *     ],
   *   ];
   *   plugin.updateSlides(
   *     galleryItems,
   *     plugin.index,
   *   );
   *
   *
   * // Remove slides dynamically
   * galleryItems = JSON.parse(
   *   JSON.stringify(updateSlideInstance.galleryItems),
   * );
   * galleryItems.shift();
   * updateSlideInstance.updateSlides(galleryItems, 1);
   * @see <a href="/demos/update-slides/">Demo</a>
   */ LightGallery.prototype.updateSlides = function (e, i) {
    this.index > e.length - 1 && (this.index = e.length - 1);
    1 === e.length && (this.index = 0);
    if (e.length) {
      var s = this.galleryItems[i].src;
      this.galleryItems = e;
      this.updateControls();
      this.$inner.empty();
      this.currentItemsInDom = [];
      var r = 0;
      this.galleryItems.some(function (t, e) {
        if (t.src === s) {
          r = e;
          return true;
        }
        return false;
      });
      this.currentItemsInDom = this.organizeSlideItems(r, -1);
      this.loadContent(r, true);
      this.getSlideItem(r).addClass('lg-current');
      this.index = r;
      this.updateCurrentCounter(r);
      this.LGel.trigger(t.updateSlides);
    } else this.closeGallery();
  };
  LightGallery.prototype.getItems = function () {
    this.items = [];
    if (this.settings.dynamic) return this.settings.dynamicEl || [];
    if ('this' === this.settings.selector) this.items.push(this.el);
    else if (this.settings.selector)
      if ('string' === typeof this.settings.selector)
        if (this.settings.selectWithin) {
          var t = $LG(this.settings.selectWithin);
          this.items = t.find(this.settings.selector).get();
        } else this.items = this.el.querySelectorAll(this.settings.selector);
      else this.items = this.settings.selector;
    else this.items = this.el.children;
    return r.getDynamicOptions(
      this.items,
      this.settings.extraProps,
      this.settings.getCaptionFromTitleOrAlt,
      this.settings.exThumbImage
    );
  };
  LightGallery.prototype.shouldHideScrollbar = function () {
    return this.settings.hideScrollbar && document.body === this.settings.container;
  };
  LightGallery.prototype.hideScrollbar = function () {
    if (this.shouldHideScrollbar()) {
      this.bodyPaddingRight = parseFloat($LG('body').style().paddingRight);
      var t = document.documentElement.getBoundingClientRect();
      var e = window.innerWidth - t.width;
      $LG(document.body).css('padding-right', e + this.bodyPaddingRight + 'px');
      $LG(document.body).addClass('lg-overlay-open');
    }
  };
  LightGallery.prototype.resetScrollBar = function () {
    if (this.shouldHideScrollbar()) {
      $LG(document.body).css('padding-right', this.bodyPaddingRight + 'px');
      $LG(document.body).removeClass('lg-overlay-open');
    }
  };
  /**
   * Open lightGallery.
   * Open gallery with specific slide by passing index of the slide as parameter.
   * @category lGPublicMethods
   * @param {Number} index  - index of the slide
   * @param {HTMLElement} element - Which image lightGallery should zoom from
   *
   * @example
   * const $dynamicGallery = document.getElementById('dynamic-gallery-demo');
   * const dynamicGallery = lightGallery($dynamicGallery, {
   *     dynamic: true,
   *     dynamicEl: [
   *         {
   *              src: 'img/1.jpg',
   *              thumb: 'img/thumb-1.jpg',
   *              subHtml: '<h4>Image 1 title</h4><p>Image 1 descriptions.</p>',
   *         },
   *         ...
   *     ],
   * });
   * $dynamicGallery.addEventListener('click', function () {
   *     // Starts with third item.(Optional).
   *     // This is useful if you want use dynamic mode with
   *     // custom thumbnails (thumbnails outside gallery),
   *     dynamicGallery.openGallery(2);
   * });
   *
   */ LightGallery.prototype.openGallery = function (e, i) {
    var s = this;
    void 0 === e && (e = this.settings.index);
    if (!this.lgOpened) {
      this.lgOpened = true;
      this.outer.removeClass('lg-hide-items');
      this.hideScrollbar();
      this.$container.addClass('lg-show');
      var l = this.getItemsToBeInsertedToDom(e, e);
      this.currentItemsInDom = l;
      var o = '';
      l.forEach(function (t) {
        o = o + '<div id="' + t + '" class="lg-item"></div>';
      });
      this.$inner.append(o);
      this.addHtml(e);
      var n = '';
      this.mediaContainerPosition = this.getMediaContainerPosition();
      var a = this.mediaContainerPosition,
        g = a.top,
        d = a.bottom;
      this.settings.allowMediaOverlap || this.setMediaContainerPosition(g, d);
      var h = this.galleryItems[e].__slideVideoInfo;
      if (this.zoomFromOrigin && i) {
        this.currentImageSize = r.getSize(i, this.outer, g + d, h && this.settings.videoMaxSize);
        n = r.getTransform(i, this.outer, g, d, this.currentImageSize);
      }
      if (!this.zoomFromOrigin || !n) {
        this.outer.addClass(this.settings.startClass);
        this.getSlideItem(e).removeClass('lg-complete');
      }
      var u = this.settings.zoomFromOrigin ? 100 : this.settings.backdropDuration;
      setTimeout(function () {
        s.outer.addClass('lg-components-open');
      }, u);
      this.index = e;
      this.LGel.trigger(t.beforeOpen);
      this.getSlideItem(e).addClass('lg-current');
      this.lGalleryOn = false;
      this.prevScrollTop = $LG(window).scrollTop();
      setTimeout(function () {
        if (s.zoomFromOrigin && n) {
          var i = s.getSlideItem(e);
          i.css('transform', n);
          setTimeout(function () {
            i.addClass('lg-start-progress lg-start-end-progress').css(
              'transition-duration',
              s.settings.startAnimationDuration + 'ms'
            );
            s.outer.addClass('lg-zoom-from-image');
          });
          setTimeout(function () {
            i.css('transform', 'translate3d(0, 0, 0)');
          }, 100);
        }
        setTimeout(function () {
          s.$backdrop.addClass('in');
          s.$container.addClass('lg-show-in');
        }, 10);
        setTimeout(function () {
          s.settings.trapFocus && document.body === s.settings.container && s.trapFocus();
        }, s.settings.backdropDuration + 50);
        (s.zoomFromOrigin && n) ||
          setTimeout(function () {
            s.outer.addClass('lg-visible');
          }, s.settings.backdropDuration);
        s.slide(e, false, false, false);
        s.LGel.trigger(t.afterOpen);
      });
      document.body === this.settings.container && $LG('html').addClass('lg-on');
    }
  };
  LightGallery.prototype.getMediaContainerPosition = function () {
    if (this.settings.allowMediaOverlap) return { top: 0, bottom: 0 };
    var t = this.$toolbar.get().clientHeight || 0;
    var e = this.outer.find('.lg-components .lg-sub-html').get();
    var i = this.settings.defaultCaptionHeight || (e && e.clientHeight) || 0;
    var s = this.outer.find('.lg-thumb-outer').get();
    var r = s ? s.clientHeight : 0;
    var l = r + i;
    return { top: t, bottom: l };
  };
  LightGallery.prototype.setMediaContainerPosition = function (t, e) {
    void 0 === t && (t = 0);
    void 0 === e && (e = 0);
    this.$content.css('top', t + 'px').css('bottom', e + 'px');
  };
  LightGallery.prototype.hideBars = function () {
    var t = this;
    setTimeout(function () {
      t.outer.removeClass('lg-hide-items');
      if (t.settings.hideBarsDelay > 0) {
        t.outer.on('mousemove.lg click.lg touchstart.lg', function () {
          t.outer.removeClass('lg-hide-items');
          clearTimeout(t.hideBarTimeout);
          t.hideBarTimeout = setTimeout(function () {
            t.outer.addClass('lg-hide-items');
          }, t.settings.hideBarsDelay);
        });
        t.outer.trigger('mousemove.lg');
      }
    }, this.settings.showBarsAfter);
  };
  LightGallery.prototype.initPictureFill = function (t) {
    if (this.settings.supportLegacyBrowser)
      try {
        picturefill({ elements: [t.get()] });
      } catch (t) {
        console.warn(
          'lightGallery :- If you want srcset or picture tag to be supported for older browser please include picturefil javascript library in your document.'
        );
      }
  };
  LightGallery.prototype.counter = function () {
    if (this.settings.counter) {
      var t =
        '<div class="lg-counter" role="status" aria-live="polite">\n                <span id="' +
        this.getIdName('lg-counter-current') +
        '" class="lg-counter-current">' +
        (this.index + 1) +
        ' </span> /\n                <span id="' +
        this.getIdName('lg-counter-all') +
        '" class="lg-counter-all">' +
        this.galleryItems.length +
        ' </span></div>';
      this.outer.find(this.settings.appendCounterTo).append(t);
    }
  };
  /**
   *  @desc add sub-html into the slide
   *  @param {Number} index - index of the slide
   */ LightGallery.prototype.addHtml = function (e) {
    var i;
    var s;
    this.galleryItems[e].subHtmlUrl
      ? (s = this.galleryItems[e].subHtmlUrl)
      : (i = this.galleryItems[e].subHtml);
    if (!s)
      if (i) {
        var r = i.substring(0, 1);
        ('.' !== r && '#' !== r) ||
          (i =
            this.settings.subHtmlSelectorRelative && !this.settings.dynamic
              ? $LG(this.items).eq(e).find(i).first().html()
              : $LG(i).first().html());
      } else i = '';
    if ('.lg-item' !== this.settings.appendSubHtmlTo)
      s ? this.outer.find('.lg-sub-html').load(s) : this.outer.find('.lg-sub-html').html(i);
    else {
      var l = $LG(this.getSlideItemId(e));
      s ? l.load(s) : l.append('<div class="lg-sub-html">' + i + '</div>');
    }
    'undefined' !== typeof i &&
      null !== i &&
      ('' === i
        ? this.outer.find(this.settings.appendSubHtmlTo).addClass('lg-empty-html')
        : this.outer.find(this.settings.appendSubHtmlTo).removeClass('lg-empty-html'));
    this.LGel.trigger(t.afterAppendSubHtml, { index: e });
  };
  /**
   *  @desc Preload slides
   *  @param {Number} index - index of the slide
   * @todo preload not working for the first slide, Also, should work for the first and last slide as well
   */ LightGallery.prototype.preload = function (t) {
    for (var e = 1; e <= this.settings.preload; e++) {
      if (e >= this.galleryItems.length - t) break;
      this.loadContent(t + e, false);
    }
    for (var i = 1; i <= this.settings.preload; i++) {
      if (t - i < 0) break;
      this.loadContent(t - i, false);
    }
  };
  LightGallery.prototype.getDummyImgStyles = function (t) {
    return t
      ? 'width:' +
          t.width +
          'px;\n                margin-left: -' +
          t.width / 2 +
          'px;\n                margin-top: -' +
          t.height / 2 +
          'px;\n                height:' +
          t.height +
          'px'
      : '';
  };
  LightGallery.prototype.getVideoContStyle = function (t) {
    return t ? 'width:' + t.width + 'px;\n                height:' + t.height + 'px' : '';
  };
  LightGallery.prototype.getDummyImageContent = function (t, e, i) {
    var s;
    this.settings.dynamic || (s = $LG(this.items).eq(e));
    if (s) {
      var r = void 0;
      r = this.settings.exThumbImage
        ? s.attr(this.settings.exThumbImage)
        : s.find('img').first().attr('src');
      if (!r) return '';
      var l = this.getDummyImgStyles(this.currentImageSize);
      var o = '<img ' + i + ' style="' + l + '" class="lg-dummy-img" src="' + r + '" />';
      t.addClass('lg-first-slide');
      this.outer.addClass('lg-first-slide-loading');
      return o;
    }
    return '';
  };
  LightGallery.prototype.setImgMarkup = function (t, e, i) {
    var s = this.galleryItems[i];
    var l = s.alt,
      o = s.srcset,
      n = s.sizes,
      a = s.sources;
    var g = '';
    var d = l ? 'alt="' + l + '"' : '';
    g = this.isFirstSlideWithZoomAnimation()
      ? this.getDummyImageContent(e, i, d)
      : r.getImgMarkup(i, t, d, o, n, a);
    var h = '<picture class="lg-img-wrap"> ' + g + '</picture>';
    e.prepend(h);
  };
  LightGallery.prototype.onSlideObjectLoad = function (t, e, i, s) {
    var l = t.find('.lg-object').first();
    if (r.isImageLoaded(l.get()) || e) i();
    else {
      l.on('load.lg error.lg', function () {
        i && i();
      });
      l.on('error.lg', function () {
        s && s();
      });
    }
  };
  /**
   *
   * @param $el Current slide item
   * @param index
   * @param delay Delay is 0 except first time
   * @param speed Speed is same as delay, except it is 0 if gallery is opened via hash plugin
   * @param isFirstSlide
   */ LightGallery.prototype.onLgObjectLoad = function (t, e, i, s, r, l) {
    var o = this;
    this.onSlideObjectLoad(
      t,
      l,
      function () {
        o.triggerSlideItemLoad(t, e, i, s, r);
      },
      function () {
        t.addClass('lg-complete lg-complete_');
        t.html('<span class="lg-error-msg">' + o.settings.strings.mediaLoadingFailed + '</span>');
      }
    );
  };
  LightGallery.prototype.triggerSlideItemLoad = function (e, i, s, r, l) {
    var o = this;
    var n = this.galleryItems[i];
    var a = l && 'video' === this.getSlideType(n) && !n.poster ? r : 0;
    setTimeout(function () {
      e.addClass('lg-complete lg-complete_');
      o.LGel.trigger(t.slideItemLoad, { index: i, delay: s || 0, isFirstSlide: l });
    }, a);
  };
  LightGallery.prototype.isFirstSlideWithZoomAnimation = function () {
    return !!(!this.lGalleryOn && this.zoomFromOrigin && this.currentImageSize);
  };
  LightGallery.prototype.addSlideVideoInfo = function (t) {
    var e = this;
    t.forEach(function (t, i) {
      t.__slideVideoInfo = r.isVideo(t.src, !!t.video, i);
      t.__slideVideoInfo &&
        e.settings.loadYouTubePoster &&
        !t.poster &&
        t.__slideVideoInfo.youtube &&
        (t.poster = '//img.youtube.com/vi/' + t.__slideVideoInfo.youtube[1] + '/maxresdefault.jpg');
    });
  };
  /**
   *  Load slide content into slide.
   *  This is used to load content into slides that is not visible too
   *  @param {Number} index - index of the slide.
   *  @param {Boolean} rec - if true call loadcontent() function again.
   */ LightGallery.prototype.loadContent = function (e, i) {
    var s = this;
    var l = this.galleryItems[e];
    var o = $LG(this.getSlideItemId(e));
    var n = l.poster,
      a = l.srcset,
      g = l.sizes,
      d = l.sources;
    var h = l.src;
    var u = l.video;
    var c = u && 'string' === typeof u ? JSON.parse(u) : u;
    if (l.responsive) {
      var m = l.responsive.split(',');
      h = r.getResponsiveSrc(m) || h;
    }
    var p = l.__slideVideoInfo;
    var f = '';
    var y = !!l.iframe;
    var v = !this.lGalleryOn;
    var b = 0;
    v &&
      (b =
        this.zoomFromOrigin && this.currentImageSize
          ? this.settings.startAnimationDuration + 10
          : this.settings.backdropDuration + 10);
    if (!o.hasClass('lg-loaded')) {
      if (p) {
        var C = this.mediaContainerPosition,
          I = C.top,
          L = C.bottom;
        var S = r.getSize(this.items[e], this.outer, I + L, p && this.settings.videoMaxSize);
        f = this.getVideoContStyle(S);
      }
      if (y) {
        var G = r.getIframeMarkup(
          this.settings.iframeWidth,
          this.settings.iframeHeight,
          this.settings.iframeMaxWidth,
          this.settings.iframeMaxHeight,
          h,
          l.iframeTitle
        );
        o.prepend(G);
      } else if (n) {
        var x = '';
        var w = v && this.zoomFromOrigin && this.currentImageSize;
        w && (x = this.getDummyImageContent(o, e, ''));
        G = r.getVideoPosterMarkup(n, x || '', f, this.settings.strings.playVideo, p);
        o.prepend(G);
      } else if (p) {
        G = '<div class="lg-video-cont " style="' + f + '"></div>';
        o.prepend(G);
      } else {
        this.setImgMarkup(h, o, e);
        if (a || d) {
          var T = o.find('.lg-object');
          this.initPictureFill(T);
        }
      }
      (n || p) &&
        this.LGel.trigger(t.hasVideo, { index: e, src: h, html5Video: c, hasPoster: !!n });
      this.LGel.trigger(t.afterAppendSlide, { index: e });
      this.lGalleryOn && '.lg-item' === this.settings.appendSubHtmlTo && this.addHtml(e);
    }
    var E = 0;
    b && !$LG(document.body).hasClass('lg-from-hash') && (E = b);
    if (this.isFirstSlideWithZoomAnimation()) {
      setTimeout(function () {
        o.removeClass('lg-start-end-progress lg-start-progress').removeAttr('style');
      }, this.settings.startAnimationDuration + 100);
      o.hasClass('lg-loaded') ||
        setTimeout(function () {
          if ('image' === s.getSlideType(l)) {
            var t = l.alt;
            var i = t ? 'alt="' + t + '"' : '';
            o.find('.lg-img-wrap').append(r.getImgMarkup(e, h, i, a, g, l.sources));
            if (a || d) {
              var u = o.find('.lg-object');
              s.initPictureFill(u);
            }
          }
          if ('image' === s.getSlideType(l) || ('video' === s.getSlideType(l) && n)) {
            s.onLgObjectLoad(o, e, b, E, true, false);
            s.onSlideObjectLoad(
              o,
              !!(p && p.html5 && !n),
              function () {
                s.loadContentOnFirstSlideLoad(e, o, E);
              },
              function () {
                s.loadContentOnFirstSlideLoad(e, o, E);
              }
            );
          }
        }, this.settings.startAnimationDuration + 100);
    }
    o.addClass('lg-loaded');
    (this.isFirstSlideWithZoomAnimation() && ('video' !== this.getSlideType(l) || n)) ||
      this.onLgObjectLoad(o, e, b, E, v, !!(p && p.html5 && !n));
    (this.zoomFromOrigin && this.currentImageSize) ||
      !o.hasClass('lg-complete_') ||
      this.lGalleryOn ||
      setTimeout(function () {
        o.addClass('lg-complete');
      }, this.settings.backdropDuration);
    this.lGalleryOn = true;
    true === i &&
      (o.hasClass('lg-complete_')
        ? this.preload(e)
        : o
            .find('.lg-object')
            .first()
            .on('load.lg error.lg', function () {
              s.preload(e);
            }));
  };
  /**
   * @desc Remove dummy image content and load next slides
   * Called only for the first time if zoomFromOrigin animation is enabled
   * @param index
   * @param $currentSlide
   * @param speed
   */ LightGallery.prototype.loadContentOnFirstSlideLoad = function (t, e, i) {
    var s = this;
    setTimeout(function () {
      e.find('.lg-dummy-img').remove();
      e.removeClass('lg-first-slide');
      s.outer.removeClass('lg-first-slide-loading');
      s.isDummyImageRemoved = true;
      s.preload(t);
    }, i + 300);
  };
  LightGallery.prototype.getItemsToBeInsertedToDom = function (t, e, i) {
    var s = this;
    void 0 === i && (i = 0);
    var r = [];
    var l = Math.max(i, 3);
    l = Math.min(l, this.galleryItems.length);
    var o = 'lg-item-' + this.lgId + '-' + e;
    if (this.galleryItems.length <= 3) {
      this.galleryItems.forEach(function (t, e) {
        r.push('lg-item-' + s.lgId + '-' + e);
      });
      return r;
    }
    if (t < (this.galleryItems.length - 1) / 2) {
      for (var n = t; n > t - l / 2 && n >= 0; n--) r.push('lg-item-' + this.lgId + '-' + n);
      var a = r.length;
      for (n = 0; n < l - a; n++) r.push('lg-item-' + this.lgId + '-' + (t + n + 1));
    } else {
      for (n = t; n <= this.galleryItems.length - 1 && n < t + l / 2; n++)
        r.push('lg-item-' + this.lgId + '-' + n);
      a = r.length;
      for (n = 0; n < l - a; n++) r.push('lg-item-' + this.lgId + '-' + (t - n - 1));
    }
    this.settings.loop &&
      (t === this.galleryItems.length - 1
        ? r.push('lg-item-' + this.lgId + '-0')
        : 0 === t && r.push('lg-item-' + this.lgId + '-' + (this.galleryItems.length - 1)));
    -1 === r.indexOf(o) && r.push('lg-item-' + this.lgId + '-' + e);
    return r;
  };
  LightGallery.prototype.organizeSlideItems = function (t, e) {
    var i = this;
    var s = this.getItemsToBeInsertedToDom(t, e, this.settings.numberOfSlideItemsInDom);
    s.forEach(function (t) {
      -1 === i.currentItemsInDom.indexOf(t) &&
        i.$inner.append('<div id="' + t + '" class="lg-item"></div>');
    });
    this.currentItemsInDom.forEach(function (t) {
      -1 === s.indexOf(t) && $LG('#' + t).remove();
    });
    return s;
  };
  LightGallery.prototype.getPreviousSlideIndex = function () {
    var t = 0;
    try {
      var e = this.outer.find('.lg-current').first().attr('id');
      t = parseInt(e.split('-')[3]) || 0;
    } catch (e) {
      t = 0;
    }
    return t;
  };
  LightGallery.prototype.setDownloadValue = function (t) {
    if (this.settings.download) {
      var e = this.galleryItems[t];
      var i = false === e.downloadUrl || 'false' === e.downloadUrl;
      if (i) this.outer.addClass('lg-hide-download');
      else {
        var s = this.getElementById('lg-download');
        this.outer.removeClass('lg-hide-download');
        s.attr('href', e.downloadUrl || e.src);
        e.download && s.attr('download', e.download);
      }
    }
  };
  LightGallery.prototype.makeSlideAnimation = function (t, e, i) {
    var s = this;
    this.lGalleryOn && i.addClass('lg-slide-progress');
    setTimeout(
      function () {
        s.outer.addClass('lg-no-trans');
        s.outer.find('.lg-item').removeClass('lg-prev-slide lg-next-slide');
        if ('prev' === t) {
          e.addClass('lg-prev-slide');
          i.addClass('lg-next-slide');
        } else {
          e.addClass('lg-next-slide');
          i.addClass('lg-prev-slide');
        }
        setTimeout(function () {
          s.outer.find('.lg-item').removeClass('lg-current');
          e.addClass('lg-current');
          s.outer.removeClass('lg-no-trans');
        }, 50);
      },
      this.lGalleryOn ? this.settings.slideDelay : 0
    );
  };
  /**
   * Goto a specific slide.
   * @param {Number} index - index of the slide
   * @param {Boolean} fromTouch - true if slide function called via touch event or mouse drag
   * @param {Boolean} fromThumb - true if slide function called via thumbnail click
   * @param {String} direction - Direction of the slide(next/prev)
   * @category lGPublicMethods
   * @example
   *  const plugin = lightGallery();
   *  // to go to 3rd slide
   *  plugin.slide(2);
   *
   */ LightGallery.prototype.slide = function (e, i, s, l) {
    var o = this;
    var n = this.getPreviousSlideIndex();
    this.currentItemsInDom = this.organizeSlideItems(e, n);
    if (!this.lGalleryOn || n !== e) {
      var a = this.galleryItems.length;
      if (!this.lgBusy) {
        this.settings.counter && this.updateCurrentCounter(e);
        var g = this.getSlideItem(e);
        var d = this.getSlideItem(n);
        var h = this.galleryItems[e];
        var u = h.__slideVideoInfo;
        this.outer.attr('data-lg-slide-type', this.getSlideType(h));
        this.setDownloadValue(e);
        if (u) {
          var c = this.mediaContainerPosition,
            m = c.top,
            p = c.bottom;
          var f = r.getSize(this.items[e], this.outer, m + p, u && this.settings.videoMaxSize);
          this.resizeVideoSlide(e, f);
        }
        this.LGel.trigger(t.beforeSlide, {
          prevIndex: n,
          index: e,
          fromTouch: !!i,
          fromThumb: !!s,
        });
        this.lgBusy = true;
        clearTimeout(this.hideBarTimeout);
        this.arrowDisable(e);
        l || (e < n ? (l = 'prev') : e > n && (l = 'next'));
        if (i) {
          this.outer.find('.lg-item').removeClass('lg-prev-slide lg-current lg-next-slide');
          var y = void 0;
          var v = void 0;
          if (a > 2) {
            y = e - 1;
            v = e + 1;
            if (0 === e && n === a - 1) {
              v = 0;
              y = a - 1;
            } else if (e === a - 1 && 0 === n) {
              v = 0;
              y = a - 1;
            }
          } else {
            y = 0;
            v = 1;
          }
          'prev' === l
            ? this.getSlideItem(v).addClass('lg-next-slide')
            : this.getSlideItem(y).addClass('lg-prev-slide');
          g.addClass('lg-current');
        } else this.makeSlideAnimation(l, g, d);
        this.lGalleryOn
          ? setTimeout(function () {
              o.loadContent(e, true);
              '.lg-item' !== o.settings.appendSubHtmlTo && o.addHtml(e);
            }, this.settings.speed + 50 + (i ? 0 : this.settings.slideDelay))
          : this.loadContent(e, true);
        setTimeout(function () {
          o.lgBusy = false;
          d.removeClass('lg-slide-progress');
          o.LGel.trigger(t.afterSlide, { prevIndex: n, index: e, fromTouch: i, fromThumb: s });
        }, (this.lGalleryOn ? this.settings.speed + 100 : 100) +
          (i ? 0 : this.settings.slideDelay));
      }
      this.index = e;
    }
  };
  LightGallery.prototype.updateCurrentCounter = function (t) {
    this.getElementById('lg-counter-current').html(t + 1 + '');
  };
  LightGallery.prototype.updateCounterTotal = function () {
    this.getElementById('lg-counter-all').html(this.galleryItems.length + '');
  };
  LightGallery.prototype.getSlideType = function (t) {
    return t.__slideVideoInfo ? 'video' : t.iframe ? 'iframe' : 'image';
  };
  LightGallery.prototype.touchMove = function (t, e, i) {
    var s = e.pageX - t.pageX;
    var r = e.pageY - t.pageY;
    var l = false;
    if (this.swipeDirection) l = true;
    else if (Math.abs(s) > 15) {
      this.swipeDirection = 'horizontal';
      l = true;
    } else if (Math.abs(r) > 15) {
      this.swipeDirection = 'vertical';
      l = true;
    }
    if (l) {
      var o = this.getSlideItem(this.index);
      if ('horizontal' === this.swipeDirection) {
        null === i || void 0 === i ? void 0 : i.preventDefault();
        this.outer.addClass('lg-dragging');
        this.setTranslate(o, s, 0);
        var n = o.get().offsetWidth;
        var a = (15 * n) / 100;
        var g = a - Math.abs((10 * s) / 100);
        this.setTranslate(this.outer.find('.lg-prev-slide').first(), -n + s - g, 0);
        this.setTranslate(this.outer.find('.lg-next-slide').first(), n + s + g, 0);
      } else if ('vertical' === this.swipeDirection && this.settings.swipeToClose) {
        null === i || void 0 === i ? void 0 : i.preventDefault();
        this.$container.addClass('lg-dragging-vertical');
        var d = 1 - Math.abs(r) / window.innerHeight;
        this.$backdrop.css('opacity', d);
        var h = 1 - Math.abs(r) / (2 * window.innerWidth);
        this.setTranslate(o, 0, r, h, h);
        Math.abs(r) > 100 && this.outer.addClass('lg-hide-items').removeClass('lg-components-open');
      }
    }
  };
  LightGallery.prototype.touchEnd = function (e, i, s) {
    var r = this;
    var l;
    'lg-slide' !== this.settings.mode && this.outer.addClass('lg-slide');
    setTimeout(function () {
      r.$container.removeClass('lg-dragging-vertical');
      r.outer.removeClass('lg-dragging lg-hide-items').addClass('lg-components-open');
      var o = true;
      if ('horizontal' === r.swipeDirection) {
        l = e.pageX - i.pageX;
        var n = Math.abs(e.pageX - i.pageX);
        if (l < 0 && n > r.settings.swipeThreshold) {
          r.goToNextSlide(true);
          o = false;
        } else if (l > 0 && n > r.settings.swipeThreshold) {
          r.goToPrevSlide(true);
          o = false;
        }
      } else if ('vertical' === r.swipeDirection) {
        l = Math.abs(e.pageY - i.pageY);
        if (r.settings.closable && r.settings.swipeToClose && l > 100) {
          r.closeGallery();
          return;
        }
        r.$backdrop.css('opacity', 1);
      }
      r.outer.find('.lg-item').removeAttr('style');
      if (o && Math.abs(e.pageX - i.pageX) < 5) {
        var a = $LG(s.target);
        r.isPosterElement(a) && r.LGel.trigger(t.posterClick);
      }
      r.swipeDirection = void 0;
    });
    setTimeout(function () {
      r.outer.hasClass('lg-dragging') ||
        'lg-slide' === r.settings.mode ||
        r.outer.removeClass('lg-slide');
    }, this.settings.speed + 100);
  };
  LightGallery.prototype.enableSwipe = function () {
    var e = this;
    var i = {};
    var s = {};
    var r = false;
    var l = false;
    if (this.settings.enableSwipe) {
      this.$inner.on('touchstart.lg', function (t) {
        e.dragOrSwipeEnabled = true;
        var s = e.getSlideItem(e.index);
        if (
          ($LG(t.target).hasClass('lg-item') || s.get().contains(t.target)) &&
          !e.outer.hasClass('lg-zoomed') &&
          !e.lgBusy &&
          1 === t.touches.length
        ) {
          l = true;
          e.touchAction = 'swipe';
          e.manageSwipeClass();
          i = { pageX: t.touches[0].pageX, pageY: t.touches[0].pageY };
        }
      });
      this.$inner.on('touchmove.lg', function (t) {
        if (l && 'swipe' === e.touchAction && 1 === t.touches.length) {
          s = { pageX: t.touches[0].pageX, pageY: t.touches[0].pageY };
          e.touchMove(i, s, t);
          r = true;
        }
      });
      this.$inner.on('touchend.lg', function (o) {
        if ('swipe' === e.touchAction) {
          if (r) {
            r = false;
            e.touchEnd(s, i, o);
          } else if (l) {
            var n = $LG(o.target);
            e.isPosterElement(n) && e.LGel.trigger(t.posterClick);
          }
          e.touchAction = void 0;
          l = false;
        }
      });
    }
  };
  LightGallery.prototype.enableDrag = function () {
    var e = this;
    var i = {};
    var s = {};
    var r = false;
    var l = false;
    if (this.settings.enableDrag) {
      this.outer.on('mousedown.lg', function (s) {
        e.dragOrSwipeEnabled = true;
        var l = e.getSlideItem(e.index);
        if (
          ($LG(s.target).hasClass('lg-item') || l.get().contains(s.target)) &&
          !e.outer.hasClass('lg-zoomed') &&
          !e.lgBusy
        ) {
          s.preventDefault();
          if (!e.lgBusy) {
            e.manageSwipeClass();
            i = { pageX: s.pageX, pageY: s.pageY };
            r = true;
            e.outer.get().scrollLeft += 1;
            e.outer.get().scrollLeft -= 1;
            e.outer.removeClass('lg-grab').addClass('lg-grabbing');
            e.LGel.trigger(t.dragStart);
          }
        }
      });
      $LG(window).on('mousemove.lg.global' + this.lgId, function (o) {
        if (r && e.lgOpened) {
          l = true;
          s = { pageX: o.pageX, pageY: o.pageY };
          e.touchMove(i, s);
          e.LGel.trigger(t.dragMove);
        }
      });
      $LG(window).on('mouseup.lg.global' + this.lgId, function (o) {
        if (e.lgOpened) {
          var n = $LG(o.target);
          if (l) {
            l = false;
            e.touchEnd(s, i, o);
            e.LGel.trigger(t.dragEnd);
          } else e.isPosterElement(n) && e.LGel.trigger(t.posterClick);
          if (r) {
            r = false;
            e.outer.removeClass('lg-grabbing').addClass('lg-grab');
          }
        }
      });
    }
  };
  LightGallery.prototype.triggerPosterClick = function () {
    var e = this;
    this.$inner.on('click.lg', function (i) {
      !e.dragOrSwipeEnabled && e.isPosterElement($LG(i.target)) && e.LGel.trigger(t.posterClick);
    });
  };
  LightGallery.prototype.manageSwipeClass = function () {
    var t = this.index + 1;
    var e = this.index - 1;
    this.settings.loop &&
      this.galleryItems.length > 2 &&
      (0 === this.index
        ? (e = this.galleryItems.length - 1)
        : this.index === this.galleryItems.length - 1 && (t = 0));
    this.outer.find('.lg-item').removeClass('lg-next-slide lg-prev-slide');
    e > -1 && this.getSlideItem(e).addClass('lg-prev-slide');
    this.getSlideItem(t).addClass('lg-next-slide');
  };
  /**
   * Go to next slide
   * @param {Boolean} fromTouch - true if slide function called via touch event
   * @category lGPublicMethods
   * @example
   *  const plugin = lightGallery();
   *  plugin.goToNextSlide();
   * @see <a href="/demos/methods/">Demo</a>
   */ LightGallery.prototype.goToNextSlide = function (e) {
    var i = this;
    var s = this.settings.loop;
    e && this.galleryItems.length < 3 && (s = false);
    if (!this.lgBusy)
      if (this.index + 1 < this.galleryItems.length) {
        this.index++;
        this.LGel.trigger(t.beforeNextSlide, { index: this.index });
        this.slide(this.index, !!e, false, 'next');
      } else if (s) {
        this.index = 0;
        this.LGel.trigger(t.beforeNextSlide, { index: this.index });
        this.slide(this.index, !!e, false, 'next');
      } else if (this.settings.slideEndAnimation && !e) {
        this.outer.addClass('lg-right-end');
        setTimeout(function () {
          i.outer.removeClass('lg-right-end');
        }, 400);
      }
  };
  /**
   * Go to previous slides
   * @param {Boolean} fromTouch - true if slide function called via touch event
   * @category lGPublicMethods
   * @example
   *  const plugin = lightGallery({});
   *  plugin.goToPrevSlide();
   * @see <a href="/demos/methods/">Demo</a>
   *
   */ LightGallery.prototype.goToPrevSlide = function (e) {
    var i = this;
    var s = this.settings.loop;
    e && this.galleryItems.length < 3 && (s = false);
    if (!this.lgBusy)
      if (this.index > 0) {
        this.index--;
        this.LGel.trigger(t.beforePrevSlide, { index: this.index, fromTouch: e });
        this.slide(this.index, !!e, false, 'prev');
      } else if (s) {
        this.index = this.galleryItems.length - 1;
        this.LGel.trigger(t.beforePrevSlide, { index: this.index, fromTouch: e });
        this.slide(this.index, !!e, false, 'prev');
      } else if (this.settings.slideEndAnimation && !e) {
        this.outer.addClass('lg-left-end');
        setTimeout(function () {
          i.outer.removeClass('lg-left-end');
        }, 400);
      }
  };
  LightGallery.prototype.keyPress = function () {
    var t = this;
    $LG(window).on('keydown.lg.global' + this.lgId, function (e) {
      if (t.lgOpened && true === t.settings.escKey && 27 === e.keyCode) {
        e.preventDefault();
        t.settings.allowMediaOverlap &&
        t.outer.hasClass('lg-can-toggle') &&
        t.outer.hasClass('lg-components-open')
          ? t.outer.removeClass('lg-components-open')
          : t.closeGallery();
      }
      if (t.lgOpened && t.galleryItems.length > 1) {
        if (37 === e.keyCode) {
          e.preventDefault();
          t.goToPrevSlide();
        }
        if (39 === e.keyCode) {
          e.preventDefault();
          t.goToNextSlide();
        }
      }
    });
  };
  LightGallery.prototype.arrow = function () {
    var t = this;
    this.getElementById('lg-prev').on('click.lg', function () {
      t.goToPrevSlide();
    });
    this.getElementById('lg-next').on('click.lg', function () {
      t.goToNextSlide();
    });
  };
  LightGallery.prototype.arrowDisable = function (t) {
    if (!this.settings.loop && this.settings.hideControlOnEnd) {
      var e = this.getElementById('lg-prev');
      var i = this.getElementById('lg-next');
      t + 1 === this.galleryItems.length
        ? i.attr('disabled', 'disabled').addClass('disabled')
        : i.removeAttr('disabled').removeClass('disabled');
      0 === t
        ? e.attr('disabled', 'disabled').addClass('disabled')
        : e.removeAttr('disabled').removeClass('disabled');
    }
  };
  LightGallery.prototype.setTranslate = function (t, e, i, s, r) {
    void 0 === s && (s = 1);
    void 0 === r && (r = 1);
    t.css(
      'transform',
      'translate3d(' + e + 'px, ' + i + 'px, 0px) scale3d(' + s + ', ' + r + ', 1)'
    );
  };
  LightGallery.prototype.mousewheel = function () {
    var t = this;
    var e = 0;
    this.outer.on('wheel.lg', function (i) {
      if (i.deltaY && !(t.galleryItems.length < 2)) {
        i.preventDefault();
        var s = new Date().getTime();
        if (!(s - e < 1e3)) {
          e = s;
          i.deltaY > 0 ? t.goToNextSlide() : i.deltaY < 0 && t.goToPrevSlide();
        }
      }
    });
  };
  LightGallery.prototype.isSlideElement = function (t) {
    return t.hasClass('lg-outer') || t.hasClass('lg-item') || t.hasClass('lg-img-wrap');
  };
  LightGallery.prototype.isPosterElement = function (t) {
    var e = this.getSlideItem(this.index).find('.lg-video-play-button').get();
    return (
      t.hasClass('lg-video-poster') ||
      t.hasClass('lg-video-play-button') ||
      (e && e.contains(t.get()))
    );
  };
  LightGallery.prototype.toggleMaximize = function () {
    var t = this;
    this.getElementById('lg-maximize').on('click.lg', function () {
      t.$container.toggleClass('lg-inline');
      t.refreshOnResize();
    });
  };
  LightGallery.prototype.invalidateItems = function () {
    for (var t = 0; t < this.items.length; t++) {
      var e = this.items[t];
      var i = $LG(e);
      i.off('click.lgcustom-item-' + i.attr('data-lg-id'));
    }
  };
  LightGallery.prototype.trapFocus = function () {
    var t = this;
    this.$container.get().focus({ preventScroll: true });
    $LG(window).on('keydown.lg.global' + this.lgId, function (e) {
      if (t.lgOpened) {
        var i = 'Tab' === e.key || 9 === e.keyCode;
        if (i) {
          var s = r.getFocusableElements(t.$container.get());
          var l = s[0];
          var o = s[s.length - 1];
          if (e.shiftKey) {
            if (document.activeElement === l) {
              o.focus();
              e.preventDefault();
            }
          } else if (document.activeElement === o) {
            l.focus();
            e.preventDefault();
          }
        }
      }
    });
  };
  LightGallery.prototype.manageCloseGallery = function () {
    var t = this;
    if (this.settings.closable) {
      var e = false;
      this.getElementById('lg-close').on('click.lg', function () {
        t.closeGallery();
      });
      if (this.settings.closeOnTap) {
        this.outer.on('mousedown.lg', function (i) {
          var s = $LG(i.target);
          e = !!t.isSlideElement(s);
        });
        this.outer.on('mousemove.lg', function () {
          e = false;
        });
        this.outer.on('mouseup.lg', function (i) {
          var s = $LG(i.target);
          t.isSlideElement(s) && e && (t.outer.hasClass('lg-dragging') || t.closeGallery());
        });
      }
    }
  };
  LightGallery.prototype.closeGallery = function (e) {
    var i = this;
    if (!this.lgOpened || (!this.settings.closable && !e)) return 0;
    this.LGel.trigger(t.beforeClose);
    this.settings.resetScrollPosition &&
      !this.settings.hideScrollbar &&
      $LG(window).scrollTop(this.prevScrollTop);
    var s = this.items[this.index];
    var l;
    if (this.zoomFromOrigin && s) {
      var o = this.mediaContainerPosition,
        n = o.top,
        a = o.bottom;
      var g = this.galleryItems[this.index],
        d = g.__slideVideoInfo,
        h = g.poster;
      var u = r.getSize(s, this.outer, n + a, d && h && this.settings.videoMaxSize);
      l = r.getTransform(s, this.outer, n, a, u);
    }
    if (this.zoomFromOrigin && l) {
      this.outer.addClass('lg-closing lg-zoom-from-image');
      this.getSlideItem(this.index)
        .addClass('lg-start-end-progress')
        .css('transition-duration', this.settings.startAnimationDuration + 'ms')
        .css('transform', l);
    } else {
      this.outer.addClass('lg-hide-items');
      this.outer.removeClass('lg-zoom-from-image');
    }
    this.destroyModules();
    this.lGalleryOn = false;
    this.isDummyImageRemoved = false;
    this.zoomFromOrigin = this.settings.zoomFromOrigin;
    clearTimeout(this.hideBarTimeout);
    this.hideBarTimeout = false;
    $LG('html').removeClass('lg-on');
    this.outer.removeClass('lg-visible lg-components-open');
    this.$backdrop.removeClass('in').css('opacity', 0);
    var c =
      this.zoomFromOrigin && l
        ? Math.max(this.settings.startAnimationDuration, this.settings.backdropDuration)
        : this.settings.backdropDuration;
    this.$container.removeClass('lg-show-in');
    setTimeout(function () {
      i.zoomFromOrigin && l && i.outer.removeClass('lg-zoom-from-image');
      i.$container.removeClass('lg-show');
      i.resetScrollBar();
      i.$backdrop
        .removeAttr('style')
        .css('transition-duration', i.settings.backdropDuration + 'ms');
      i.outer.removeClass('lg-closing ' + i.settings.startClass);
      i.getSlideItem(i.index).removeClass('lg-start-end-progress');
      i.$inner.empty();
      i.lgOpened && i.LGel.trigger(t.afterClose, { instance: i });
      i.$container.get() && i.$container.get().blur();
      i.lgOpened = false;
    }, c + 100);
    return c + 100;
  };
  LightGallery.prototype.initModules = function () {
    this.plugins.forEach(function (t) {
      try {
        t.init();
      } catch (t) {
        console.warn('lightGallery:- make sure lightGallery module is properly initiated');
      }
    });
  };
  LightGallery.prototype.destroyModules = function (t) {
    this.plugins.forEach(function (e) {
      try {
        t ? e.destroy() : e.closeGallery && e.closeGallery();
      } catch (t) {
        console.warn('lightGallery:- make sure lightGallery module is properly destroyed');
      }
    });
  };
  LightGallery.prototype.refresh = function (e) {
    this.settings.dynamic || this.invalidateItems();
    this.galleryItems = e || this.getItems();
    this.updateControls();
    this.openGalleryOnItemClick();
    this.LGel.trigger(t.updateSlides);
  };
  LightGallery.prototype.updateControls = function () {
    this.addSlideVideoInfo(this.galleryItems);
    this.updateCounterTotal();
    this.manageSingleSlideClassName();
  };
  LightGallery.prototype.destroyGallery = function () {
    this.destroyModules(true);
    this.settings.dynamic || this.invalidateItems();
    $LG(window).off('.lg.global' + this.lgId);
    this.LGel.off('.lg');
    this.$container.remove();
  };
  LightGallery.prototype.destroy = function () {
    var t = this.closeGallery(true);
    t ? setTimeout(this.destroyGallery.bind(this), t) : this.destroyGallery();
    return t;
  };
  return LightGallery;
})();
function lightGallery(t, e) {
  return new o(t, e);
}
export { lightGallery as default };
