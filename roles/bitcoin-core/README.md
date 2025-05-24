
# Bitcoin Core Ansible role

### Requirements

This role requires a user with `sudo` permissions to work properly.
List of officially supported operating systems:

| ID           | Name         | Status             |
|--------------|--------------|--------------------|
| `ubuntu2004` | Ubuntu 20.04 | :white_check_mark: |
| `ubuntu2204` | Ubuntu 22.04 | :white_check_mark: |

## Variables

You can change some variables to install this role to fit your needs. The default values to install the
Bitcoin node are the following ones:

| Name              	 | Value              	 |
|---------------------|----------------------|
| `bitcoin_user`    	 | `bitcoin`          	 |
| `bitcoin_group`   	 | `bitcoin`          	 |
| `bitcoin_version` 	 | `29.0`             	 |
| `bitcoin_arch`    	 | `x86_64-linux-gnu` 	 |
| `http_agent`    	   | `stardust` 	         |

> If you want to install Bitcoin into a Raspberry you need to change the architecture to `aarch64-linux-gnu`.

To configure the Bitcoin node, you can use the following variables:

| Name                   	     | Value           	 | Note                                             	 |
|------------------------------|-------------------|----------------------------------------------------|
| `bitcoin_data_dir`     	     | `/data/bitcoin` 	 | 	                                                  |
| `bitcoin_network`      	     | `main`          	 | Valid values are: `regtest`, `signet` and `test` 	 |
| `bitcoin_rpc_user`     	     | `bitcoin`       	 | 	                                                  |
| `bitcoin_rpc_password` 	     | `bitcoin`       	 | 	                                                  |
| `bitcoin_zmq_host`     	     | `127.0.0.1`     	 | 	                                                  |
| `bitcoin_bind`     	         | `127.0.0.1`     	 | 	                                                  |
| `bitcoin_rpc_bind`     	     | `127.0.0.1`     	 | This is where to expose the RPC server	            |
| `bitcoin_rpc_allow_ip`     	 | `127.0.0.1`     	 | This can be an IP or a range like `10.0.0.0/24`	   |

### GPG verification

By default, this installer uses `gpg` to verify the integrity and signature of the downloaded artifacts. This
behaviour is controlled by the `bitcoin_gpg_signer_pub_key` field. The content of this structure and default values
are the following:

```yaml
bitcoin_gpg_signer_pub_key:
  - laanwj
```

Include more [signer keys](https://github.com/bitcoin-core/guix.sigs/tree/main/builder-keys)  by adding their file name to the list

> I use the Guix attestations to verify the release. The data can be found on
> the [Bitcoin Github official repository](https://github.com/bitcoin-core/guix.sigs).
> If the release can't be trusted the role will fail the installation.

# Refernces
- https://bitcoincore.org/
- https://bitcoincore.org/en/download/
- https://github.com/bitcoin-core/guix.sigs
- https://github.com/bitcoin-core/guix.sigs/tree/main/builder-keys