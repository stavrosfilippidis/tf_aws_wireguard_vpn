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
    - name: wg-quick@wg0.service
      enabled: true
    - name: 'prometheus-wireguard-exporter.service'
      enabled: yes
      contents: |
        [Unit]
        Description=Wireguard Prometheus exporter
        After=network-online.target
        Wants=network-online.target

        [Service]
        TimeoutStartSec=0
        ExecStartPre=-/bin/podman kill prometheus-wireguard-exporter
        ExecStartPre=-/bin/podman rm prometheus-wireguard-exporter
        ExecStartPre=/bin/podman pull ${var.wireguard_prometheus_exporter_image_repository}:${var.wireguard_prometheus_exporter_image_version}
        ExecStart=/bin/podman run --init --net=host --cap-add=NET_ADMIN --name prometheus-wireguard-exporter --privileged --security-opt label=disable -v /etc/wireguard/:/etc/wireguard/ ${var.wireguard_prometheus_exporter_image_repository}:${var.wireguard_prometheus_exporter_image_version} -i wg0 -n /etc/wireguard/ -p ${var.wireguard_prometheus_port}
        User=core
        Group=core 
        Restart=always
        RestartSec=1min
        [Install]
        WantedBy=multi-user.target

    - name: 'node-exporter.service' 
      enabled: true 
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
  directories:    
    - path: /var/home/core/.wg-easy
      mode: 0766  
      user: 
        name: core 
      group: 
        name: core
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
          
    - path: /etc/sysctl.d/90-ipv4-ip-forward.conf
      mode: 0644
      contents:
        inline: |
          net.ipv4.ip_forward = 1

    - path: /etc/sysctl.d/90-ipv6-ip-forwarding.conf
      mode: 0644
      contents:
        inline: |
          net.ipv6.conf.all.forwarding = 1

    - path: /etc/wireguard/wg0.conf
      mode: 0777
      user:
        name: core 
      group:
        name: core
      contents:
        inline: |
          [Interface]
          PrivateKey = 0P3jkDge92PFCwGNR/++lE7h3abYxMwJtBeYva00eUY=
          Address = 10.8.0.1/24
          ListenPort = 51820
          PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o ens5 -j MASQUERADE; ip6tables -A FORWARD -i wg0 -j ACCEPT; ip6tables -t nat -A POSTROUTING -o ens5 -j MASQUERADE
          PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o ens5 -j MASQUERADE; ip6tables -D FORWARD -i wg0 -j ACCEPT; ip6tables -t nat -D POSTROUTING -o ens5 -j MASQUERADE


          # Client: stav (92ec53a9-92e6-4809-8888-2910b1cb6698)
          [Peer]
          PublicKey = 50XfvMPSDUBuE6pLeEflgUbQxNZ5zkzFPu9uJ7Lq4z8=
          PresharedKey = P+geYqnRus+83pdMwiZAtkEDPP5MllI3JCmYU2hwhlM=
          AllowedIPs = 10.8.0.2/32
EOF
}

data "ct_config" "wireguard_vpn" {
  strict       = true
  pretty_print = false

  content      = local.ignition_wireguard_vpn
}

