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
                    var prStatus = document.getElementById(element.data.node.number);
                    if (prStatus) {
                        var commit = element.data.node.commits.nodes[0].commit;
                        if(commit.status) {
                            var state = commit.status.state;
                            prStatus.classList.remove('pr-card-status-pending');
                            prStatus.classList.add(`pr-card-status-${state.toLowerCase()}`);
                        }
                    }
                });
            });
    }

    startRefreshing() {
        // Use 1 800 000 for 30 min
        this.refreshTimer = setInterval(() => {
            this.commitTargets.forEach((element, index) => {
                element.classList.remove('pr-card-status-success', 'pr-card-status-failure', 'pr-card-status-pending');
                element.classList.add('pr-card-status-pending');

            });
            this.refreshPullRequests();
        }, 30000) // Every 30 seconds
    }

    stopRefreshing() {
        if (this.refreshTimer) {
            clearInterval(this.refreshTimer)
        }
    }
}

