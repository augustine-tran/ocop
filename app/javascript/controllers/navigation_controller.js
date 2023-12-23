import { Controller } from '@hotwired/stimulus';
import { enter, leave } from './transition';

// Connects to data-controller="navigation"
export default class extends Controller {
  static targets = ['menu', 'mobileMenu', 'mobileMenuButton'];

  static values = { open: { type: Boolean, default: false } };

  openValueChanged() {
    if (this.openValue) {
      enter(this.mobileMenuTarget);
      this.mobileMenuButtonTarget.children[2].classList.add('hidden');
      this.mobileMenuButtonTarget.children[2].classList.remove('block');
      this.mobileMenuButtonTarget.children[3].classList.remove('hidden');
      this.mobileMenuButtonTarget.children[3].classList.add('block');
    } else {
      leave(this.mobileMenuTarget);
      this.mobileMenuButtonTarget.children[2].classList.add('block');
      this.mobileMenuButtonTarget.children[2].classList.remove('hidden');
      this.mobileMenuButtonTarget.children[3].classList.add('hidden');
      this.mobileMenuButtonTarget.children[3].classList.remove('block');
    }
  }

  toggleMobileMenu() {
    this.openValue = !this.openValue;
  }
}
