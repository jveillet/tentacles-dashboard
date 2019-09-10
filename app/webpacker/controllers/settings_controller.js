import { Controller } from 'stimulus';

export default class extends Controller {
    static targets = ['alert'];

    onSuccess(event) {
        event.preventDefault();
        let [data, status, xhr] = event.detail;
        document.querySelector('.js-loading-indicator').classList.toggle('hidden');
        document.querySelector('.alert-header').innerHTML = '<i class="fas fa-check-circle space-right"></i>Marvellous!';
        document.querySelector('.alert-body').innerHTML = 'Your settings has been saved :)';
        this.alertTarget.classList.add('alert-success');
        this.hideAlert();
    }

    onSubmit() {
        document.querySelector('.alert').classList.remove('fade-out');
        document.querySelector('.js-loading-indicator').classList.toggle('hidden');
    }

    onError() {
        let [data, status, xhr] = event.detail;
        document.querySelector('.js-loading-indicator').classList.toggle('hidden');
        document.querySelector('.alert-header').innerHTML = '<i class="fas fa-exclamation-circle space-right"></i>Ouch!';
        document.querySelector('.alert-body').innerHTML = data.message;
        this.alertTarget.classList.add('alert-error');
        this.hideAlert();
    }

    hideAlert() {
        this.timer = setTimeout(function() {
            document.querySelector('.alert-header').innerHTML = '';
            document.querySelector('.alert-body').innerHTML = '';
            document.querySelector('.alert').classList.add('fade-out');
            document.querySelector('.alert').classList.remove('alert-success alert-error');
        }, 10000);
    }

    toggleRepository(event) {
        if(event.target.checked) {
            event.srcElement.parentElement.classList.add('repository-checked');
        } else {
            event.srcElement.parentElement.classList.remove('repository-checked');
        }
    }

    filterRepositories(event) {
        var searchElement = document.querySelector('.search');
        var searchedItem = searchElement.value;
        var repos = document.querySelectorAll('.repo');
        repos.forEach(function(element) {
            var item = element.value;
            element.parentElement.style.display = 'none';
            var result = item.match(searchedItem);
            if (result != null) {
                element.parentElement.style.display = 'block';
            }
        });
    }

    disconnect() {
        if (this.timer) {
            clearTimer(this.timer);
        }
    }
}

