import { Controller } from '@hotwired/stimulus';
import tippy, { createSingleton } from 'tippy.js';

export default class extends Controller {
  static targets = ['trigger', 'content'];

  static values = {
    config: Object,
    singleton: Boolean,
  };

  initialize() {
    const config = {
      allowHTML: true,
      arrow: true,
      placement: 'bottom',
      animation: 'shift-toward-subtle',
      theme: 'material',
      maxWidth: 256,
      onShown: () => {
        this.dispatch('shown');
      },
      ...this.configValue,
    };

    if (this.singletonValue) {
      const tippyInstances = this.triggerTargets.map((target, index) =>
        tippy(target, {
          content: this.contentTargets[index].innerHTML,
        })
      );
      this.tippy = createSingleton(tippyInstances, config);
    } else {
      if (this.hasContentTarget) {
        const content = this.contentTarget.innerHTML;
        // this.contentTarget.remove();
        this.tippy = tippy(this.triggerTarget, {
          content,
          ...config,
        });
      }
    }
  }

  disconnect() {
    this.tippy.hide();
  }

  hide() {
    this.tippy.hide();
  }

  hideTrigger() {
    this.triggerTarget.classList.add('hidden');
  }

  showTrigger() {
    this.triggerTarget.classList.remove('hidden');
  }
}
