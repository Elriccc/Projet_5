users:
  - name: openclassrooms
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: users, admin, docker
    shell: /bin/bash
    ssh_authorized_keys:
      - ${ssh_public_key}

ssh_pwauth: false
disable_root: true

package_update: true
package_upgrade: true

packages:
  - docker.io

runcmd:
  - systemctl enable docker
  - systemctl start docker
  - usermod -aG docker openclassrooms