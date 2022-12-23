---
title: Cryptographic
lang: en
date: 2022-12-17 21:25:51
tags:
- hash
- security
category:
- computer
---

To ensure information security, we need the hash function to encrypt them.

# Type

Three types of hash functions:

- SHA1: sha-1 will generate 160-bit (20-byte) 40 int hash.
- SHA2: 256, 224, and so on...
- SHA3: Subset of the broader family of algorithms called [Keccak](https://en.wikipedia.org/wiki/SHA-3). Not included in this course.

<!-- more -->

# Salted

a password hashing technique that is used to secure passwords. In a salted hash, a unique random value, known as a "salt," is generated for each password and is stored along with the hashed password. This technology will make the password hard to be cracked especially for easy password. However, it will not 100% ensure the security.