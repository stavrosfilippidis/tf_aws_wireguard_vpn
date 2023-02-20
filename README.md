# tf_aws_wireguard_vpn (WIP)

## What this repo provides

This terraform module creates a vpn instance on AWS EC2 that functions as bastion host for your infrastructure. 
It's leveraging Fedora Core OS as a reliable and secure base and comes preconfigured through systemd. 
Lower your attack surface and allow access only through a secured tunnel provided by Wireguard VPN.  

## What is a VPN  

A VPN (Virtual Private Network) is a technology that allows you to create a secure and private network connection over the public internet. This can be useful for a variety of reasons, such as protecting your privacy, accessing content that is restricted in your country or region, or connecting securely to a remote network.

A typical VPN connection works by creating an encrypted tunnel between your device and a remote server, through which your internet traffic is routed. This means that anyone who intercepts your traffic, such as your internet service provider or a hacker on the same network, won't be able to see what you're doing online.

## Technology used

WireGuard is a newer VPN protocol that is designed to be faster, more secure, and easier to use than older protocols like OpenVPN and IPSec. It uses modern cryptographic techniques to ensure the security and privacy of your internet traffic, while also being lightweight and efficient enough to be used on mobile devices and other low-powered devices.

In practical terms, this means that if you use a VPN that uses WireGuard, you can expect faster and more reliable connections than you might get with other protocols. You may also find it easier to set up and configure, as it has fewer moving parts and is less complex than older protocols.

This allows you to keep your instances within EC2 closed to outside traffic on protocols like ssh and reduce the attack surface. 

## Practicle Example 

The following graph showcases how you could split your network and than access through your Wireguard VPN instance. In this particular case your observability, metrics or kubernetes cluster would not be exposed on ports like ssh. 

![alt_text](https://github.com/stavrosfilippidis/architecture_diagrams/blob/main/vpn_access.png)
