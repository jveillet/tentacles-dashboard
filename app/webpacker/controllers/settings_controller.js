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
        var repos = document.querySelectorAll('.repo');
        var searchedTokens = searchElement.value.split(' ');
        var filteredNodes= [];
        var query = '';
        var queryFilters = [];

        // Separate the search query from the search filters
        searchedTokens.forEach(function(token) {
            if(token.includes('is:') || token.includes('org:')) {
                queryFilters.push(token.toLowerCase());
            } else {
                if(query.lenght > 0) {
                    query += ' ';
                }
                query += token;
            }
        });

        repos.forEach(function(element) {
            // Hide Repository
             element.parentElement.style.display = 'none';
            // Collect every repository that satisfies the search query (without filters)
            if(element.value.match(query)) {
                filteredNodes.push(element);
            }
        });

        // Go over the collected nodes
        filteredNodes.forEach(function(element) {
            if (queryFilters.length > 0) {
                // Match every filter to the data-filters attribute on the element
                var filters = element.getAttribute('data-filters').split(' ');
                var matchCount = 0;
                queryFilters.forEach(function(f) {
                    if(filters.includes(f)) {
                        matchCount ++;
                    }
                });
                // If the filters entered by the user matches the filters on the repository
                if(matchCount == queryFilters.length) {
                    element.parentElement.style.display = 'block';
                }
            } else {
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

