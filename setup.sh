#! /bin/bash
host=$1
ansible_user="hermes"
ssh_key_path="${HOME}/.ssh/$ansible_user"
host_pass=$(ansible-inventory --host $host | jq -r '.ansible_become_password // ""' )
[ -n "$host_pass" ] && sshpass_command="sshpass -p $host_pass" || echo "[$host]: No host password supplied"

echo "[$host]: Adding SSH fingerprint"
[[ -z $(ssh-keygen -F "$host") ]] && ssh-keyscan -H $host >> ~/.ssh/known_hosts || \
    echo "[$host]: Skipping...fingerprint already exist"

echo "[$host]: Generating SSH key pair"
[[ ! -f "$ssh_key_path" ]] && ssh-keygen -t ed25519 -f "$ssh_key_path" -N "" -C "id_ansible default $ansible_user" || \
    echo "[$host]: Skipping...SSH key pair already exists"

echo "[$host]: Adding public key as authorised hosts"
$sshpass_command ssh-copy-id -i "${ssh_key_path}.pub" $host 2>&1
   
echo "[$host]: Configure user > $ansible_user"
$sshpass_command ssh -q "$host" << EOF
[[ -z '$(id "$ansible_user")' ]] && \
echo $host_pass | sudo -S useradd -m $ansible_user && \
echo "[$host]: User created." || \
echo "[$host]: Skipping...user exists.";

echo $host_pass | sudo -S sh -c "echo '$ansible_user ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/$ansible_user" && \
echo "[$host]: User configured." || echo "[$host]: User configuration failed."
EOF