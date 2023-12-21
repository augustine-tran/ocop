import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['container', 'background', 'trigger'];

  open() {
    this.triggerTarget.classList.add('hidden');
    this.backgroundTarget.classList.remove('hidden');
    this.backgroundTarget.classList.add('opacity-100', 'translate-y-0', 'scale-100');
    this.containerTarget.classList.remove('hidden');
    this.containerTarget.classList.add('opacity-100', 'translate-y-0', 'scale-100');
  }

  close() {
    this.triggerTarget.classList.remove('hidden');
    this.backgroundTarget.classList.remove('opacity-100', 'translate-y-0', 'scale-100');
    this.backgroundTarget.classList.add('hidden');
    this.containerTarget.classList.remove('opacity-100', 'translate-y-0', 'scale-100');
    this.containerTarget.classList.add('hidden');
  }
}
