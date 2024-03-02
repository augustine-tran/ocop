import { Application } from '@hotwired/stimulus';
import Lightbox from 'stimulus-lightbox';
import { isDevEnvironment } from 'helpers/dom_helpers';

const application = Application.start();
application.register('lightbox', Lightbox);

// Configure Stimulus development experience
application.debug = isDevEnvironment();
window.Stimulus = application;

export { application };
