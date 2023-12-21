import { Controller } from '@hotwired/stimulus';
import { enter, leave } from './transition';

// Connects to data-controller="header-menu"
export default class extends Controller {
  static targets = ['menu', 'background'];
  static values = {
    open: { type: Boolean, default: false },
  };

  connect() {}

  disconnect() {
    this.close();
  }

  open() {
    this.openValue = true;
  }

  close() {
    this.openValue = false;
  }

  openValueChanged() {
    if (this.openValue) {
      enter(this.backgroundTarget);
      enter(this.menuTarget);
    } else {
      leave(this.menuTarget);
      leave(this.backgroundTarget);
    }
  }
}
