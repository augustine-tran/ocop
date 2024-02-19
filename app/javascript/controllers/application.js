import { Application } from '@hotwired/stimulus';
import Lightbox from 'stimulus-lightbox';

const application = Application.start();
application.register('lightbox', Lightbox);

// Configure Stimulus development experience
application.debug = true;
window.Stimulus = application;

export { application };
