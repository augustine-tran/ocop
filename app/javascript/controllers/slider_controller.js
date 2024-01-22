import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['slide', 'dot'];
  static values = { index: Number };
  static supportedClasses = ['hidden', 'block', '!opacity-100'];

  slideTo(event) {
    this.indexValue = parseInt(event.params.index);
  }

  next() {
    if (this.indexValue === this.slideTargets.length - 1) {
      this.indexValue = 0;
    } else {
      this.indexValue++;
    }
  }

  prev() {
    if (this.indexValue === 0) {
      this.indexValue = this.slideTargets.length - 1;
    } else {
      this.indexValue--;
    }
  }

  indexValueChanged() {
    this.updateSlide();
  }

  updateSlide() {
    this.slideTargets.forEach((el, i) => {
      if (this.indexValue === i) {
        el.classList.remove(this.constructor.supportedClasses[0]);
        el.classList.add(this.constructor.supportedClasses[1]);
      } else {
        el.classList.remove(this.constructor.supportedClasses[1]);
        el.classList.add(this.constructor.supportedClasses[0]);
      }
    });
    this.dotTargets.forEach((el, i) => {
      el.classList.toggle(this.constructor.supportedClasses[2], this.indexValue === i);
    });
  }

  openFullScreen(event) {
    const image = event.target;

    const originalSrc = image.src;

    const highResSrc = event.params.url;

    if (event.params.isPdf) {
      return window.open(highResSrc, '_blank');
    }

    if (!document.fullscreenElement) {
      if (highResSrc) {
        image.originalSrc = originalSrc;
        image.src = highResSrc;
      }

      image.requestFullscreen();
    }
  }

  closeFullScreen() {
    const image = this.slideTargets[this.indexValue];

    if (image.originalSrc && image.src !== image.originalSrc) {
      image.src = image.originalSrc;
    }
  }
}
