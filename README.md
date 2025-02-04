# vBGP

Ce projet a pour but de renforcer les compétences en réseau en permettant la **simulation et la configuration d'un réseau** à l'aide de **GNS3** et d'images **Docker**.

## Sommaire
- [Partie 1 : GNS3 et Docker](#partie-1--gns3-et-docker)
- [Partie 2 : Découverte d’un VXLAN](#partie-2--découverte-dun-vxlan)
- [Partie 3 : Découverte de BGP avec EVPN](#partie-3--découverte-de-bgp-avec-evpn)
- [Concepts clés](#concepts-clés)

---

## Partie 1 : GNS3 et Docker

Dans cette première partie, nous devons **installer et configurer** **GNS3** et **Docker**, en utilisant deux types d'images :

- **Hôte** : Une image basée sur **Alpine**.
- **Commutateurs** : Une image intégrant **FRRouting (FRR)** pour la gestion du routage des paquets, avec les services suivants activés :
  - **BGPD** (BGP)
  - **OSPFD** (OSPF)
  - **IS-ISD** (IS-IS)  
Ces services sont activés via le fichier de configuration **daemons**.

---

## Partie 2 : Découverte d’un VXLAN

### Objectifs
- Comprendre la mise en place d’un **VXLAN** (**RFC 7348**).
- Maîtriser les différences entre **VXLAN statique** et **VXLAN multicast dynamique**.
- Valider la communication entre machines via **une analyse du trafic et des tables MAC**.

### Étapes de configuration

#### 1. Configuration initiale du VXLAN
- Mise en place d’un **VXLAN** avec un **VNI (VXLAN Network Identifier) = 10**.
- Attribution d'un nom personnalisable (**ex. : `vxlan10`**).
- Configuration d’un **bridge** nommé **`br0`** et des **interfaces Ethernet**.

#### 2. Passage au multicast dynamique
- Après la configuration en **mode statique**, il faut implémenter **une communication multicast dynamique**.
- Intégration d’un **groupe multicast** (par défaut **239.1.1.1**, modifiable).
- Cette approche **améliore la gestion du trafic réseau** et **augmente l'évolutivité** du VXLAN.

---

## Partie 3 : Découverte de BGP avec EVPN

Dans cette partie, nous explorons **BGP EVPN** (**RFC 7432**) pour simplifier la configuration réseau.

Nous réutilisons le **VXLAN avec ID 10** et mettons en place un **Route Reflector (RR)** pour **gérer automatiquement les échanges d’informations** entre les **VTEP (leafs)**.

---

## Concepts clés

### VXLAN (Virtual eXtensible LAN)
> Une technologie qui permet d'étendre un **réseau local (LAN)** sur un réseau **IP** en encapsulant les trames **Ethernet** dans des paquets **IP**.  
> Cela permet de connecter plusieurs réseaux virtuels sur une infrastructure existante **sans les limitations** d’un VLAN classique.

### VNI (VXLAN Network Identifier)
> Un identifiant unique pour **séparer les réseaux VXLAN**.  
> Similaire aux **VLANs**, mais avec une **capacité bien plus grande** (**jusqu'à 16 millions** contre **4096 pour les VLANs**).

### Modes de communication
- **Unicast** : Un émetteur envoie des données à **un seul récepteur**.
- **Multicast** : Un émetteur envoie des données à **un groupe de récepteurs**.

### BGP EVPN (Border Gateway Protocol - Ethernet VPN)
> Un protocole qui permet de **transporter des réseaux VXLAN** de manière efficace et évolutive.  
> Il échange **des informations de connectivité** (adresses **MAC, IP, VNI, routes**) entre équipements.

### VTEP (VXLAN Tunnel Endpoint)
> Un composant qui encapsule/décapsule les paquets réseau :  
> - **Encapsulation** : **Trame Ethernet** → **Paquet IP**  
> - **Décapsulation** : **Paquet IP** → **Trame Ethernet**

### OSPF (Open Shortest Path First)
> Un protocole de **routage dynamique** qui aide les équipements réseau à trouver **le chemin le plus rapide** pour acheminer les données.

### RR (Route Reflector - Réflecteur de routes)
> Un dispositif qui **centralise les informations de routage**, évitant que chaque équipement ait à s’échanger des routes **de manière pair-à-pair**.
