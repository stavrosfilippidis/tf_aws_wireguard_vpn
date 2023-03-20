# tf_aws_wireguard_vpn (WIP)

## What this repo provides

This terraform module creates a vpn instance on AWS EC2 that functions as bastion host for your infrastructure. 
It's leveraging Fedora Core OS as a reliable and secure base and comes preconfigured through systemd. 
In practical terms, this means that if you use a VPN that uses WireGuard, you can expect faster and more reliable connections than you might get with other protocols. You may also find it easier to set up and configure, as it has fewer moving parts and is less complex than older protocols.
This allows you to keep your instances within EC2 closed to outside traffic on protocols like ssh and reduce the attack surface. 

It's technically also possible to use a ssh based bastion but there are some caveats: 
- lot's of ways to misconfigure 
- wireguard is easier to configure 

## What is a VPN  

A VPN (Virtual Private Network) is a technology that allows you to create a secure and private network connection over the public internet. This can be useful for a variety of reasons, such as protecting your privacy, accessing content that is restricted in your country or region, or connecting securely to a remote network.

A typical VPN connection works by creating an encrypted tunnel between your device and a remote server, through which your internet traffic is routed. This means that anyone who intercepts your traffic, such as your internet service provider or a hacker on the same network, won't be able to see what you're doing online.

## Technology used

**WireGuard** is a newer VPN protocol that is designed to be faster, more secure, and easier to use than older protocols like OpenVPN and IPSec. It uses modern cryptographic techniques to ensure the security and privacy of your internet traffic, while also being lightweight and efficient enough to be used on mobile devices and other low-powered devices.

Find out more under:  
https://www.wireguard.com/


**Fedora CoreOS** is a minimal, container-focused operating system designed for running containerized workloads securely and at scale. It is a lightweight and streamlined version of Fedora, which is a popular Linux distribution known for its focus on cutting-edge software and open source development.

Find out more under:   
https://docs.fedoraproject.org/en-US/fedora-coreos/

## Customization 

### Example 
There is an example folder within this repo that imports the module and customizes it with passing variables. 
Consider that some variables are mandatory (i.e. vpc id) and some others are optional (i.e. ami id). You have a range of options to customize for your needs. You might have a different network setup or different performance requirements. 

### Variables 

**Required**   
vpc_id  
subnet_ids   
wireguard_interface_address   
wireguard_private_key  

**Optional**  
module_name  
ami_id  
ami_owner  
wireguard_traffic_port  
wireguard_client_port  
wireguard_vpn_image  
wireguard_wg_host  
wireguard_password  
wireguard_prometheus_exporter_image_repository  
wireguard_prometheus_exporter_image_version  
wireguard_prometheus_port 
authorized_keys  
node_exporter_image_name 
instance_type 
instance_volume_size  
instance_desired_count   
instance_max_count  
instance_min_count  
wireguard_interface_name   
wireguard_authorized_peers   
wireguard_ingress_cidr_blocks   

The infrastructure created through this module can be adapted through variables.



