Decentralized Identifiers (DIDs) are a new type of identifier intended for
verifiable digital identity that is "self-sovereign", i.e., fully under the
control of an entity and not dependent on a centralized registry, identity
provider, or certificate authority. DIDs resolve to DID Documents — simple
documents that contain all the metadata needed to interact with the DID.
Specifically, a DID Document typically contains at least three things. The
first is a set of mechanisms that may be used to authenticate as as a
particular DID (e.g. public keys, pseudonymous biometric templates, etc.). The
second is a set of authorization information that outlines which entities may
modify the DID Document. The third is a set of service endpoints, which may be
used to initiate trusted interactions with the entity. This document specifies
a common data model, format, and operations that all DIDs support.

Comments regarding this document are welcome. Please file issues directly on
[GitHub](https://github.com/w3c-ccg/did-spec/issues/), or send them to
[public-credentials@w3.org](mailto:public-credentials@w3.org)
([subscribe](mailto:public-credentials-request@w3.org?subject=subscribe),
[archives](https://lists.w3.org/Archives/Public/public-credentials/)).

Portions of the work on this specification have been funded by the United
States Department of Homeland Security's Science and Technology Directorate
under contracts HSHQDC-16-R00012-H-SB2016-1-002 and HSHQDC-17-C-00019. The
content of this specification does not necessarily reflect the position or the
policy of the U.S. Government and no official endorsement should be inferred.

Work on this specification has also been supported by the Rebooting the Web of
Trust community facilitated by Christopher Allen, Shannon Appelcline, Kiara
Robles, Brian Weller, Betty Dhamers, Kaliya Young, Manu Sporny, Drummond Reed,
and Joe Andrieu.

# Introduction

## Overview

Conventional [identity
management](https://en.wikipedia.org/wiki/Identity_management) systems are
based on centralized authorities such as corporate [directory
services](https://en.wikipedia.org/wiki/Directory_service), [certificate
authorities](https://en.wikipedia.org/wiki/Certificate_authority), or [domain
name registries](https://en.wikipedia.org/wiki/Domain_name_registry). From the
standpoint of cryptographic trust verification, each of these centralized
authorities serves as its own [root of
trust](https://en.wikipedia.org/wiki/Trust_anchor). To make identity
management work across these systems requires implementing [federated identity
management](https://en.wikipedia.org/wiki/Federated_identity).

The emergence of distributed ledger technology (DLT), sometimes referred to as
blockchain technology, provides the opportunity to implement fully
decentralized identity management. In this ecosystem, all entities share a
common root of trust in the form of a globally distributed ledger (or a
decentralized P2P network that provides similar capabilities).

The entities are identified by decentralized identifiers (DIDs). They may
authenticate via proofs (e.g. digital signatures, privacy-preserving
biometrics, etc.). DIDs point to DID Documents. A DID Document contains a set
of service endpoints for interacting with the entity. Following the dictums of
[Privacy by Design](https://en.wikipedia.org/wiki/Privacy_by_design), each
entity may have as many DIDs as necessary, to respect the entity’s desired
separation of identities, personas, and contexts.

To use a DID with a particular distributed ledger or network requires defining
a DID method in a separate DID method specification. A DID method specifies
the set of rules for how a DID is registered, resolved, updated, and revoked
on that specific ledger or network.

This design eliminates dependence on centralized registries for identifiers as
well as centralized certificate authorities for key management—the standard
pattern in hierarchical [PKI (public key
infrastructure](https://en.wikipedia.org/wiki/Public_key_infrastructure)).
Because DIDs reside on a distributed ledger, each entity may serve as its own
root authority—an architecture referred to as [ DPKI (decentralized
PKI)](https://github.com/WebOfTrustInfo/rebooting-the-web-of-
trust/blob/master/final-documents/dpki.pdf).

Note that DID methods may also be developed for identities registered in
federated or centralized identity management systems. For their part, all
types of identity systems may add support for DIDs. This creates an
interoperability bridge between the worlds of centralized, federated, and
decentralized identity.

## URIs, URLs, and URNs

DIDs have a foundation in URLs, so it's important to understand how the W3C
[clarified](https://www.w3.org/TR/uri-clarification/) the terms URI (Uniform
Resource Identifier), URL (Uniform Resource Locator), and URN (Uniform
Resource Name) in September 2001. The key difference between these three
categories of identifiers are:

  1. URI is the term for any type of identifier used to identify a resource on the Web. 
  2. URL is the term for any type of URI that can be resolved or de-referenced to locate a representation of a resource on the Web (e.g., Web page, file, image, etc.) 
  3. URN is the term for a specific type of URI intended to persistently identify a resource, i.e., an identifier that will never change no matter how often the resource moves, changes names, changes owners, etc. URNs are intended to last forever. 

## Motivations for DIDs

The growing need for decentralized identity has produced two specific
requirements for a new type of URL that still fits Web Architecture and has a
few additional requirements that more traditional URLs, like HTTP-based URLs,
do not have:

  1. The new type of URL SHOULD NOT require a centralized authority to register, resolve, update, or revoke the identifier. The overwhelming majority of URIs today are based on DNS names or IP addresses that depend on centralized authorities for registration and ultimate control. DIDs can be created and managed without any such authority. 
  2. A URL whose ownership and associated metadata, including public keys, can be cryptographically verified. Authentication via DIDs and DID Documents leverage the same public/private key cryptography as distributed ledgers. 

## The Role of Human-Friendly Identifiers

DIDs achieve global uniqueness without the need for a central registration
authority. This comes, however, at the cost of human memorability. The
algorithms capable of generating globally unique identifiers automatically
produce random strings of characters that have no human meaning. This
demonstrates the axiom about identifiers known as [Zooko’s
Triangle](https://en.wikipedia.org/wiki/Zooko%2527s_triangle) : "human-
meaningful, decentralized, secure—pick any two".

There are of course many use cases where it is desirable to discover a DID
when starting from a human-friendly identifier—a natural language name, a
domain name, or a conventional address for a DID owner such as a mobile
telephone number, email address, Twitter handle, or blog URL. However, the
problem of mapping human-friendly identifiers to DIDs (and doing so in a way
that can be verified and trusted) is out-of-scope for this specification.

Solutions to this problem (and there are many) should be defined in separate
specifications that reference this specification. It is strongly recommended
that such specifications carefully consider: (a) the numerous security attacks
based on deceiving users about the true human-friendly identifier for a target
entity, and (b) the privacy consequences of using human-friendly identifiers
that are inherently correlatable, especially if they are globally unique.

## Purpose of This Specification

The first purpose of this specification is to define the generic DID scheme
and a generic set of operations on DIDs that can be implemented for any
distributed ledger or network capable of supporting DIDs. The second purpose
of this specification to define the conformance requirements for a DID method
specification—a separate specification that defines a specific DID scheme and
specific set of DID record operations for a specific distributed ledger or
network.

Conceptually, the relationship of this specification and a DID method
specification is similar to the relationship of the IETF generic URI
specification ([RFC 3986](https://www.ietf.org/rfc/rfc3986.txt)) and a
specific [URI scheme](http://www.iana.org/assignments/uri-schemes/uri-
schemes.xhtml) (such as the http: and https: schemes specified in [RFC
7230](http://www.iana.org/go/rfc7230)). It is also similar to the relationship
of the IETF generic URN specification ([RFC
2141](https://www.ietf.org/rfc/rfc2141.txt)) and a specific URN namespace
definition (such as the UUID URN namespace defined in [RFC
4122](https://tools.ietf.org/html/rfc4122)). The difference is that a DID
method specification, in addition to defining a specific DID scheme, must also
specify the methods for reading, writing, and revoking DID records on the
network for which it is written.

For a list of DID Methods and their corresponding specifications, see Appendix
A.

# Design Goals

This section summarizes the design goals and principles of DID architecture.

Goal | Description  
---|---  
Decentralization  |  DID architecture should eliminate the requirement for
centralized authorities or single points of failure in identity management,
including the registration of globally unique identifiers, public verification
keys, service endpoints, and other metadata.  
Self-Sovereignty  |  DID architecture should give entities, both human and
non-human, the power to directly own and control their own digital identities
without the need to rely on external authorities.  
Privacy  |  DID architecture should enable entities to control the privacy of
their digital identities, including minimal, selective, and progressive
disclosure of attributes or other identity data.  
Security  |  DID architecture should enable sufficient security for relying
parties to depend on DID records for their required level of assurance.  
Proof-based  |  DID architecture should enable an entity to provide
cryptographic proof of authentication and proof of authorization rights.  
Discoverability  |  DID architecture should make it possible for entities to
discover DIDs for other entities to learn more about or interact with those
entities.  
Interoperability  |  DID architecture should use interoperable standards so
DID infrastructure can make use of existing tools and software libraries
designed for interoperability.  
Portability  |  DID architecture should be system and network-independent and
enable entitys to use their digital identities with any system that supports
DIDs and DID Methods.  
Simplicity  |  To meet these design goals, DID architecture should be (to
paraphrase Albert Einstein) "as simple as possible but no simpler".  
Extensibility  |  When possible, DID architecture should enable extensibility
provided it does not greatly hinder interoperability, portability, or
simplicity.  
  
# Simple Examples

This is a simple example of a DID:

    
    
    did:example:123456789abcdefghi
    

## Self-Managed DID Document

Following is an example of a DID Document that describes the DID above. This
example assumes that the entity that controls the private keys for this
identifier is authoritative for the DID Document.

Discussions at Rebooting the Web of Trust 5 resulted in consensus to remove
the `authorizationCapability` field to DID Method specs as it is unclear
whether all ledgers will find the field useful. The field will most likely be
moved into a DID Method specification or a separate DID Ledger Capabilities
document. The current consensus is to use object capabilities when possible to
express authorization to modify a DID Document.

    
    
    {
      "@context": "https://w3id.org/did/v1",
      "id": "did:example:123456789abcdefghi",
      "authorizationCapability": [{
        // this entity may update any field in this DID Document using any
        // authentication mechanism understood by the ledger
        "permission": "UpdateDidDocument",
        "entity": "did:example:123456789abcdefghi"
      }],
      "exampleService": "https://example.com/messages/8377464",
      "authenticationCredential": [{
        // this key can be used to authenticate as DID ...9938
        "id": "did:example:123456789abcdefghi#keys-1",
        "type": "RsaCryptographicKey",
        "owner": "did:example:123456789abcdefghi",
        "publicKeyPem": "-----BEGIN PUBLIC KEY...END PUBLIC KEY-----\r\n"
      }]
    }
    

## Example Delegate-Managed DID Document

The following example expresses a DID Document that describes the DID above
where control of the document is delegated to another entity. In this case the
DID Document describes a dependent—an entity who is not currently in a
position to control the authentication information for this identity. This DID
Document was created by a delegate—a separate entity with its own DID that
serves as a trustee for the dependent. Note that while this DID Document
asserts a set of service endpoints, it does not yet contain a set of key
descriptions because the dependent does not yet have its own set of private
keys.

    
    
    {
      "@context": "https://w3id.org/did/v1",
      "id": "did:example:123456789abcdefghi",
      "authorizationCapability": [{
        // this entity is a delegate and may update any field in this
        // DID Document using any authentication mechanism understood
        // by the ledger
        "permission": "UpdateDidDocument",
        "entity": "did:example:zxyvwtrkpn987654321"
      }],
      "exampleService": "https://example.com/messages/8377464",
      "authenticationCredential": [{
        // this biometric can be used to authenticate as DID ...fghi
        "id": "did:example:123456789abcdefghi/biometric/1",
        "type": "PseudonymousBiometricTemplate2017",
        "owner": "did:example:123456789abcdefghi",
        "biometricService": "https://example.com/authenticate"
        "biometricTemplateShard": "Mjk4MzQyO...5Mzg0MDI5Mwo="
      }]
    }
    

It will probably not be immediately obvious to most developers why delegation
is important. We should elaborate that there are use cases around DIDs that
are focused on people that do not have the technological means (yet) to
control a DID such as the unbanked, refugee use cases, child protection
services, and other people that are in delicate situations without ready
access to technology.

# Terminology

# Decentralized Identifiers (DIDs)

The concept of a globally unique decentralized identifier is not new;
[Universally Unique
Identifiers](https://en.wikipedia.org/wiki/Universally_unique_identifier)
(UUIDs) were first developed in the 1980s and later became a standard feature
of the Open Software Foundation’s [Distributed Computing
Environment](https://en.wikipedia.org/wiki/Distributed_Computing_Environment).
UUIDs achieve global uniqueness without a centralized registry service by
using an algorithm that generates 128-bit values with sufficient entropy that
the chance of collision are infinitesimally small. UUIDs are formally
specified in [[RFC4122]] as a specific type of Unified Resource Name (URN).

A DID is similar to a UUID except: (a) like a URL, it can be resolved or
dereferenced to a standard resource describing the entity (a DID Document—see
Section ), and (b) unlike a URL, the DID Document typically contains
cryptographic material that enables authentication of an entity associated
with the DID.

## The Generic DID Scheme

The generic DID scheme is a URI scheme conformant with [RFC
3986](https://www.ietf.org/rfc/rfc3986.txt). It consists of a DID followed by
an optional path and/or fragment. The term DID refers only to the identifier
conforming to the did rule in the ABNF below; when used alone, it does not
include a path or fragment. A DID that may optionally include a path and/or
fragment is called a DID reference.

Following is the ABNF definition using the syntax in [RFC
5234](https://tools.ietf.org/html/rfc5234) (which defines ALPHA as upper or
lowercase A-Z).

    
    
      did-reference      = did [ "/" did-path ] [ "#" did-fragment ]
      did                = "did:" method ":" specific-idstring
      method             = 1*methodchar
      methodchar         = %x61-7A / DIGIT
      specific-idstring  = idstring *( ":" idstring )
      idstring           = 1*idchar
      idchar             = ALPHA / DIGIT / "." / "-"
    

See sections 5.3 and 5.4 for the ABNF rules defining DID paths and fragments.

## Specific DID Method Schemes

A DID method specification MUST define exactly one specific DID scheme
identified by exactly one method name (the method rule in section 5.1). Since
DIDs are intended for decentralized identity infrastructure, it is NOT
RECOMMENDED to establish a registry of unique DID method names. Rather the
uniqueness of DID method names should be established via human consensus,
i.e., a specific DID scheme MUST use a method name that is unique among all
DID method names known to the specification authors at the time of
publication.

A list of known DID method names is included in Appendix A.

Since the method name is part of the DID, it SHOULD be as short as practical.
A method name of five characters or less is RECOMMENDED. The method name MAY
reflect the name of the distributed ledger or network to which the DID method
specification applies.

The DID method specification for the specific DID scheme MUST specify how to
generate the specific-idstring component of a DID. The specific-idstring value
MUST be able to be generated without the use of a centralized registry
service. The specific-idstring value SHOULD be globally unique by itself. The
fully qualified DID as defined by the did rule in section 5.1 MUST be globally
unique.

If needed, a specific DID scheme MAY define multiple specific specific-
idstring formats. It is RECOMMENDED that a specific DID scheme define as few
specific-idstring formats as possible.

## DID Paths

A generic DID path (the did-path rule in section 5.1) is identical to a URI
path and MUST conform to the ABNF of the path-rootless ABNF rule in [RFC
3986](https://www.ietf.org/rfc/rfc3986.txt). A DID path SHOULD be used to
address resources available via a DID service endpoint. See section 6.6.

A specific DID scheme MAY specify ABNF rules for DID paths that are more
restrictive than the generic rules in this section.

## DID Fragments

A generic DID fragment (the did-fragment rule in section 5.1) is identical to
a URI fragment and MUST conform to the ABNF of the fragment ABNF rule in [RFC
3986](https://www.ietf.org/rfc/rfc3986.txt). A DID fragment MUST be used only
as a method-independent pointer into the DID Document to identify a unique key
description or other DID Document component. To resolve this pointer, the
complete DID reference including the DID fragment MUST be used as the value of
the id key for the target JSON object.

A specific DID scheme MAY specify ABNF rules for DID fragments that are more
restrictive than the generic rules in this section.

## DID Normalization

For the broadest interoperability, DID normalization should be as simple and
universal as possible. Therefore:

  1. The did: scheme name MUST be lowercase. 
  2. The method name MUST be lowercase. 
  3. Case sensitivity and normalization of the value of the specific-idstring rule in section 5.1 MUST be defined by the governing DID method specification. 

## DID Persistence

A DID MUST be persistent and immutable, i.e., bound to an entity once and
never changed (forever). Ideally a DID would be a completely abstract
decentralized identifier (like a UUID) that could be bound to multiple
underlying distributed ledgers or networks over time, thus maintaining its
persistence independent of any particular ledger or network. However
registering the same identifier on multiple ledgers or networks introduces
extremely hard entityship and [start-of-
authority](https://en.wikipedia.org/wiki/List_of_DNS_record_types%23SOA) (SOA)
problems. It also greatly increases implementation complexity for developers.

To avoid these issues, it is RECOMMENDED that DID method specifications only
produce DIDs and DID methods bound to strong, stable ledgers or networks
capable of making the highest level of commitment to persistence of the DID
and DID method over time.

NOTE: Although not included in this version, future versions of this
specification may support a DID Document equivID property to establish
verifiable equivalence relations between DID records representing the same
identity owner on multiple ledgers or networks. Such equivalence relations can
produce the practical equivalent of a single persistent abstract DID. See
Future Work (section 11).

# DID Documents

If a DID is the index key in a key-value pair, then the DID Document is the
value to which the index key points. The combination of a DID and its
associated DID Document forms the root identity record for a decentralized
identity.

A DID Document MUST be a single JSON object conforming to [RFC
7159](https://tools.ietf.org/html/rfc7159). For purposes of this version of
the DID specification, the format of this JSON object is specified in [JSON-
LD](https://json-ld.org/), a format for mapping JSON data into the RDF
semantic graph model as defined by the [W3C JSON-LD 1.0
specification](https://www.w3.org/TR/json-ld/). Future versions of this
specification MAY specify other semantic graph formats for a DID Document such
as JXD (JSON XDI Data), a serialization format for the [ XDI graph
model](http://docs.oasis-open.org/xdi/xdi-core/v1.0/csd01/xdi-
core-v1.0-csd01.xml).

The following sections define the properties of this JSON object, including
whether these properties are required or optional.

## Context

JSON objects in JSON-LD format must include a JSON-LD context statement. The
rules for this statement are:

  1. A DID Document MUST have exactly one top-level context statement. 
  2. This statement MUST be the first line in the JSON object. (This is not strictly necessary under JSON-LD but required for DID Documents.) 
  3. The key for this property MUST be `@context`. 
  4. The value of this key MUST be the URL for the generic DID context as specified in Appendix B. 

Example (using an example URL):

    
    
    {
      "@context": "https://example.org/did/v1"
    }
    

DID method specifications MAY define their own JSON-LD contexts. However it is
NOT RECOMMENDED to define a new context unless necessary to properly implement
the method. Method-specific contexts MUST NOT override the terms defined in
the generic DID context listed in Appendix B.

## Primary DID

The primary DID is the primary index key for the DID Document, i.e., it is DID
described by DID Document. The rules for a primary DID are:

  1. A DID Document MUST have exactly one primary DID. 
  2. The key for this property MUST be id. 
  3. The value of this key MUST be a valid DID. 
  4. When this DID Document is registered with the target distributed ledger or network, the registered DID MUST match this primary DID value. 

Example:

    
    
    {
      "id": "did:example:21tDAKCERh95uGgKbJNHYp"
    }
    

## Delegates

The way that Delegates are handled is changing. The feature is still
supported, but via the `authorizationCapability` field rather than the more
specialized `guardian` field.

A delegate is an entity, such as a parent or aid organization, that creates
and maintains a DID Document for a dependent who is not in a position to hold
or control authentication credentials (e.g., cryptographic keys).

The rules for a delegate are:

  1. A DID Document that includes an `authenticationCredential` field (section 6.4) MAY list one or more delegates via the `authorizationCapability` field. 
  2. A DID Document that does not include an `authenticationCredential` MUST have a delegate. 
  3. The `authorizationCapability` field must contain a capability for the delegate that includes `UpdateDidDocument` as the capability, the DID of the delegate as the `entity`, and MAY include a more specific set of `authenticationCredential`s that the delegate MAY use to authenticate when updating the DID Document. 
  4. The delegate DID MUST resolve to a DID Document that has a `authenticationCredential` property containing at least one value i.e., the delegate relationships must not be nested. 

Example:

    
    
    {
      "@context": "https://w3id.org/did/v1",
      "id": "did:example:123456789abcdefghi",
      "authorizationCapability": [{
        // this entity is a delegate and may update any field in this
        // DID Document using any authentication mechanism understood
        // by the ledger
        "permission": "UpdateDidDocument",
        "entity": "did:example:zxyvwtrkpn987654321"
      }],
      "credentialRepositoryService": "https://vc.example.com/abcdef",
      "authenticationCredential": [{
        // this biometric can be used to authenticate as DID ...fghi
        "id": "did:example:123456789abcdefghi/biometric/1",
        "type": "PseudonymousBiometricTemplate2017",
        "owner": "did:example:123456789abcdefghi",
        "biometricService": "https://example.com/authenticate"
        "biometricTemplateShard": "Mjk4MzQyO...5Mzg0MDI5Mwo="
      }]
    }
    

## Authentication

Authentication is the mechanism by which an entity can cryptographically prove
that they are associated with a DID and DID Description. See section 9.2. Note
that Authentication is separate from Authorization because an entity may wish
to enable other entities to update the DID Document (for example, to assist
with key recovery as discussed in section 6.5) without enabling them to prove
ownership (and thus be able to impersonate the entity).

The rules for Authentication are:

  1. A DID Document MAY include a `authenticationCredential` property. 
  2. The value of the `authenticationCredential` property should be an array of proof mechanisms. 
  3. Each proof mechanism must include `id`, `type`, and `owner` properties. 
  4. Each proof mechanism MAY be a key description of a valid public key or verification key. A list of standard key descriptions is included in Appendix C. A new key description MAY also be defined by a DID method specification. 

Example:

    
    
    {
      "@context": "https://w3id.org/did/v1",
      "id": "did:example:123456789abcdefghi",
      "authenticationCredential": [{
        // this biometric can be used to authenticate as DID ...fghi
        "id": "did:example:123456789abcdefghi/biometric/1",
        "type": "PseudonymousBiometricTemplate2017",
        "owner": "did:example:123456789abcdefghi",
        "biometricService": "https://example.com/authenticate"
        "biometricTemplateShard": "Mjk4MzQyO...5Mzg0MDI5Mwo="
      }, {
        // this key can be used to authenticate as DID ...fghi
        "id": "did:example:123456789abcdefghi#keys-1",
        "type": "RsaCryptographicKey",
        "owner": "did:example:123456789abcdefghi",
        "publicKeyPem": "-----BEGIN PUBLIC KEY...END PUBLIC KEY-----\r\n"
      }]
    }
    

Caching and expiration of the keys in a DID Document
`authenticationCredential` property is entirely the responsibility of DID
resolvers and other clients. See Section .

## Authorization

Discussions at Rebooting the Web of Trust 5 resulted in consensus to remove
the `authorizationCapability` field as it is unclear whether all ledgers will
find the field useful. The field will most likely be moved into a DID Method
specification or a separate DID Ledger Capabilities document. Authorization
will most likely be a DID Method-specific definition.

Authorization is the mechanism by which an entity may give itself or other
entities permission to update the DID Document—for example to assist with key
recovery. Note that Authorization is separate from Authentication as explained
in section 6.4. This is particularly important for key recovery in the case of
key loss, when the entity no longer has access to their keys, or key
compromise, where the owner’s trusted third parties need to override malicious
activity by an attacker. See section 9.

Because the access control logic in the Authorization block must be
implemented by the target distributed ledger or network, a DID method
specification MUST include its own Authorization rules and processing logic.
It is RECOMMENDED that all DID method specifications support the generic
Authorization rules specified in this section. A DID method specification MAY
add its own method-specific Authorization rules.

The generic Authorization rules are:

  1. A DID Document MAY have exactly one property named `authorizationCapability` representing authorization information associated with the DID Document. 
  2. The value of this property SHOULD be an array. 
  3. The values of this array MUST be defined in a DID method specification and SHOULD follow a capabilities-based security model. 
  4. Updating the DID Document requires that the proof mechanism includes the `capability` property and the `UpdateDidDocument` value. 
  5. If an authorization rule does not specify a specific proof mechanism (such as a public key ID), then an update proof verified with any credential in the `authenticationCredential` property of the DID Document dereferenced from that DID MUST be considered valid for the proof mechanism. 

####  6.5.1 Enabling Multiple Entities to Update the DID Document

To assert that any single member of a group of other DID owners has permission
to update the DID Document, the `authorizationCapability` property array MAY
contain multiple JSON objects:

    
    
    {
      "@context": "https://w3id.org/did/v1",
      "id": "did:example:215cb1dc-1f44-4695-a07f-97649cad9938",
      "authorizationCapability": [{
        // this entity may update any field in this DID Document using any
        // authentication mechanism understood by the ledger
        "permission": "UpdateDidDocument",
        "entity": "did:example:z9f823hdf783h78fh2378"
      }, {
        // this entity may update the authenticationCredential field in this
        // DID Document as long as they authenticate with RsaSignature2017
        "permission": "UpdateDidDocument",
        "entity": "did:example:abvd73h285jf73hd73",
        "field": ["authenticationCredential"],
        "permittedProofType": [{
          "proofType": "RsaSignature2017"
        }]
      }]
    }
    

If at least one update signature from a DID in this array is verified, it MUST
be considered valid for Authorization.

####  6.5.2 Requiring Multiple Proofs

To assert that a set of members of a group of other DID owners must act
together to update the DID Document, the `authorizationCapability` property
array MAY contain a single JSON object:

    
    
    {
      "@context": "https://w3id.org/did/v1",
      "id": "did:example:215cb1dc-1f44-4695-a07f-97649cad9938",
      "authorizationCapability": [{
        // anyone may update the authenticationCredential and writeAuthorization
        // fields as long as they provide a specific multi-signature proof
        "permission": "UpdateDidDocument",
        "field": ["authenticationCredential", "writeAuthorization"],
        "permittedProofType": [{
          "proofType": "RsaSignature2017",
          "minimumSignatures": 3,
          "authenticationCredential": [{
            "id": "did:example:304ebc3e-7997-4bf4-a915-dd87e8455941#keys-123",
            "type": "RsaCryptographicKey",
            "owner": "did:example:304ebc3e-7997-4bf4-a915-dd87e8455941",
            "publicKeyPem": "-----BEGIN PUBLIC KEY...END PUBLIC KEY-----\r\n"
          }, {
            "id": "did:example:0f22346a-a360-4f3e-9b42-3366e348e941/keys/foo",
            "type": "RsaCryptographicKey",
            "owner": "did:example:0f22346a-a360-4f3e-9b42-3366e348e941",
            "publicKeyPem": "-----BEGIN PUBLIC KEY...END PUBLIC KEY-----\r\n"
          }, {
            "id": "did:example:a8d00377-e9f1-44df-a1b9-55072e13262a/keys/abc",
            "type": "RsaCryptographicKey",
            "owner": "did:example:a8d00377-e9f1-44df-a1b9-55072e13262a",
            "publicKeyPem": "-----BEGIN PUBLIC KEY...END PUBLIC KEY-----\r\n"
          }]
        }]
      }]
    }
    

## Service Endpoints

In addition to publication of authentication and authorization mechanisms, the
other primary purpose of a DID Document is to enable discovery of service
endpoints for the entity. A service endpoint may represent any type of service
the entity wishes to advertise, including decentralized identity management
services for further discovery, authentication, authorization, or interaction.
The rules for service endpoints are:

  1. A DID Document MAY have multiple properties representing service endpoints. 
  2. The service endpoint protocol SHOULD be published in an open standard specification. 
  3. The value of the service endpoint MUST be a valid URI conforming to [RFC 3986](https://www.ietf.org/rfc/rfc3986.txt) and normalized according to the rules in section 6 of [RFC 3986](https://www.ietf.org/rfc/rfc3986.txt) and to any normalization rules in its applicable URI scheme specification or a JSON-LD object. 

Example:

    
    
    {
      "credentialRepositoryService": "https://repository.example.com/123",
      "socialWebInboxService": {
        "id": "https://social.example.com/83hfh37dj",
        "description": "My public social inbox",
        "spamCost": {
          "amount": "0.50",
          "currency": "USD"
        }
      }
    }
    

See sections 9.1 and 9.3 for further security considerations regarding
authentication service endpoints.

## Created (Optional)

Standard metadata for identity records includes a timestamp of the original
creation. The rules for including a creation timestamp are:

  1. A DID Document MUST have zero or one property representing a creation timestamp. It is RECOMMENDED to include this property. 
  2. The key for this property MUST be created. 
  3. The value of this key MUST be a valid XML datetime value as defined in section 3.3.7 of [W3C XML Schema Definition Language (XSD) 1.1 Part 2: Datatypes](https://www.w3.org/TR/xmlschema11-2/). 
  4. This datetime value MUST be normalized to UTC 00:00 as indicated by the trailing "Z". 
  5. Method specifications that rely on DLTs SHOULD require time values that are after the known ["median time past" (defined in Bitcoin BIP 113)](https://github.com/bitcoin/bips/blob/master/bip-0113.mediawiki), when the DLT supports such a notion. 

Example:

    
    
    {
      "created": "2002-10-10T17:00:00Z"
    }
    

## Updated (Optional)

Standard metadata for identity records includes a timestamp of the most recent
change. The rules for including a updated timestamp are:

  1. A DID Document MUST have zero or one property representing an updated timestamp. It is RECOMMENDED to include this property. 
  2. The key for this property MUST be updated. 
  3. The value of this key MUST follow the formatting rules (3, 4, 5) from section 6.7. 

Example:

    
    
    {
      "updated": "2016-10-17T02:41:00Z"
    }
    

## Signature (Optional)

A signature on a DID Document is cryptographic proof of the integrity of the
DID Document according to either:

  1. The entity as defined in section 6.4, or if not present: 
  2. The delegate as defined in section 6.3. 

This signature is NOT proof of the binding between a DID and a DID Document.
See section 9.2. The rules for a signature are:

  1. A DID Document MAY have exactly one property representing a signature. 
  2. The key for this property MUST be signature. 
  3. The value of this key MUST be a valid JSON-LD signature as defined by [Linked Data Signatures](https://w3c-dvcg.github.io/ld-signatures/). 

Example:

    
    
    {
      "signature": {
        "type": "LinkedDataSignature2015",
        "created": "2016-02-08T16:02:20Z",
        "creator": "did:example:8uQhQMGzWxR8vw5P3UWH1ja#keys-1",
        "signatureValue": "QNB13Y7Q9...1tzjn4w=="
      }
    }
    

# DID Operations

To enable the full functionality of DIDs and DID Documents on a particular
distributed ledger or network (called the target system), a DID method
specification MUST specify how each of the following
[CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete)
operations is performed by a client. Each operation MUST be specified to the
level of detail necessary to build and test interoperable client
implementations with the target system. Note that, due to the specified
contents of DID Documents, these operations can effectively be used to perform
all the operations required of a CKMS (cryptographic key management system),
e.g.:

  * Key registration 
  * Key replacement 
  * Key rotation 
  * Key recovery 
  * Key expiration 

## Create

The DID method specification MUST specify how a client creates a DID
record—the combination of a DID and its associated DID Document—on the target
system, including all cryptographic operations necessary to establish proof of
ownership.

## Read/Verify

The DID method specification MUST specify how a client uses a DID to request a
DID Document from the target system, including how the client can verify the
authenticity of the response.

## Update

The DID method specification MUST specify how a client can update a DID record
on the target system, including all cryptographic operations necessary to
establish proof of control.

## Delete/Revoke

Although a core feature of distributed ledgers is immutability, the DID method
specification MUST specify how a client can revoke a DID record on the target
system, including all cryptographic operations necessary to establish proof of
revocation.

# DID Resolvers

A DID resolver is a software component with an API designed to accept requests
for DID lookups and execute the corresponding DID method to retrieve the
authoritative DID Document. To be conformant with this specification, a DID
resolver:

  1. SHOULD validate that a DID is valid according to its DID method specification, otherwise it should produce an error. 
  2. MUST conform to the requirements of the applicable DID method specification when performing DID resolution operations. 
  3. SHOULD offer the service of verifying the integrity of the DID Document if it is signed. 
  4. MAY offer the service of returning requested properties of the DID Document. 

# Security Considerations

NOTE TO IMPLEMENTERS: During the Implementer’s Draft stage, this section
focuses on security topics that should be important in early implementations.
The editors are also seeking feedback on threats and threat mitigations that
should be reflected in this section or elsewhere in the spec. As the root
identity records for decentralized identities, DIDs and DID Documents are a
vital component of decentralized identity management. They are also the
foundational building blocks of DPKI (decentralized public key infrastructure)
as an augmentation to conventional X.509 certificates. As such, DIDs are
designed to operate under the general Internet threat model used by many IETF
standards. We assume uncompromised endpoints, but allow messages to be read or
corrupted on the network. Protecting against an attack when a system is
compromised requires external key-signing hardware. See also section 6.5
regarding key revocation and recovery. For their part, the DLTs hosting DIDs
and DID Documents have special security properties for preventing active
attacks. Their design uses public/private key cryptography to allow operation
on passively monitored networks without risking compromise of private keys.
This is what makes DID architecture and decentralized identity possible.

## Requirements of DID Method Specifications

  1. DID method specifications MUST include their own Security Considerations sections. 
  2. This section MUST consider all the requirements mentioned in section 5 of [RFC 3552](https://tools.ietf.org/html/rfc3552) (page 27) for the DID operations defined in the specification. In particular: 

Discussions at Rebooting the Web of Trust 5 resulted in consensus to move
Authorization to DID Method specifications. It is currently expected that
there will be an attempt to create a generarlized authorization mechanism that
is build on object capabilities.

At least the following forms of attack MUST be considered: eavesdropping,
replay, message insertion, deletion, modification, and man-in-the-middle.
Potential denial of service attacks MUST be identified as well. If the
protocol incorporates cryptographic protection mechanisms, it should be
clearly indicated which portions of the data are protected and what the
protections are (i.e., integrity only, confidentiality, and/or endpoint
authentication, etc.). Some indication should also be given to what sorts of
attacks the cryptographic protection is susceptible. Data which should be held
secret (keying material, random seeds, etc.) should be clearly labeled. If the
technology involves authentication, particularly user-host authentication, the
security of the authentication method MUST be clearly specified.

  3. This section MUST also discuss, per Section 5 of [RFC 3552](https://tools.ietf.org/html/rfc3552), residual risks (such as the risks from compromise in a related protocol, incorrect implementation, or cipher) after threat mitigation has been deployed. 
  4. This section MUST provide integrity protection and update authentication for all operations required by Section 7 of this specification (DID Operations). 
  5. Where DID methods make use of peer-to-peer computing resources (such as with all known DLTs), the expected burdens of those resources SHOULD be discussed in relation to denial of service. 
  6. Method-specific endpoint authentication MUST be discussed. Where DID methods make use of DLTs with varying network topology, sometimes offered as "light node" or “ [thin client](https://en.bitcoin.it/wiki/Thin_Client_Security) ” implementations to reduce required computing resources, the security assumptions of the topology available to implementations of the DID method MUST be discussed. 
  7. DID methods MUST discuss the policy mechanism by which DIDs are proven to be uniquely assigned. A DID fits the functional definition of a URN as defined in [RFC 2141](https://tools.ietf.org/html/rfc2141) —a persistent identifier that is assigned once to a resource and never reassigned. In a security context this is particularly important since a DID may be used to identify a specific party subject to a specific set of authorization rights. 
  8. DID methods that introduce new authentication service endpoint types (section 6.6) SHOULD consider the security requirements of the supported authentication protocol. 

## Binding of Identity

####  9.2.1 Proving Ownership of a DID and DID Document

By itself, a verified signature on self-signed DID Document does not prove
ownership of a DID. It only proves the following:

  1. The DID Document has not been tampered with since it was registered. 
  2. The owner of the DID Document controlled the private key used for the signature at the time the signature was generated. 

Proving ownership of a DID, i.e., the binding between the DID and the DID
Document that describes it, requires a two step process:

  1. Resolving the DID to a DID Document according to its DID method specification. 
  2. Verifying that the id property of the resulting DID Document matches the DID that was resolved. 

It should be noted that this process proves ownership of a DID and DID
Document regardless of whether the DID Document is signed.

####  9.2.2 Proving Ownership of a Public Key

There are two methods for proving ownership of the private key corresponding
to a public key description in the DID Document: static and dynamic. The
static method is to sign the DID Document with the private key. This proves
ownership of the private key at a time no later than the DID Document was
registered. If the DID Document is not signed, ownership of a public key
described in the DID Document may still be proven dynamically as follows:

  1. Send a challenge message containing a public key description from the DID Document and a nonce to an appropriate service endpoint described in the DID Document. 
  2. Verify the signature of the response message against the public key description. 

####  9.2.3 Identity Owner Authentication and Verifiable Claims

A DID and DID Document do not inherently carry any
[PII](https://en.wikipedia.org/wiki/Personally_identifiable_information)
(personally-identifiable information). The process of binding a DID to the
real-world owner of an identity using claims about the owner is out of scope
for this specification. However this topic is the focus of the [verifiable
claims](https://w3c.github.io/vctf/) standardization work at the W3C (where
the term "DID" originated).

## Authentication Service Endpoints

If a DID Document publishes a service endpoint intended for authentication or
authorization of an entity (section 6.6), it is the responsibility of the
service endpoint provider, entity, and/or relying party to comply with the
requirements of the authentication protocol(s) supported at that service
endpoint.

## Non-Repudiation

Non-repudiation of DIDs and DID Document updates is supported under the
assumption that: (1) the entity is monitoring for unauthorized updates (see
section 9.5) and (2) the entity has had adequate opportunity to revoke
malicious updates according to the DID method's access control mechanism
(section 6.5). This capability is further supported if timestamps are included
(sections 6.7 and 6.8) and the target DLT system supports timestamps.

## Notification of DID Document Changes

One mitigation against unauthorized changes to a DID Document is monitoring
and actively notifying the entity when there are changes. This is analogous to
helping prevent account takeover on conventional username/password accounts by
sending password reset notifications to the email addresses on file. In the
case of a DID, where there is no intermediary registrar or account provider to
generate the notification, the following approaches are RECOMMENDED:

  1. Subscriptions. If the ledger or network on which the DID is registered directly supports change notifications, this service can be offered to DID owners. Notifications may be sent directly to the relevant service endpoints listed in an existing DID. 
  2. Self-monitoring. An entity may employ its own local or online agent to periodically monitor for changes to a DID Document. 
  3. Third-party monitoring. An entity may rely on a third party monitoring service, however this introduces another vector of attack. 

## Key and Signature Expiration

In a decentralized identity architecture, there are no centralized authorities
to enforce key or signature expiration policies. Therefore DID resolvers and
other client applications SHOULD validate that keys have not expired. Since
some use cases may have legitimate reasons why already-expired keys can be
extended, a key expiration SHOULD NOT prevent any further use of the key, and
implementations SHOULD attempt to update its status upon encountering it in a
signature.

## Key Revocation and Recovery

Section 7 specifies the DID operations that must be supported by a DID method
specification, including revocation of a DID Document by replacing it with an
updated DID Document. In general, checking for key revocation on DLT-based
methods is expected to be handled in a manner similar to checking the balance
of a cryptocurrency account on a distributed ledger: if the balance is empty,
the entire DID is revoked. DID method specifications SHOULD enable support for
a quorum of trusted parties to enable key recovery. Some of the facilities to
do so are suggested in section 6.5, Authorization. Note that not all DID
method specifications will recognize control from DIDs registered using other
DID methods and they MAY restrict third-party control to DIDs that use the
same method. Access control and key recovery in a DID method specification MAY
also include a time lock feature to protect against key compromise by
maintaining a second track of control for recovery. Further specification of
this type of control is a matter for future work (see section 11.4).

# Privacy Considerations

It is critically important to apply the principles of Privacy by Design to all
aspects of decentralized identity architecture, because DIDs and DID Documents
are—by design—administered directly by their owners. There is no registrar,
hosting company, or other intermediate service provider to recommend or apply
additional privacy safeguards. The authors of this specification have applied
all seven Privacy by Design principles throughout its development. For
example, privacy in this specification is preventative not remedial, and
privacy is an embedded default. Furthermore, decentralized identity
architecture by itself embodies principle #7, "Respect for user privacy—keep
it user-centric." This section lists additional privacy considerations that
implementers, delegates, and entitys should bear in mind.

## Requirements of DID Method Specifications

  1. DID method specifications MUST include their own Privacy Considerations sections, if only to point to the general privacy considerations in this section. 
  2. The DID method privacy section MUST discuss any subsection of section 5 of [RFC 6973t](https://tools.ietf.org/html/rfc6973) that could apply in a method-specific manner. The subsections to consider are: surveillance, stored data compromise, unsolicited traffic, misattribution, correlation, identification, secondary use, disclosure, exclusion. 

## Keep Personally-Identifiable Information (PII) Off-Ledger

If a DID method specification is written for a public ledger or network where
all DIDs and DID Documents will be publicly available, it is STRONGLY
RECOMMENDED that DID Documents contain no PII. All PII should be kept off-
ledger behind service endpoints under the control of the entity. With this
privacy architecture, PII may be exchanged on a private, peer-to-peer basis
using communications channels identified and secured by key descriptions in
DID records. This also enables entitys and relying parties to implement the
[GDPR](https://en.wikipedia.org/wiki/General_Data_Protection_Regulation)
[right to be forgotten](https://en.wikipedia.org/wiki/Right_to_be_forgotten),
as no PII will be written to an immutable ledger.

## DID Correlation Risks and Pseudonymous DIDs

Like any type of globally unique identifier, DIDs may be used for correlation.
Identity owners can mitigate this privacy risk by using pairwise unique DIDs,
i.e., by sharing a different private DID for every relationship. In effect,
each DID acts as a pseudonym. A pseudonymous DID need only be shared with more
than one party when the entity explicitly authorizes correlation between those
parties. If pseudonymous DIDs are the default, then the only need for a public
DID—a DID published openly or shared with a large number of parties—is when
the entity explicitly desires public identification.

## DID Document Correlation Risks

The anti-correlation protections of pseudonymous DIDs are easily defeated if
the data in the corresponding DID Documents can be correlated. For example,
using same public key descriptions or bespoke service endpoints in multiple
DID Documents can provide as much correlation information as using the same
DID. Therefore the DID Document for a pseudonymous DID SHOULD also use
pairwise-unique public keys and pairwise-unique service endpoints.

## Herd Privacy

When an entity is indistinguishable from others in the herd, privacy is
available. When the act of engaging privately with another party is by itself
a recognizable flag, privacy is greatly diminished. DIDs and DID methods
SHOULD work to improve herd privacy, particularly for those who legitimately
need it most. Choose technologies and human interfaces that default to
preserving anonymity and pseudonymity. In order to reduce [digital
fingerprints](https://en.wikipedia.org/wiki/Device_fingerprint), share common
settings across client implementations, keep negotiated options to a minimum
on wire protocols, use encrypted transport layers, and pad messages to
standard lengths.

# Future Work

## Upper Limits on DID Character Length

The current specification does not take a position on maximum length of a DID.
The maximum interoperable URL length is currently about 2K characters. QR
codes can handle about 4K characters. Clients using DIDs will be responsible
for storing many DIDs, and some methods would be able to externalize some of
their costs onto clients by relying on more complicated signature schemes or
by adding state into DIDs intended for temporary use. A future version of this
specification should set reasonable limits on DID character length to minimize
externalities.

## Equivalence

Including an equivalence property, such as equivID, in DID Documents whose
value is an array of DIDs would allow entitys to assert two or more DIDs that
represent the same entity. This capability has numerous uses, including
supporting migration between ledgers and providing forward compatibility of
existing DIDs to future DLTs. In theory, equivalent DIDs should have the same
identity rights, allowing [verifiable claims](https://w3c.github.io/vctf/)
made against one DID to apply to equivalent DIDs. Equivalence was not included
in the current specification due to the complexity of verifying equivalence
across different DLTs and different DID methods, and also of aggregating
properties of equivalent DID Documents. However equivalence should be
supported in a future version of this specification.

## Timestamps

Verifiable timestamps have significant utility for identity records. This is a
good fit for DLTs, since most offer some type of timestamp mechanism. Despite
some transactional cost, they are the most censorship-resistant transaction
ordering systems in the world, so they are nearly ideal for DID Document
timestamping. In some cases a DLT's immediate timing is approximate, however
their sense of ["median time past" (see Bitcoin BIP
113)](https://github.com/bitcoin/bips/blob/master/bip-0113.mediawiki%23Abstract)
can be precisely defined. A generic DID Document timestamping mechanism could
would work across all DLTs and might operate via a mechanism including either
individual transactions or transaction batches. The generic mechanism was
deemed out of scope for this version, although it may be included in a future
version of this specification.

## Time Locks and DID Document Recovery

Section 9.7 mentions one possible clever use of time locks to recover control
of a DID after a key compromise. The technique relies on an ability to
override the most recent update to a DID Document with Authorization applied
by an earlier version of the DID Document in order to defeat the attacker.
This protection depends on adding a [time lock (see Bitcoin BIP
65)](https://github.com/bitcoin/bips/blob/master/bip-0065.mediawiki%23Abstract)
to protect part of the transaction chain, enabling a Authorization block to be
used to recover control. We plan to add support for time locks in a future
version of this specification.

## Smart Signatures

Not all DLTs can support the Authorization logic in section 6.5. Therefore, in
this version of the specification, all Authorization logic must be delegated
to DID method specifications. A potential future solution is a [Smart
Signature](http://www.weboftrust.info/downloads/smart-signatures.pdf)
specification that specifies the code any conformant DLT may implement to
process signature control logic.

## Verifiable Claims

Although DIDs and DID Documents form a foundation for decentralized identity,
they are only the first step in describing an entity. The rest of the
descriptive power comes through collecting and selectively using [verifiable
claims](https://w3c.github.io/vctf/). Future versions of the specification
will describe in more detail how DIDs and DID Document can be integrated
with—and help enable—the verifiable claims ecosystem.

## Alternate Serializations and Graph Models

This version of the specification relies on JSON-LD and the RDF graph model
for expressing a DID Document. Future versions of this specification MAY
specify other semantic graph formats for a DID Document, such as JXD (JSON XDI
Data), a serialization format for the XDI graph model as defined by the [OASIS
XDI Core 1.0 specification](http://docs.oasis-open.org/xdi/xdi-
core/v1.0/csd01/xdi-core-v1.0-csd01.xml).

# References

    
    
    
    
          [ABNF] Augmented BNF for Syntax Specifications: ABNF. IETF RFC 5234.
            <https://tools.ietf.org/html/rfc5234>
    
    
          [IRI] Internationalized Resource Identifiers. IETF RFC 3987.
            <https://www.ietf.org/rfc/rfc3987.txt>
    
    
          [JSON] The JavaScript Object Notation (JSON) Data Interchange Format
            <https://tools.ietf.org/html/rfc7159>
    
    
          [JSON-LD] JSON-LD 1.0.
            <http://www.w3.org/TR/json-ld/>
    
    
          [LINKED-DATA-SIGNATURES] Draft Community Group Report
            <https://w3c-dvcg.github.io/ld-signatures/>
    
    
          [RFC 3552] Guidelines for Writing RFC Text on Security Considerations. IETF RFC 3552.
            <https://tools.ietf.org/html/rfc3552>
    
    
          [RFC 6973] Privacy Considerations for Internet Protocols. IETF RFC 6973.
            <https://tools.ietf.org/html/rfc6973>
    
    
          [RFC-KEYWORDS] Key words for use in RFCs to Indicate Requirement Levels. IETF RFC 2119.
            <https://www.ietf.org/rfc/rfc2119.txt>
    
    
          [SBIR-TOPIC] Applicability of Blockchain Technology to Privacy
            Respecting Identity Management. U.S Department of Homeland
            Security Small Business Innovation Research Grant.
            <https://www.sbir.gov/sbirsearch/detail/867797>
    
    
          [URI] Uniform Resource Identifiers. IETF RFC 3986.
            <https://www.ietf.org/rfc/rfc3986.txt>
    
    
          [URN] URN (Uniform Resource Name) Syntax. IETF RFC 2141.
            <https://tools.ietf.org/rfc/rfc2141.txt>
    
    
          [UUID] A Universally Unique IDentifier (UUID) URN Namespace. IETF RFC 4122.
            <https://www.ietf.org/rfc/rfc4122.txt>
    
    
          [VCWG] W3C Verifiable Claims Working Group.
            <https://www.w3.org/2017/vc/WG/>
    
    
          [XDI-CORE] OASIS XDI Core 1.0 Specification Working Draft 01
            <http://docs.oasis-open.org/xdi/xdi-core/v1.0/csd01/xdi-core-v1.0-csd01.xml>
    
    
          [XML-DATETIME] W3C XML Schema Definition Language (XSD) 1.1
            Part 2: Datatypes. W3C Recommendation.
            <https://www.w3.org/TR/xmlschema11-2/>
    
    
    
    

* * *

# Appendix A: Proposed DID Method Specifications

This table summarizes the DID method specifications currently in development.
The links will be updated as subsequent Implementer’s Drafts are produced.

Method Name

|

DLT or Network

|

Authors

|

Link  
  
---|---|---|---  
did:sov:  |  Sovrin  |  Sovrin Foundation  |  [Sovrin DID
Method](https://docs.google.com/document/d/1X7dWpVvskGRpk05yyPEMd1uqaJ9FnOzoeWMdwzdIFyU/edit#)  
did:btcr:  |  Bitcoin  |  Christopher Allen  |  
did:uport:  |  Ethereum  |  uPort  |  
did:cnsnt:  |  Ethereum  |  Consent  |  
did:v1:  |  Veres One  |  Digital Bazaar  |  [Veres One DID
Method](https://w3c-ccg.github.io/didm-veres-one/)  
  
# Appendix B: The Generic DID Context for JSON-LD

This JSON-LD document is the generic context for all DID Documents. See
section 6.1 for the rules for using this context.

For this implementer’s draft, the URL for this context is:

[ https://github.com/WebOfTrustInfo/rebooting-the-web-of-trust-
fall2016/blob/master/final-documents/did-
context-v1-draft-01.txt](https://github.com/WebOfTrustInfo/rebooting-the-web-
of-trust-fall2016/blob/master/final-documents/did-context-v1-draft-01.txt)

    
    
    {
      "@context": "https://w3id.org/did/v1",
      "id": "did:example:123456789abcdefghi",
      "authorizationCapability": [{
        // this entity may update any field in this DID Document using any
        // authentication mechanism understood by the ledger
        "permission": "UpdateDidDocument",
        "entity": "did:v1:215cb1dc-1f44-4695-a07f-97649cad9938"
      }, {
        // this entity may update the authenticationCredential field in this
        // DID Document as long as they authenticate with RsaSignature2017
        "entity": "did:v1:b5f8c320-f7ca-4869-85e6-a1bcbf825b2a",
        "permission": "UpdateDidDocument",
        "field": ["authenticationCredential"],
        "permittedProofType": [{
          "proofType": "RsaSignature2017"
        }]
      }, {
        // anyone may update the authenticationCredential and writeAuthorization
        // fields as long as they provide a specific multi-signature proof
        "permission": "UpdateDidDocument",
        "field": ["authenticationCredential", "writeAuthorization"],
        "permittedProofType": [{
          "proofType": "RsaSignature2017",
          "minimumSignatures": 3,
          "authenticationCredential": [{
            "id": "did:v1:304ebc3e-7997-4bf4-a915-dd87e8455941#keys-123",
            "type": "RsaCryptographicKey",
            "owner": "did:v1:304ebc3e-7997-4bf4-a915-dd87e8455941",
            "publicKeyPem": "-----BEGIN PUBLIC KEY...END PUBLIC KEY-----\r\n"
          }, {
            "id": "did:v1:0f22346a-a360-4f3e-9b42-3366e348e941/keys/foo",
            "type": "RsaCryptographicKey",
            "owner": "did:v1:0f22346a-a360-4f3e-9b42-3366e348e941",
            "publicKeyPem": "-----BEGIN PUBLIC KEY...END PUBLIC KEY-----\r\n"
          }, {
            "id": "did:v1:a8d00377-e9f1-44df-a1b9-55072e13262a/keys/abc",
            "type": "RsaCryptographicKey",
            "owner": "did:v1:a8d00377-e9f1-44df-a1b9-55072e13262a",
            "publicKeyPem": "-----BEGIN PUBLIC KEY...END PUBLIC KEY-----\r\n"
          }]
        }]
      }, {
        // this entity may issue credentials where the "issuer" field is this
        // DID Document's DID as long as this specific RSA key is used
        "permission": "IssueCredential",
        "entity": "did:example:123456789abcdefghi",
        "permittedProofType": [{
          "proofType": "RsaSignature2017",
          "authenticationCredential": [{
            "id": "did:example:123456789abcdefghi#keys-1",
            "type": "RsaCryptographicKey",
            "owner": "did:example:123456789abcdefghi",
            "publicKeyPem": "-----BEGIN PUBLIC KEY...END PUBLIC KEY-----\r\n"
          }
        }]
      }],
      "authenticationCredential": [{
        // this biometric can be used to authenticate as DID ...fghi
        "id": "did:example:123456789abcdefghi/biometric/1",
        "type": "PseudonymousBiometricTemplate2017",
        "owner": "did:example:123456789abcdefghi",
        "biometricService": "https://example.com/authenticate"
        "biometricTemplateShard": "Mjk4MzQyO...5Mzg0MDI5Mwo="
      }, {
        // this key can be used to authenticate as DID ...9938
        "id": "did:example:123456789abcdefghi#keys-1",
        "type": "RsaCryptographicKey",
        "owner": "did:example:123456789abcdefghi",
        "publicKeyPem": "-----BEGIN PUBLIC KEY...END PUBLIC KEY-----\r\n"
      }]
    }
    

# Appendix C: Standard Key Descriptions

As described in section 6, key description is a standard way to describe a
public key or verification key in JSON-LD. This appendix contains a list of
key descriptions recommended for use in DID Documents.

## RSA Keys

    
    
    {
      "id": "did:example:123456789abcdefghi#keys-1",
      "type": ["CryptographicKey", "RsaCryptographicKey"],
      "owner": "did:example:123456789abcdefghi",
      "publicKeyPem": "-----BEGIN PUBLIC KEY...END PUBLIC KEY-----\r\n"
    }
    

## EdDSA Keys

    
    
    {
      "id": "did:example:123456789abcdefghi/keys/2",
      "type": ["CryptographicKey", "EdDsaSAKey"],
      "owner": "did:example:123456789abcdefghi",
      "curve": "ed25519",
      "expires": "2017-02-08T16:02:20Z",
      "publicKeyBase64": "IOmA4R7TfhkYTYW87...CBMq2/gi25s="
    }
    

