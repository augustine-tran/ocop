import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['primary', 'dependent'];
  static values = { optionsUrl: String, paramName: String };

  connect() {
    this.url = this.optionsUrlValue;
    console.log('--> this.optionsUrlValue', this.url);
  }

  primaryChange() {
    const primaryId = this.primaryTarget.options[this.primaryTarget.selectedIndex].value;

    fetch(`${this.url}?${this.paramNameValue}=${primaryId}`)
      .then(response => response.text())
      .then(html => {
        this.dependentTarget.innerHTML = html;
      });
  }
}
