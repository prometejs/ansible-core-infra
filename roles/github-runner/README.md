# GH Runner Role

## Config Options
### General 
| Option Name | Default | Required | Description |
|-------------|---------|----------|-------------|
| http_agent | stardust | false | name to appear as in connected server logs |
| user |  | true | user to run runner as |
| group |  | true | group to run runner as |

### Runner Installation
| Option Name | Default | Required | Description |
|-------------|---------|----------|-------------|
| version | 2.0.0 | true | runner software version to install |
| os | `{{ ansible_distribution | lower }}` | true | runner software supported OS |
| arch | `{{ ansible_architecture | lower }}` | true | runner software supported system architecture |
| pkg_ext | tar.gz | true | runner package extension to install |
| hash | | true | SHA256 hash of runner software for integrity check |

### Github Webhook
| Option Name | Default | Required | Description |
|-------------|---------|----------|-------------|
| repo | | true | repository to create webhook for .e.g. myorg/myrepo |
| webhook | | true | webhook url to post events |
| secret | | false | webhook secret |
| gh_user | | true | user to authenticate to GitHub as | 
| gh_token | | true | token to authenticate to GitHub with |
| insecure | | false | flag to indicate that GitHub should skip SSL verification when calling the hook. |
| state | present | false | whether the hook should be present or absent. |

### Runner 
| Option Name | Default | Required | Description |
|-------------|---------|----------|-------------|
| unattended | `false` | `false` | Disable interactive prompts for missing arguments. Defaults will be used for missing options `[--unattended]` |
| url | | `true` if unattended | Repository to add the runner to `[--url]` |
| token | | `true` if unattended | Registration token `[--token]` |
| name | actions-runner | `false` | Name of the runner to configure `[--name]` |
| runner_group | | `false` | Name of the runner group to add this runner to `[--runnergroup]` |
| labels | `self-hosted,{{ ansible_distribution | lower }},{{ ansible_architecture | lower }}` | `true` if --no-default-labels is used | Custom labels that will be added to the runner |
| no_default_labels | `false` | `false` | Disables adding the default labels: 'self-hosted,{Constants.Runner.Platform},{Constants.Runner.PlatformArchitecture}' |
| local | | `false` | Removes the runner config files from your local machine. Used as an option to the remove command |
| work | | `false` | Relative runner work directory `[--work]` |
| replace | `false` | `false` | Replace any existing runner with the same name `[--replace]` |
| pat | | `false` | GitHub personal access token with repo scope. Used for checking network connectivity when executing `.{separator}run.{ext} --check` `[--pat]` |
| disable_update | `false` | `false` | Disable self-hosted runner automatic update to the latest released version `[--disableupdate]` |
| ephemeral | `true` | `false` | Configure the runner to only take one job and then let the service un-configure the runner after the job finishes `[--ephemeral]` |

## Token Permissions
read more [here](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/autoscaling-with-self-hosted-runners#authentication-requirements)

## References
- [Runner Repo](https://github.com/actions/runner)
- [Runner Config](https://github.com/actions/runner/blob/9b457781d64d755b7a9630242d5f5bc321cb1d48/src/Runner.Listener/Runner.cs#L1080)
- [Runner Images](https://github.com/actions/runner-images)
- [Ansible Github Webhook](https://docs.ansible.com/ansible/latest/collections/community/general/github_webhook_module.html)