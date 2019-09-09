
import { Controller } from 'stimulus';

export default class extends Controller {
    static targets = ['menu'];

    startTimer(target) {
        this.closeMenuTimer = setTimeout(function() {
            target.classList.remove('dropdown-open');
        }, 2000);
    }

    stopTimer() {
        if(this.closeMenuTimer) {
            clearTimeout(this.closeMenuTimer);
        }
    }

    toggleMenu(event) {
        event.preventDefault();
        this.menuTarget.classList.toggle('dropdown-open');
        this.stopTimer();
    }

    closeMenu(event) {
        this.startTimer(this.menuTarget);
    }

    closeMenuWithoutDelay(event) {
        if (event.key === 'Escape') {
            this.menuTarget.classList.remove('dropdown-open');
            this.stopTimer();
        }
    }

    disconnect() {
        this.stopTimer();
    }
}

