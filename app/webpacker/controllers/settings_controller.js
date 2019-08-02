import { Controller } from 'stimulus';

export default class extends Controller {
    static targets = ['source'];
    initialize() {
          console.log('Settings controller initialized');
        }
    connect() {};
}
