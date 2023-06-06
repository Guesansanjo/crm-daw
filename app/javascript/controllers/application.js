import { Application } from "@hotwired/stimulus";
import global from 'global';

    const application = Application.start();

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;
window.global = global;

export { global };
export { application };
