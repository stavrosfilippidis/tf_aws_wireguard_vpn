locals {
  ignition_wireguard_vpn = <<EOF
variant: fcos
version: 1.4.0
passwd:
  users:
    - name: core     
      groups:
        - wheel
      ssh_authorized_keys: 
          - ${var.authorized_key}
systemd:
  units:
    - name: 'wg-quick-vpn.service'
      enabled: yes
      contents: |
        [Unit]
        Description=Wireguard VPN 
        After=network-online.target
        Wants=network-online.target
        [Service]
        TimeoutStartSec=0
        ExecStartPre=/usr/bin/podman pull ${var.wireguard_vpn_image}
        ExecStart=/usr/bin/podman run -d --name=wg-easy -e WG_HOST=${var.wireguard_wg_host} -e PASSWORD=${var.wireguard_password} \
                  -v /var/home/core/.wg-easy:/etc/wireguard \
                  -p ${var.wireguard_traffic_port}:${var.wireguard_traffic_port}/udp \
                  -p ${var.wireguard_dashboard_port}:${var.wireguard_dashboard_port}/tcp \
                  --cap-add=NET_ADMIN \
                  --cap-add=SYS_MODULE \
                  --sysctl="net.ipv4.conf.all.src_valid_mark=1" \
                  --sysctl="net.ipv4.ip_forward=1" \
                  --restart unless-stopped \
                  --privileged \
                  --net="host" \
                  --pid="host" \
                  ${var.wireguard_vpn_image}
        User=core
        Group=core 
        Restart=always
        RestartSec=1min
        [Install]
        WantedBy=multi-user.target

    - name: 'node-exporter.service' 
      enabled: yes 
      contents: | 
        [Unit]
        Description=Node exporter 
        After=network-online.target
        Wants=network-online.target
        StartLimitInterval=60
        StartLimitIntervalSec=60
        StartLimitBurst=3

        [Service]
        Logs_Directory=node_exporter
        TimeoutStartSec=0
        ExecStartPre=/usr/bin/podman pull ${var.node_exporter_image_name}
        ExecStart=/usr/bin/podman run --rm --net="host" --pid="host" -v "/:/host:ro,rslave" ${var.node_exporter_image_name} --path.rootfs=/host
        User=core
        Group=core 
        Restart=always
        RestartSec=1min 
        Restart=on-failure
        RestartSec=5
        TimeoutStopSec=30

        [Install]
        WantedBy=multi-user.target  
storage:
  files:
    - path: /etc/zincati/config.d/90-disable-auto-updates.toml
      mode: 0644
      user:
        name: root
      group:
        name: root
      contents:
        inline: |
          [updates]
          enabled = false
EOF
}

data "ct_config" "wireguard_vpn" {
  strict       = true
  pretty_print = false

  content      = local.ignition_wireguard_vpn
}

