This section defines the terms used in this specification and throughout
decentralized identifier infrastructure. A link to these terms is included
whenever they appear in this specification.

authenticate

     Authentication is a process by which an entity can prove it has a specific attribute or controls a specific secret using one or more verification methods. With DIDs, a common example would be proving control of the cryptographic private key associated with a public key published in a DID document. 
binding

     A concrete mechanism used by a caller to invoke a DID resolver or a DID URL dereferencer. This could be a local command line tool, a software library, or a network call such as an HTTPS request. 
decentralized identifier (DID)

     A globally unique persistent identifier that does not require a centralized registration authority and is often generated and/or registered cryptographically. The generic format of a DID is defined in . A specific DID scheme is defined in a DID method specification. Many—but not all—DID methods make use of distributed ledger technology (DLT) or some other form of decentralized network. 
decentralized identity management

     [Identity management](https://en.wikipedia.org/wiki/Identity_management) that is based on the use of decentralized identifiers. Decentralized identity management extends authority for identifier generation, registration, and assignment beyond traditional roots of trust such as [X.500 directory services](https://en.wikipedia.org/wiki/X.500), the [Domain Name System](https://en.wikipedia.org/wiki/Domain_Name_System), and most national ID systems. 
decentralized public key infrastructure (DPKI)

     [Public key infrastructure](https://en.wikipedia.org/wiki/Public_key_infrastructure) that does not rely on traditional [certificate authorities](https://en.wikipedia.org/wiki/Certificate_authority) because it uses decentralized identifiers and DID documents to discover and verify public key descriptions. 
DID controller

     An entity that has the capability to make changes to a DID document. A DID might have more than one DID controller. The DID controller(s) can be denoted by the optional `controller` property at the top level of the DID document. Note that a DID controller might be the DID subject. 
DID delegate

     An entity to whom a DID controller has granted permission to use a verification method associated with a DID via a DID document. For example, a parent who controls a child's DID document might permit the child to use their personal device in order to authenticate. In this case, the child is the DID delegate. The child's personal device would contain the private cryptographic material enabling the child to authenticate using the DID. However, the child might not be permitted to add other personal devices without the parent's permission. 
DID document

     A set of data describing the DID subject, including mechanisms, such as cryptographic public keys, that the DID subject or a DID delegate can use to authenticate itself and prove its association with the DID. A DID document might have one or more different representations as defined in  or in the W3C DID Specification Registries [[DID-SPEC-REGISTRIES]]. 
DID fragment

     The portion of a DID URL that follows the first hash sign character (`#`). DID fragment syntax is identical to URI fragment syntax. 
DID method

     A definition of how a specific DID method scheme is implemented. A DID method is defined by a DID method specification, which specifies the precise operations by which DIDs and DID documents are created, resolved, updated, and deactivated. See . 
DID path

     The portion of a DID URL that begins with and includes the first forward slash (`/`) character and ends with either a question mark (`?`) character, a fragment hash sign (`#`) character, or the end of the DID URL. DID path syntax is identical to URI path syntax. See . 
DID query

     The portion of a DID URL that follows and includes the first question mark character (`?`). DID query syntax is identical to URI query syntax. See . 
DID resolution

     The process that takes as its input a DID and a set of resolution options and returns a DID document in a conforming representation plus additional metadata. This process relies on the "Read" operation of the applicable DID method. The inputs and outputs of this process are defined in . 
DID resolver

     A DID resolver is a software and/or hardware component that performs the DID resolution function by taking a DID as input and producing a conforming DID document as output. 
DID scheme

     The formal syntax of a decentralized identifier. The generic DID scheme begins with the prefix `did:` as defined in . Each DID method specification defines a specific DID method scheme that works with that specific DID method. In a specific DID method scheme, the DID method name follows the first colon and terminates with the second colon, e.g., `did:example:`
DID subject

     The entity identified by a DID and described by a DID document. Anything can be a DID subject: person, group, organization, physical thing, digital thing, logical thing, etc. 
DID URL

     A DID plus any additional syntactic component that conforms to the definition in . This includes an optional DID path (with its leading `/` character), optional DID query (with its leading `?` character), and optional DID fragment (with its leading `#` character). 
DID URL dereferencing

     The process that takes as its input a DID URL and a set of input metadata, and returns a resource. This resource might be a DID document plus additional metadata, a secondary resource contained within the DID document, or a resource entirely external to the DID document. The process uses DID resolution to fetch a DID document indicated by the DID contained within the DID URL. The dereferencing process can then perform additional processing on the DID document to return the dereferenced resource indicated by the DID URL. The inputs and outputs of this process are defined in . 
DID URL dereferencer

     A software and/or hardware system that performs the DID URL dereferencing function for a given DID URL or DID document. 
distributed ledger (DLT)

     A non-centralized system for recording events. These systems establish sufficient confidence for participants to rely upon the data recorded by others to make operational decisions. They typically use distributed databases where different nodes use a consensus protocol to confirm the ordering of cryptographically signed transactions. The linking of digitally signed transactions over time often makes the history of the ledger effectively immutable. 
public key description

     A data object contained inside a DID document that contains all the metadata necessary to use a public key or a verification key. 
resource

     As defined by [[RFC3986]]: "...the term 'resource' is used in a general sense for whatever might be identified by a URI." Similarly, any resource might serve as a DID subject identified by a DID. 
representation

     As defined for HTTP by [[RFC7231]]: "information that is intended to reflect a past, current, or desired state of a given resource, in a format that can be readily communicated via the protocol, and that consists of a set of representation metadata and a potentially unbounded stream of representation data." A DID document is a representation of information describing a DID subject. See . 
services

     Means of communicating or interacting with the DID subject or associated entities via one or more service endpoints. Examples include discovery services, agent services, social networking services, file storage services, and verifiable credential repository services. 
service endpoint

     A network address, such as an HTTP URL, at which services operate on behalf of a DID subject. 
Uniform Resource Identifier (URI)

     The standard identifier format for all resources on the World Wide Web as defined by [[RFC3986]]. A DID is a type of URI scheme. 
verifiable credential

     A standard data model and representation format for cryptographically-verifiable digital credentials as defined by the W3C Verifiable Credentials specification [[VC-DATA-MODEL]]. 
verifiable data registry

     A system that facilitates the creation, verification, updating, and/or deactivation of decentralized identifiers and DID documents. A verifiable data registry might also be used for other cryptographically-verifiable data structures such as verifiable credentials. For more information, see the W3C Verifiable Credentials specification [[VC-DATA-MODEL]]. 
verifiable timestamp

     A verifiable timestamp enables a third-party to verify that a data object existed at a specific moment in time and that it has not been modified or corrupted since that moment in time. If the data integrity could reasonably have been modified or corrupted since that moment in time, the timestamp is not verifiable. 
verification method

    

A set of parameters that can be used together with a process to independently
verify a proof. For example, a cryptographic public key can be used as a
verification method with respect to a digital signature; in such usage, it
verifies that the signer possessed the associated cryptographic private key.

"Verification" and "proof" in this definition are intended to apply broadly.
For example, a cryptographic public key might be used during Diffie-Hellman
key exchange to negotiate a shared symmetric key for encryption. This
guarantees the integrity of the key agreement process. It is thus another type
of verification method, even though descriptions of the process might not use
the words "verification" or "proof."

verification relationship

    

An expression of the relationship between the DID subject and a verification
method. An example of a verification relationship is .

Universally Unique Identifier (UUID)

     A type of globally unique identifier defined by [[RFC4122]]. UUIDs are similar to DIDs in that they do not require a centralized registration authority. UUIDs differ from DIDs in that they are not resolvable or cryptographically-verifiable. 

