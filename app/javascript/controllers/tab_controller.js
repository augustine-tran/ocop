import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['select'];

  change() {
    const url = this.selectTarget.value;
    window.location.href = url;
  }
}
