# tf_aws_wireguard_vpn (WIP)

A VPN (Virtual Private Network) is a technology that allows you to create a secure and private network connection over the public internet. This can be useful for a variety of reasons, such as protecting your privacy, accessing content that is restricted in your country or region, or connecting securely to a remote network.

A typical VPN connection works by creating an encrypted tunnel between your device and a remote server, through which your internet traffic is routed. This means that anyone who intercepts your traffic, such as your internet service provider or a hacker on the same network, won't be able to see what you're doing online.

WireGuard is a newer VPN protocol that is designed to be faster, more secure, and easier to use than older protocols like OpenVPN and IPSec. It uses modern cryptographic techniques to ensure the security and privacy of your internet traffic, while also being lightweight and efficient enough to be used on mobile devices and other low-powered devices.

In practical terms, this means that if you use a VPN that uses WireGuard, you can expect faster and more reliable connections than you might get with other protocols. You may also find it easier to set up and configure, as it has fewer moving parts and is less complex than older protocols.

This allows you to keep your instances within EC2 closed to outside traffic on protocols like ssh and reduce the attack surface. 


![](https://github.com/stavrosfilippidis/architecture_diagrams/blob/main/vpn_access.png =250x250)



# TO DO 
- fetch the current ip and place it in the wireguard configuration
