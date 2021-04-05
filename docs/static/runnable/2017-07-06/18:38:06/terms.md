This document attempts to communicate the concepts outlined in the Verifiable
Claims space by using specific terms to discuss particular concepts. This
terminology is included below and linked to throughout the document to aid the
reader:

claim

     A statement made by an entity about a subject. A **verifiable claim** is a claim that is effectively tamper-proof and whose authorship can be cryptographically verified. 
credential curator

     A program, such as a storage vault or personal verifiable claim wallet, that stores and protects access to a holder's credentials and verifiable claims.
credential service

     A program, such as a credential storage vault or personal credential wallet, that stores and protects access to a holder's credentials. 
credential transport protocol

     A set of messages and protocols for issuing, storing, requesting, and transmitting credentials. 
credential validation

     The process that demonstrates the information in a credential is well-formed. 
credential verification

     The process that cryptographically demonstrates the authenticity of a credential. 
decentralized identifier

     A portable URI-based identifier, also known as a DID, that is associated with an entity. These identifiers are most often used in a credential and are associated with holders such that the credential itself can be easily ported from one identity provider to another without the need to reissue the credential. An example of a DID is: `did:b6922d8e-20df-4939-95cd-f79375979178`
decentralized identifier document

     A document that is accessible via an identifier registry and contains information related to a particular decentralized identifier such as the associated identity provider and public key information. 
digital signature

     A mathematical scheme for demonstrating the authenticity of a digital message. 
entity

     A thing with distinct and independent existence such as a person, organization, concept, or device. 
entity credential

     A set of one or more claims made by the same entity about a subject. 
holder

     An entity that is in control of one or more verifiable claims. Typically a holder is also the primary subject of the verifiable claims that they are holding. 
identity

     The means for keeping track of entities across contexts. Digital identities enable tracking and customization of entity interactions across digital contexts, typically using identifiers and attributes. Unintended distribution or use of identity information can compromise privacy. Collection and use of such information should follow the principles of minimal disclosure. 
inspector

     An entity that receives one or more verifiable claims for processing. 
entity document

     A Web-based document that contains statements about a particular entity. Entity documents MUST be accessible in JSON-LD [[!JSON-LD]] format and MAY be accessible in other RDF-compatible formats. 
entity owner

     An entity that is in control of a particular entity document. 
identity provider

     A software service that manages one or more identities and their associated credentials on behalf of an entity. It typically handles requests to store credentials issued by an issuer and to retrieve credentials when requested by a inspector. 
entity profile

     A set of entity credentials related to the same subject. An entity may have multiple entity profiles and each entity profile may contain claims issued by multiple entities. 
identifier registry

     Mediates the creation and verification of subject identifiers. 
issuer

     An entity that creates a verifiable claim, associates it with a particular subject, and transmits it to a holder. 
subject

     An entity which may have multiple entity profiles and about which claims may be made. 
user agent

     A program, such as a browser or other Web client, that mediates the communication between holders, issuers and inspectors. 

