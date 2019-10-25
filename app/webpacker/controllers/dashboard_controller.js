import { Controller } from 'stimulus';

export default class extends Controller {
    static targets = ['commit'];

    connect() {
        this.startRefreshing();
    }

    disconnect() {
        this.stopRefreshing()
    }

    refreshPullRequests() {
        fetch('/dashboard/refresh')
            .then((resp) => resp.json())
            .then(function(response) {
                response.pull_requests.forEach(function(element) {
                    var prStatus = document.getElementById(element.number);
                    if (prStatus) {
                        var commit = element.commits[element.commits.length - 1];
                        if(commit.status) {
                            var state = commit.status.state;
                            prStatus.classList.remove('pr-card__status--pending');
                            prStatus.classList.add(`pr-card__status--${state.toLowerCase()}`);
                        }
                    }
                });
            });
    }

    startRefreshing() {
        this.refreshTimer = setInterval(() => {
            this.commitTargets.forEach((element, index) => {
                element.classList.remove('pr-card__status--success', 'pr-card__status--failure', 'pr-card__status--pending');
                element.classList.add('pr-card__status--pending');

            });
            this.refreshPullRequests();
        }, 900000) // Every 15 minutes
    }

    stopRefreshing() {
        if (this.refreshTimer) {
            clearInterval(this.refreshTimer)
        }
    }
}

