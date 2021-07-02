import { Controller } from 'stimulus';

export default class extends Controller {
    static targets = ['menu'];

    startTimer(target) {
        this.closeMenuTimer = setTimeout(function() {
            target.classList.remove('dropdown-open');
        }, 5000);
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

    toggleMenuFromDocument(event) {
        if (event.key == 'h') {
            document.querySelector('.menu-card').classList.add('dropdown-open');
            this.stopTimer();
            this.startTimer(document.querySelector('.menu-card'));
        } else if (event.shiftKey == true && event.ctrlKey == true && event.key == '1') {
            window.location = document.querySelector('.js-menu-home').href;
        } else if (event.shiftKey == true && event.ctrlKey == true && event.key == '2') {
            window.location = document.querySelector('.js-menu-settings').href;
         } else if (event.shiftKey == true && event.ctrlKey == true && event.key == '3') {
            window.location = document.querySelector('.js-menu-signout').href;
        } else if (event.key === 'Escape') {
            document.querySelector('.menu-card').classList.remove('dropdown-open');
            this.stopTimer();
        } else if (event.shiftKey == true && event.ctrlKey == true && event.key == 'F') {
            if (document.querySelector('#filter-repositories')) {
                document.querySelector('#filter-repositories').focus();
            }
        }
    }

    closeMenu(event) {
        this.startTimer(this.menuTarget);
    }

    closeMenuWithoutDelay(event) {
        if (event.key === 'Escape') {
            this.menuTarget.classList.remove('dropdown-open');
            this.stopTimer();
        } else if (event.key == 'h') {
            this.menuTarget.classList.add('dropdown-open');
            this.stopTimer();
            this.startTimer(document.querySelector('.menu-card'));
        } else if (event.shiftKey == true && event.ctrlKey == true && event.key == '1'){
            window.location = document.querySelector('.js-menu-home').href;
        } else if (event.shiftKey == true && event.ctrlKey == true && event.key == '2'){
            window.location = document.querySelector('.js-menu-settings').href;
        } else if (event.shiftKey == true && event.ctrlKey == true && event.key == '3'){
            window.location = document.querySelector('.js-menu-signout').href;
        }
    }

    disconnect() {
        this.stopTimer();
    }
}
