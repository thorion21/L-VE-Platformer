README

@ World
@ Entity
@ Component
@ System


@ World

    Manages all entities and components and filters the according component
fields to match the system

@ Entity

    Every entity has an unique ID (even if multiple instances of the same
entity exists). Each entity is defined by its components. Entity class
only has its components mentioned and different parameters in order to
customize its personality.

@ Component

    Represents a so called 'container' which values represents its entity
attributes and also, tells the system that this entity is capable of doing
something.

@ System

    The system is responsible to identify and implement the behavior of
every associated component from an entity.
